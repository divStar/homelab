/**
 * ## Copy configurations
 * 
 * Handles the copying of configuration files to the host.
 */
resource "ssh_resource" "copy_configuration_files" {
  # when = "create"

  for_each = { for configuration_file in var.configuration_files : configuration_file.source => configuration_file }

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  file {
    source      = each.key
    destination = each.value.destination
    permissions = each.value.permissions
    owner       = each.value.owner
    group       = each.value.group
  }
}

resource "ssh_resource" "remove_configuration_files" {
  when = "destroy"

  for_each = { for configuration_file in var.configuration_files : configuration_file.source => configuration_file.destination }

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = ["rm '${each.value}'"]
}