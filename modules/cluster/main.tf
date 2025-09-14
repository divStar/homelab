/**
 * # Cluster Setup
 *
 * This module and its sub-modules setup the Talos cluster on the Proxmox host.
 */

locals {
  versions = yamldecode(file(abspath("${path.root}/${var.versions_yaml}")))
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

  retry {
    attempts     = 3
    min_delay_ms = 1000
    max_delay_ms = 3000
  }
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

# Handles the set up of the most basic infrastructure (CNI, ingress, certificates, etc.).
module "infrastructure" {
  source     = "./modules/infrastructure"
  depends_on = [module.talos_cluster_ready]

  root_ca_certificate = data.http.step_ca_root_pem.response_body
  cluster = {
    name    = var.cluster.name
    domain  = var.cluster.domain
    lb_cidr = var.cluster.lb_cidr
  }
}

# Handles the set up of platform services and functionality (CNPG operator, pgAdmin, Zitadel, etc.).
module "platform" {
  source     = "./modules/platform"
  depends_on = [module.infrastructure]

  root_ca_certificate = data.http.step_ca_root_pem.response_body
  cluster = {
    name    = var.cluster.name
    domain  = var.cluster.domain
    lb_cidr = var.cluster.lb_cidr
  }
  zitadel_admin_password = var.zitadel_admin_password
}