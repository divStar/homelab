/**
 * # Cluster Setup
 *
 * This module and its sub-modules setup the Talos cluster on the Proxmox host.
 */

locals {
  versions               = yamldecode(file("${path.module}/${var.versions_yaml}"))
  cilium                 = local.versions.cilium
  sealed_secrets         = local.versions.sealedSecrets
  external_dns           = local.versions.externalDns
  local_path_provisioner = local.versions.localPathProvisioner
  traefik                = local.versions.traefik

  nodes_with_iso = [
    for node in var.nodes : merge(node, {
      iso = module.talos_images[node.name].downloaded_iso_id
    })
  ]
}

# Download the `root_ca.crt` root CA certificate from Step CA.
data "http" "step_ca_root_pem" {
  url                = "https://${var.step_ca_host}/roots.pem"
  request_timeout_ms = 5000

  # Optional: Add retry logic
  retry {
    attempts     = 3
    min_delay_ms = 1000
    max_delay_ms = 3000
  }
}

# Pre-fetch all the Cilium CRDs, that need to be installed beforehand;
# replace their `<VERSION>` placeholder (if it exists) with `local.versions.cilium.chartVersion`.
data "http" "cilium_crds_pre_install" {
  for_each = toset(var.cilium_crds)

  url = replace(each.value, "<VERSION>", local.versions.cilium.chartVersion)
}

# Downloads the calculated Talos images specified in the [`nodes`](#nodes-required) configurations.
module "talos_images" {
  source = "./modules/talos-download-image"

  proxmox = var.proxmox

  for_each = { for idx, node in var.nodes : node.name => node }

  talos_linux_version = local.versions.talos_linux_version
  schematic           = each.value.schematic
  platform            = each.value.platform
  arch                = each.value.arch
}

# Prepares the cluster creation by generating the **Talos machine secrets**
# and creating the **Talos client cluster configuration**.
module "talos_cluster_prepare" {
  source     = "./modules/talos-prepare-cluster"
  depends_on = [module.talos_images]

  cluster_name        = var.cluster.name
  talos_linux_version = local.versions.talos_linux_version

  nodes = [for node in var.nodes : {
    ip           = node.ip
    machine_type = node.machine_type
  }]
}

# Creates the given Talos VMs, uses `for_each` on the list of [`nodes`](#nodes-required).
module "talos_vms" {
  source     = "./modules/talos-create-vm"
  depends_on = [module.talos_cluster_prepare]

  proxmox                    = var.proxmox
  cluster                    = var.cluster
  talos_machine_secrets      = module.talos_cluster_prepare.machine_secrets
  talos_client_configuration = module.talos_cluster_prepare.client_configuration
  talos_linux_version        = local.versions.talos_linux_version
  root_ca_certificate        = data.http.step_ca_root_pem.response_body

  for_each = { for idx, node in local.nodes_with_iso : node.name => node }

  node_description  = each.value.description
  node_tags         = each.value.tags
  node_name         = each.value.name
  node_host         = each.value.host
  node_machine_type = each.value.machine_type
  node_bridge       = each.value.bridge
  node_ip           = each.value.ip
  node_mac_address  = each.value.mac_address
  node_vm_id        = each.value.vm_id
  node_cpu          = each.value.cpu
  node_ram          = each.value.ram
  node_iso          = each.value.iso
  node_datastore_id = each.value.datastore_id
  node_iso_store_id = each.value.iso_store_id
  node_vfs_mappings = each.value.vfs_mappings
}

# Awaits the Talos cluster to become ready and available.
# <p>This module returns once all Talos [`nodes`](#nodes-required) are up and running.</p>
# <p><strong>Note:</strong> since the cluster is starting up without a CNI (Flannel is disabled), <strong>Kubernetes checks are skipped</strong>.
module "talos_cluster_ready" {
  source     = "./modules/talos-await-cluster"
  depends_on = [module.talos_vms]

  cluster = {
    name     = var.cluster.name
    endpoint = var.cluster.endpoint
  }
  talos_linux_version        = local.versions.talos_linux_version
  talos_machine_secrets      = module.talos_cluster_prepare.machine_secrets
  talos_client_configuration = module.talos_cluster_prepare.client_configuration
  skip_kubernetes_checks     = true

  nodes = [for node in var.nodes : {
    name         = node.name
    ip           = node.ip
    machine_type = node.machine_type
  }]
}

# Installs [`Cilium`](httpshttps://github.com/cilium/cilium) CNI,
# which is a networking, observability, and security solution with an eBPF-based dataplane.
module "cilium" {
  source     = "../common/modules/helm-terraform-installer"
  depends_on = [module.talos_cluster_ready]

  chart_name    = local.cilium.chartName
  chart_repo    = local.cilium.chartRepo
  chart_version = local.cilium.chartVersion
  namespace     = local.cilium.namespace
  release_name  = local.cilium.releaseName

  chart_values = templatefile("${path.module}/files/cilium.values.yaml.tftpl", {
    cluster_name             = var.cluster.name
    cilium_loadbalancer_cidr = var.cluster.lb_cidr
  })
  is_privileged_namespace = true

