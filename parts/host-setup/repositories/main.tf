/**
 * ## Repository Management
 * 
 * Handles the deactivation of the enterprise repositories and
 * the creation and activation of the no-subscription repositories.
 */
resource "ssh_resource" "add_no_sub_repository" {
  # when = "create"

  count = local.resource_count

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    "sed -i 's/^deb/# deb/' /etc/apt/sources.list.d/pve-enterprise.list",
    "sed -i 's/^deb/# deb/' /etc/apt/sources.list.d/ceph.list",
    "echo '${var.no_subscription.list_file_content}' > /etc/apt/sources.list.d/${var.no_subscription.list_file}"
  ]
}

resource "ssh_resource" "update_all_repositories" {
  # when = "create"

  depends_on = [ssh_resource.add_no_sub_repository]

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    "apt-get update"
  ]
}

resource "ssh_resource" "remove_no_sub_repository" {
  when = "destroy"

  count = local.resource_count

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    "rm -f /etc/apt/sources.list.d/${var.no_subscription.list_file}",
    "sed -i 's/^# deb/deb/' /etc/apt/sources.list.d/pve-enterprise.list",
    "sed -i 's/^# deb/deb/' /etc/apt/sources.list.d/ceph.list"
  ]
}