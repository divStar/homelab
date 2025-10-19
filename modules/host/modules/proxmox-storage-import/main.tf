/**
 * # Proxmox storage import
 *
 * Imports existing storage into Proxmox.
 */
locals {
  # SSH connection settings for reuse
  ssh = {
    host        = var.ssh.host
    user        = var.ssh.user
    private_key = file(var.ssh.id_file)
  }
}

# Imports a directory with given types into Proxmox
resource "ssh_resource" "import_proxmox_storage" {
  # when = "create"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  for_each = var.storage_directories

  commands = [
    "pvesh create /storage --storage ${each.key} --type dir --path ${each.value.path} --content ${each.value.content}"
  ]

  timeout = "20s"
}

# Removes a directory from Proxmox
resource "ssh_resource" "remove_proxmox_storage" {
  when = "destroy"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  for_each = var.storage_directories

  commands = [
    "pvesh delete /storage/${each.key}"
  ]

  timeout = "20s"
}
