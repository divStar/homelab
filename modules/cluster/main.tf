/**
 * # Cluster Setup
 *
 * This module and its sub-modules setup the Talos cluster on the Proxmox host.
 */

locals {
  versions = yamldecode(file("${path.module}/${var.versions_yaml}"))

  nodes_with_iso = [
    for node in var.nodes : merge(node, {
      iso = module.talos_images[node.name].downloaded_iso_id
    })
  ]

  traefik_chart_name   = "traefik"
  traefik_release_name = "traefik-release"
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
# replace their `<VERSION>` placeholder (if it exists) with `local.versions.cilium_version`.
data "http" "cilium_crds_pre_install" {
  for_each = toset(var.cilium_crds)

  url = replace(each.value, "<VERSION>", local.versions.cilium_version)
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
  target_kube_version        = local.versions.target_kube_version
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

  chart_name    = "cilium"
  chart_repo    = "https://helm.cilium.io"
  chart_version = local.versions.cilium_version
  namespace     = var.cilium_namespace
  release_name  = "cilium-release"

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
        namespace = var.cilium_namespace
        lb_cidr   = var.cluster.lb_cidr
      }),
      templatefile("${path.module}/files/cilium.cilium-l2-announcement-policy.post-install.yaml.tftpl", {
        namespace = var.cilium_namespace
      })
    ]
  )
}

# Installs [`sealed-secrets`](https://github.com/bitnami-labs/sealed-secrets),
# which manages `SealedSecret` resources, en- and decrypting them as necessary.
module "sealed_secrets" {
  source     = "../common/modules/helm-terraform-installer"
  depends_on = [module.cilium]

  chart_name    = "sealed-secrets"
  chart_repo    = "https://bitnami-labs.github.io/sealed-secrets"
  chart_version = local.versions.sealed_secrets_version
  namespace     = var.sealed_secrets_namespace
  release_name  = "sealed-secrets-release"
}

# Creates an `external-dns` secret, that contains credentials to access a external DNS system (PiHole in this case).
resource "sealedsecret" "external_dns_secret" {
  depends_on = [module.sealed_secrets]

  name      = var.external_dns_secret_name
  namespace = var.external_dns_namespace

  data = yamldecode(templatefile("${path.module}/files/secret_external-dns-secret.yaml.tftpl", {
    external_dns_secret_name = var.external_dns_secret_name
    external_dns_namespace   = var.external_dns_namespace
  })).data
}

# Installs [`external-dns`](https://github.com/kubernetes-sigs/external-dns),
# which allows to forward requests about adding or removing `CNAME` and `A`/`AAAA` records to a given DNS (PiHole in this case)
# when a such a service is deployed (add) or destroyed (remove).
module "external_dns" {
  source     = "../common/modules/helm-terraform-installer"
  depends_on = [module.sealed_secrets]

  chart_name    = "external-dns"
  chart_repo    = "oci://registry-1.docker.io/bitnamicharts"
  chart_version = local.versions.external_dns_version
  namespace     = var.external_dns_namespace
  release_name  = "external-dns-release"

  chart_values = templatefile("${path.module}/files/external-dns.values.yaml.tftpl", {
    external_dns_secret_name = var.external_dns_secret_name
    external_dns_namespace   = var.external_dns_namespace
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

  chart_name    = "local-path-provisioner"
  chart_repo    = "https://charts.containeroo.ch"
  chart_version = local.versions.local_path_provisioner_version
  namespace     = var.local_path_provisioner_namespace
  release_name  = "local-path-provisioner-release"

  chart_values            = file("${path.module}/files/local-path-provisioner.values.yaml")
  is_privileged_namespace = true
}

# Installs [`Traefik v3`](https://github.com/traefik/traefik),
# which provides ingress controller with built-in ACME support and OIDC authentication plugin capabilities.
module "traefik" {
  source     = "../common/modules/helm-terraform-installer"
  depends_on = [module.external_dns, module.local_path_provisioner]

  chart_name    = local.traefik_chart_name
  chart_repo    = "https://helm.traefik.io/traefik"
  chart_version = local.versions.traefik_version
  namespace     = var.traefik_namespace
  release_name  = local.traefik_release_name

  chart_values = templatefile("${path.module}/files/traefik.values.yaml.tftpl", {
    acme_contact              = var.acme_contact
    acme_server_directory_url = var.acme_server_directory_url
    traefik_namespace         = var.traefik_namespace
    cluster_domain            = var.cluster.domain
    chart_name                = local.traefik_chart_name
    release_name              = local.traefik_release_name
  })

  pre_install_resources = [
    templatefile("${path.module}/files/traefik.configmap.step-ca-root-cert.yaml.tftpl", {
      traefik_namespace = var.traefik_namespace
      root_ca_content   = data.http.step_ca_root_pem.response_body
    })
  ]

  post_install_resources = [
    templatefile("${path.module}/files/traefik.middleware.redirect-to-dashboard.post-install.yaml.tftpl", {
      traefik_namespace = var.traefik_namespace
    }),
    templatefile("${path.module}/files/traefik.ingress-route.post-install.yaml.tftpl", {
      traefik_namespace   = var.traefik_namespace
      cluster_domain      = var.cluster.domain
      external_dns_target = "${var.cluster.name}.${var.cluster.domain}" # adding a CNAME record
    }),
    templatefile("${path.module}/files/cilium.ingress-route.post-install.yaml.tftpl", {
      cilium_namespace    = var.cilium_namespace
      cluster_domain      = var.cluster.domain
      external_dns_target = "${var.cluster.name}.${var.cluster.domain}" # adding a CNAME record
    })
  ]
}
