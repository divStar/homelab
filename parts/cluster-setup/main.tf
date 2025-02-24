# 1. Collect all versions and schemas of the desired Talos Kubernetes Linux images.
# 2. Run module `talos_image` for each distinct version.
# 3. Instantiate all Talos VMs in parallel using `talos_vm` with all patches (including Cilium).
# 4. Await cluster deployment completion using `talos_cluster`.
# 5. Install cert-manager
# 6. Install sealed-secrets.
# 7. Install PiHole.
# 8. Install external-dns.
locals {
  nodes_with_iso = [
    for node in var.nodes : merge(node, {
      iso = module.download_talos_images[node.name].downloaded_iso_id
    })
  ]
}

module "download_talos_images" {
  source = "./modules/talos_image_download"

  proxmox = var.proxmox

  for_each = { for idx, node in var.nodes : node.name => node }

  talos_version = each.value.talos_version
  schematic     = each.value.schematic
  factory_url   = each.value.factory_url
  platform      = each.value.platform
  arch          = each.value.arch
}

module "prepare_talos_cluster" {
  source     = "./modules/talos_cluster_prepare"
  depends_on = [module.download_talos_images]

  cluster = {
    name          = var.cluster.name
    talos_version = var.cluster.talos_version
  }

  nodes = [for node in var.nodes : {
    ip           = node.ip
    machine_type = node.machine_type
  }]
}

module "create_talos_vms" {
  source     = "./modules/talos_vm_create"
  depends_on = [module.prepare_talos_cluster]

  providers = {
    helm.templating = helm.templating
  }

  proxmox                    = var.proxmox
  cluster                    = var.cluster
  talos_machine_secrets      = module.prepare_talos_cluster.machine_secrets
  talos_client_configuration = module.prepare_talos_cluster.client_configuration
  cilium_version             = var.cilium_version

  for_each = { for idx, node in local.nodes_with_iso : node.name => node }

  node_description   = each.value.description
  node_tags          = each.value.tags
  node_name          = each.value.name
  node_host          = each.value.host
  node_machine_type  = each.value.machine_type
  node_bridge        = each.value.bridge
  node_ip            = each.value.ip
  node_mac_address   = each.value.mac_address
  node_vm_id         = each.value.vm_id
  node_cpu           = each.value.cpu
  node_ram_dedicated = each.value.ram_dedicated
  node_iso           = each.value.iso
  node_update_iso    = null
  node_datastore_id  = each.value.datastore_id
}

module "await_talos_cluster" {
  source     = "./modules/talos_cluster_await"
  depends_on = [module.create_talos_vms]

  cluster = {
    name          = var.cluster.name
    talos_version = var.cluster.talos_version
    endpoint      = var.cluster.endpoint
  }
  talos_machine_secrets      = module.prepare_talos_cluster.machine_secrets
  talos_client_configuration = module.prepare_talos_cluster.client_configuration

  nodes = [for node in var.nodes : {
    name         = node.name
    ip           = node.ip
    machine_type = node.machine_type
  }]
}

module "install_cert_manager" {
  source     = "./modules/core_cert_manager_install"
  depends_on = [module.await_talos_cluster]

  providers = {
    helm.deploying = helm.deploying
  }

  chart_version = var.cert_manager_version
  namespace     = var.cert_manager_namespace
}

module "install_sealed_secrets" {
  source     = "./modules/core_sealed_secrets_install"
  depends_on = [module.install_cert_manager]

  providers = {
    helm.deploying = helm.deploying
  }

  chart_version = var.sealed_secrets_version
  namespace     = var.sealed_secrets_namespace
}

module "k8s_ca_create" {
  source     = "./modules/core_k8s_cert_create"
  depends_on = [module.install_sealed_secrets]

  proxmox = {
    host     = var.proxmox.host
    ssh_user = var.proxmox.ssh_user
    ssh_key  = var.proxmox.ssh_key
  }

  proxmox_root_ca = var.proxmox_root_ca
  k8s_ca          = var.k8s_ca
}

module "k8s_ca_seal" {
  source     = "./modules/core_k8s_cert_seal"
  depends_on = [module.k8s_ca_create]

  k8s_ca_tls_crt   = module.k8s_ca_create.k8s_ca_tls_crt
  k8s_ca_tls_key   = module.k8s_ca_create.k8s_ca_tls_key
  secret_namespace = var.cert_manager_namespace
}

module "k8s_ca_install" {
  source     = "./modules/core_k8s_cert_install"
  depends_on = [module.k8s_ca_seal]

  sealed_k8s_ca_tls = module.k8s_ca_seal.sealed_k8s_ca_tls
}

module "install_longhorn" {
  source     = "./modules/storage_longhorn_install"
  depends_on = [module.k8s_ca_install]

  providers = {
    helm.deploying = helm.deploying
  }

  chart_version = var.longhorn_version
  nodes_count   = length([for node in var.nodes : true if node.machine_type == "worker"])
  ca_issuer     = module.k8s_ca_install.k8s_ca_issuer
}

module "expose_hubble_ui" {
  source     = "./modules/monitoring_hubble_expose"
  depends_on = [module.k8s_ca_install]

  ca_issuer = module.k8s_ca_install.k8s_ca_issuer
}

# module "install_pihole" {
#   source     = "./modules/dns_pihole_install"
#   depends_on = [module.install_sealed_secrets]

#   chart_version = var.pihole_version
# }

# module "dns_external" {
#   source = "./modules/dns_external"

#   depends_on = [module.dns_core]
# }