/**
 * # Cluster Setup
 *
 * This module and its sub-modules setup the Talos cluster on the Proxmox host.
 */

locals {
  nodes_with_iso = [
    for node in var.nodes : merge(node, {
      iso = module.talos_images[node.name].downloaded_iso_id
    })
  ]
}

# Downloads the calculated Talos images specified in the [`nodes`](#nodes-required) configurations.
module "talos_images" {
  source = "./modules/talos-download-image"

  proxmox = var.proxmox

  for_each = { for idx, node in var.nodes : node.name => node }

  talos_linux_version = var.talos_linux_version
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
  talos_linux_version = var.talos_linux_version

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
  talos_linux_version        = var.talos_linux_version
  target_kube_version        = var.target_kube_version
  step_ca_host               = var.step_ca_host

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
  talos_linux_version        = var.talos_linux_version
  talos_machine_secrets      = module.talos_cluster_prepare.machine_secrets
  talos_client_configuration = module.talos_cluster_prepare.client_configuration

  nodes = [for node in var.nodes : {
    name         = node.name
    ip           = node.ip
    machine_type = node.machine_type
  }]
}

# Pre-fetch all the Cilium CRDs, that need to be installed beforehand;
# replace their `<VERSION>` placeholder (if it exists) with `var.cilium_version`.
data "http" "cilium_crds_pre_install" {
  for_each = toset(var.cilium_crds)

  url = replace(each.value, "<VERSION>", var.cilium_version)
}

# Installs [`Cilium`](httpshttps://github.com/cilium/cilium) CNI,
# which is a networking, observability, and security solution with an eBPF-based dataplane.
module "cilium" {
  source     = "../common/modules/helm-terraform-installer"
  depends_on = [module.talos_cluster_ready]

  chart_name    = "cilium"
  chart_repo    = "https://helm.cilium.io"
  chart_version = var.cilium_version
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
      templatefile("${path.module}/files/cilium.post-install.ip-pool.yaml.tftpl", {
        namespace = var.cilium_namespace
        lb_cidr   = var.cluster.lb_cidr
      }),
      templatefile("${path.module}/files/cilium.post-install.l2-policy.yaml.tftpl", {
        namespace = var.cilium_namespace
      })
    ]
  )
}

# Installs [`cert-manager`](https://github.com/cert-manager/cert-manager),
# which manages TLS certificates for workloads.
module "cert_manager" {
  source     = "../common/modules/helm-terraform-installer"
  depends_on = [module.cilium]

  chart_name    = "cert-manager"
  chart_repo    = "https://charts.jetstack.io"
  chart_version = var.cert_manager_version
  namespace     = var.cert_manager_namespace
  release_name  = "cert-manager-release"

  chart_values = file("${path.module}/files/cert-manager.values.yaml")
}

# Installs [`sealed-secrets`](https://github.com/bitnami-labs/sealed-secrets),
# which manages `SealedSecret` resources, en- and decrypting them as necessary.
module "sealed_secrets" {
  source     = "../common/modules/helm-terraform-installer"
  depends_on = [module.cert_manager]

  chart_name    = "sealed-secrets"
  chart_repo    = "https://bitnami-labs.github.io/sealed-secrets"
  chart_version = var.sealed_secrets_version
  namespace     = var.sealed_secrets_namespace
  release_name  = "sealed-secrets-release"
}

# Sets up a `ClusterIssuer` resource based on the provided ACME information.
module "k8s_ca" {
  source     = "./modules/core-setup-k8s-ca"
  depends_on = [module.sealed_secrets]

  secret_namespace          = var.cert_manager_namespace
  acme_contact              = var.acme_contact
  acme_server_directory_url = var.acme_server_directory_url
  step_ca_host              = var.step_ca_host
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
  depends_on = [module.k8s_ca]

  chart_name    = "external-dns"
  chart_repo    = "oci://registry-1.docker.io/bitnamicharts"
  chart_version = var.external_dns_version
  namespace     = var.external_dns_namespace
  release_name  = "external-dns-release"

  chart_values = templatefile("${path.module}/files/external-dns.values.yaml.tftpl", {
    external_dns_secret_name = var.external_dns_secret_name
    external_dns_namespace   = var.external_dns_namespace
  })

  pre_install_resources = [sealedsecret.external_dns_secret.yaml_content]
}

# Installs [`local-path-provisioner`](https://github.com/rancher/local-path-provisioner),
# which is used for [PersistentVolumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistent-volumes)
# and [PersistentVolumeClaims](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims).
module "local_path_provisioner" {
  source     = "../common/modules/helm-terraform-installer"
  depends_on = [module.k8s_ca]

  chart_name    = "local-path-provisioner"
  chart_repo    = "https://charts.containeroo.ch"
  chart_version = var.local_path_provisioner_version
  namespace     = var.local_path_provisioner_namespace
  release_name  = "local-path-provisioner-release"

  chart_values            = file("${path.module}/files/local-path-provisioner.values.yaml")
  is_privileged_namespace = true
}

# Exposes the [Cilium Hubble UI](https://docs.cilium.io/en/stable/observability/hubble/hubble-ui/),
# which allows to see a Service Map and inspect a variety of network traffic.
module "hubble_ui" {
  source     = "./modules/monitoring-expose-hubble-ui"
  depends_on = [module.external_dns]

  ca_issuer = module.k8s_ca.k8s_ca_issuer_name
}