  chart_timeout = 300 # 5 minutes

  pre_install_resources = concat(
    values(data.http.cilium_crds_pre_install)[*].response_body,
    [
      templatefile("${path.module}/files/cilium.cilium-load-balancer-ip-pool.post-install.yaml.tftpl", {
        namespace = local.cilium.namespace
        lb_cidr   = var.cluster.lb_cidr
      }),
      templatefile("${path.module}/files/cilium.cilium-l2-announcement-policy.post-install.yaml.tftpl", {
        namespace = local.cilium.namespace
      })
    ]
  )
}

# Installs [`sealed-secrets`](https://github.com/bitnami-labs/sealed-secrets),
# which manages `SealedSecret` resources, en- and decrypting them as necessary.
module "sealed_secrets" {
  source     = "../common/modules/helm-terraform-installer"
  depends_on = [module.cilium]

  chart_name    = local.sealed_secrets.chartName
  chart_repo    = local.sealed_secrets.chartRepo
  chart_version = local.sealed_secrets.chartVersion
  namespace     = local.sealed_secrets.namespace
  release_name  = local.sealed_secrets.releaseName
}

# Creates an `external-dns` secret, that contains credentials to access a external DNS system (PiHole in this case).
resource "sealedsecret" "external_dns_secret" {
  depends_on = [module.sealed_secrets]

  name      = var.external_dns_secret_name
  namespace = local.external_dns.namespace

  data = yamldecode(templatefile("${path.module}/files/secret_external-dns-secret.yaml.tftpl", {
    external_dns_namespace   = local.external_dns.namespace
    external_dns_secret_name = var.external_dns_secret_name
  })).data
}

# Installs [`external-dns`](https://github.com/kubernetes-sigs/external-dns),
# which allows to forward requests about adding or removing `CNAME` and `A`/`AAAA` records to a given DNS (PiHole in this case)
# when a such a service is deployed (add) or destroyed (remove).
module "external_dns" {
  source     = "../common/modules/helm-terraform-installer"
  depends_on = [module.sealed_secrets]

  chart_name    = local.external_dns.chartName
  chart_repo    = local.external_dns.chartRepo
  chart_version = local.external_dns.chartVersion
  namespace     = local.external_dns.namespace
  release_name  = local.external_dns.releaseName

  chart_values = templatefile("${path.module}/files/external-dns.values.yaml.tftpl", {
    external_dns_namespace   = local.external_dns.namespace
    external_dns_secret_name = var.external_dns_secret_name
    cluster_name             = var.cluster.name
  })

  pre_install_resources = [sealedsecret.external_dns_secret.yaml_content]
}

# Installs [`local-path-provisioner`](https://github.com/rancher/local-path-provisioner),
# which is used for [PersistentVolumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistent-volumes)
# and [PersistentVolumeClaims](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims).
module "local_path_provisioner" {
  source     = "../common/modules/helm-terraform-installer"
  depends_on = [module.cilium]

  chart_name    = local.local_path_provisioner.chartName
  chart_repo    = local.local_path_provisioner.chartRepo
  chart_version = local.local_path_provisioner.chartVersion
  namespace     = local.local_path_provisioner.namespace
  release_name  = local.local_path_provisioner.releaseName

  chart_values            = file("${path.module}/files/local-path-provisioner.values.yaml")
  is_privileged_namespace = true
}

# Installs [`Traefik v3`](https://github.com/traefik/traefik),
# which provides ingress controller with built-in ACME support and OIDC authentication plugin capabilities.
module "traefik" {
  source     = "../common/modules/helm-terraform-installer"
  depends_on = [module.external_dns, module.local_path_provisioner]

  chart_name    = local.traefik.chartName
  chart_repo    = local.traefik.chartRepo
  chart_version = local.traefik.chartVersion
  namespace     = local.traefik.namespace
  release_name  = local.traefik.releaseName

  chart_values = templatefile("${path.module}/files/traefik.values.yaml.tftpl", {
    acme_contact              = var.acme_contact
    acme_server_directory_url = var.acme_server_directory_url
  })

  pre_install_resources = [
    templatefile("${path.module}/files/traefik.configmap.step-ca-root-cert.yaml.tftpl", {
      traefik_namespace = local.traefik.namespace
      root_ca_content   = data.http.step_ca_root_pem.response_body
    })
  ]

  post_install_resources = [
    templatefile("${path.module}/files/traefik.middleware.redirect-to-dashboard.post-install.yaml.tftpl", {
      traefik_namespace = local.traefik.namespace
    }),
    templatefile("${path.module}/files/traefik.ingress-route.post-install.yaml.tftpl", {
      traefik_namespace   = local.traefik.namespace
      cluster_domain      = var.cluster.domain
      external_dns_target = "${var.cluster.name}.${var.cluster.domain}" # adding a CNAME record
    }),
    templatefile("${path.module}/files/cilium.ingress-route.post-install.yaml.tftpl", {
      cilium_namespace    = local.cilium.namespace
      cluster_domain      = var.cluster.domain
      external_dns_target = "${var.cluster.name}.${var.cluster.domain}" # adding a CNAME record
    })
  ]
}
