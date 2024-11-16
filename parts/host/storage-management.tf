/**
 * ## Storage Management
 *
 * Handles the import and export of ZFS pools as well as directories.
 */

locals {
  pools       = [for item in var.storages : item if item.type == "pool"]
  directories = [for item in var.storages : item if item.type == "directory"]

  storage_api_url = "https://${var.proxmox_configuration.host}:${var.proxmox_configuration.port}/api2/json/storage"
  storage_api_headers = {
    "Content-Type" = "application/json"
    "Authorization" = "${local.token}"
  }
}

# Import ZFS pools
resource "ssh_resource" "import_zfs_pools" {
  for_each = { for pool in local.pools : pool.name => pool }

  host        = local.ssh_config.host
  user        = local.ssh_config.user
  private_key = local.ssh_config.private_key

  # when = "create"

  commands = ["zpool import -f ${each.value.name}"]
}

resource "ssh_resource" "export_zfs_pools" {
  for_each = { for pool in local.pools : pool.name => pool }

  host        = local.ssh_config.host
  user        = local.ssh_config.user
  private_key = local.ssh_config.private_key

  when = "destroy"

  commands = ["zpool export -f ${each.value.name}"]
}

# Add pools to Proxmox UI; resource will be removed using DELETE RESTAPI call upon being destroyed
resource "restapi_object" "add_pool_storage" {
  for_each = { for pool in local.pools : pool.name => pool }

  depends_on = [ssh_resource.import_zfs_pools]

  path = "/storage"
  id_attribute = "storage"

  data = jsonencode({
    storage = each.value.name
    type    = "zfspool"
    pool    = each.value.name
    sparse  = 1
  })
}

# Add directories to Proxmox UI; resource will be removed using DELETE RESTAPI call upon being destroyed
resource "restapi_object" "add_directory_storage" {
  for_each = { for dir in local.directories : dir.name => dir }

  path = "/storage"
  id_attribute = "storage"
  
  data = jsonencode({
    storage = each.value.name
    type    = "dir"
    path    = "${each.value.path}"
    content = join(",", each.value.content_types)
  })

  depends_on = [restapi_object.add_pool_storage]  # Updated dependency to use the new restapi resource
}