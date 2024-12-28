# 1. Collect all versions and schemas of the desired Talos Kubernetes Linux images.
# 2. Run module `talos_image` for each distinct version.
# 3. Instantiate all Talos VMs in parallel using `talos_vm`.
# 4. Await cluster deployment completion using `talos_cluster`.
# 5. Install cilium, openebs, cert-manager, sealed-secrets and all DNS related services.
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

# module "network_cilium" {
#   source = "./modules/network_cilium"

#   depends_on = [module.talos_cluster]
# }

# module "storage_openebs" {
#   source = "./modules/storage_openebs"

#   depends_on = [module.network_cilium]
# }

# module "cert_manager" {
#   source = "./modules/cert_manager"

#   depends_on = [module.storage_openebs]
# }

# module "sealed_secrets" {
#   source = "./modules/sealed_secrets"

#   depends_on = [module.storage_openebs]
# }

# module "dns_core" {
#   source = "./modules/dns_core"

#   depends_on = [
#     module.cert_manager,
#     module.sealed_secrets
#   ]
# }

# module "dns_external" {
#   source = "./modules/dns_external"

#   depends_on = [module.dns_core]
# }

# module "dns_pihole" {
#   source = "./modules/dns_pihole"

#   depends_on = [
#     module.dns_core,
#     module.dns_external
#   ]
# }