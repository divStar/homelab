/**
 * # Storage Management
 *
 * Handles the import and export of ZFS pools as well as directories.
 */
locals {
  # SSH connection settings for reuse
  ssh = {
    host        = var.ssh.host
    user        = var.ssh.user
    private_key = file(var.ssh.id_file)
  }

  # Storage data
  pools       = [for item in var.storage : item if item.type == "pool"]
  directories = [for item in var.storage : item if item.type == "directory"]

  storage_api_url = "https://${var.proxmox.host}:${var.proxmox.port}/api2/json/storage"
  storage_api_headers = {
    "Content-Type"  = "application/json"
    "Authorization" = "${var.token}"
  }
}

# Import ZFS pools
resource "ssh_resource" "import_zfs_pools" {
  # when = "create"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  for_each = { for pool in local.pools : pool.name => pool }

  commands = ["zpool import -f ${each.value.name}"]
}

# Export ZFS pools
resource "ssh_resource" "export_zfs_pools" {
  when = "destroy"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  for_each = { for pool in local.pools : pool.name => pool }

  commands = ["zpool export -f ${each.value.name}"]
}

# Add pools to Proxmox UI;
# resource will be removed using DELETE RESTAPI call upon being destroyed
resource "restapi_object" "add_pool_storage" {
  depends_on = [ssh_resource.import_zfs_pools]

  for_each = { for pool in local.pools : pool.name => pool }

  path         = "/storage"
  id_attribute = "storage"

  data = jsonencode({
    storage = each.value.name
    type    = "zfspool"
    pool    = each.value.name
    sparse  = 1
  })
}

# Add directories to Proxmox UI
# resource will be removed using DELETE RESTAPI call upon being destroyed
resource "restapi_object" "add_directory_storage" {
  depends_on = [restapi_object.add_pool_storage] # Updated dependency to use the new restapi resource

  for_each = { for dir in local.directories : dir.name => dir }

  path         = "/storage"
  id_attribute = "storage"

  data = jsonencode({
    storage = each.value.name
    type    = "dir"
    path    = "${each.value.path}"
    content = join(",", each.value.content_types)
  })
}