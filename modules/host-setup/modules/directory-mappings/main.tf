/**
 * # Directory mappings
 *
 * Handles the directory mappings of particular resources (e.g. file shares).
 * These mapped directories can then be used e.g. using `virtiofs` "pass-through" to VMs.
 */
locals {
  # SSH connection settings for reuse
  ssh = {
    host        = var.ssh.host
    user        = var.ssh.user
    private_key = file(var.ssh.id_file)
  }
}

resource "ssh_resource" "directory_mappings" {
  when = "create"

  for_each = { for mapping in var.directory_mappings : mapping.id => mapping }


  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  timeout = "30s"

  commands = [
    "pvesh create /cluster/mapping/dir --id ${each.value.id} --map node=${var.proxmox_node_name},path=${each.value.path} --description \"${each.value.comment}\""
  ]
}

resource "ssh_resource" "remove_directory_mappings" {
  when = "destroy"

  for_each = { for mapping in var.directory_mappings : mapping.id => mapping }

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  timeout = "30s"

  commands = [
    "pvesh delete /cluster/mapping/dir/${each.value.id} || true"
  ]
}