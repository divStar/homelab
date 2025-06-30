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
}

# Import ZFS pools
resource "ssh_resource" "import_zfs_pools" {
  # when = "create"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  for_each = toset(var.storage_pools)

  commands = ["zpool import -f ${each.value}"]
}

# Export ZFS pools
resource "ssh_resource" "export_zfs_pools" {
  when = "destroy"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  for_each = toset(var.storage_pools)

  commands = ["zpool export -f ${each.value}"]
}
