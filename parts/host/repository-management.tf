/**
 * ## Repository Management
 * 
 * Handles the deactivation of the enterprise repositories and
 * the creation and activation of the no-subscription repositories.
 */

 locals {
   node_name = var.proxmox_configuration.name
   resource_count = var.no_subscription_repository.use ? 1 : 0
 }

resource "ssh_resource" "add_no_sub_repository" {
  count = local.resource_count

  host        = local.ssh_config.host
  user        = local.ssh_config.user
  private_key = local.ssh_config.private_key

  # when = "create"

  commands = [
    "sed -i 's/^deb/# deb/' /etc/apt/sources.list.d/pve-enterprise.list",
    "sed -i 's/^deb/# deb/' /etc/apt/sources.list.d/ceph.list",
    "echo '${var.no_subscription_repository.repository_line}' > /etc/apt/sources.list.d/${var.no_subscription_repository.sources_file_name}"
  ]
}

resource "ssh_resource" "remove_no_sub_repository" {
  count = local.resource_count

  host        = local.ssh_config.host
  user        = local.ssh_config.user
  private_key = local.ssh_config.private_key

  when = "destroy"

  commands = [
    "rm -f /etc/apt/sources.list.d/${var.no_subscription_repository.sources_file_name}",
    "sed -i 's/^# deb/deb/' /etc/apt/sources.list.d/pve-enterprise.list",
    "sed -i 's/^# deb/deb/' /etc/apt/sources.list.d/ceph.list"
  ]
}