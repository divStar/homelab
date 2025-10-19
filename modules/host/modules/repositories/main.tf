/**
 * # Repository Management
 * 
 * Handles the deactivation of the enterprise repositories and
 * the creation and activation of the no-subscription repositories.
 */
locals {
  # SSH connection settings for reuse
  ssh = {
    host        = var.ssh.host
    user        = var.ssh.user
    private_key = file(var.ssh.id_file)
  }

  # no-subscription related local variables
  resource_count = var.no_subscription ? 1 : 0
}

resource "ssh_resource" "disable_enterprise_sources" {
  # when = "create"

  count = local.resource_count

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    "echo \"Enabled: no\" >> /etc/apt/sources.list.d/pve-enterprise.sources",
    "echo \"Enabled: no\" >> /etc/apt/sources.list.d/ceph.sources",
  ]
}

resource "ssh_resource" "copy_no_subscription_sources" {
  # when = "create"

  count = local.resource_count

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  file {
    source      = "${path.module}/files/pve-no-subscription.sources"
    permissions = "0644"
    destination = "/etc/apt/sources.list.d/pve-no-subscription.sources"
  }

  file {
    source      = "${path.module}/files/ceph-no-subscription.sources"
    permissions = "0644"
    destination = "/etc/apt/sources.list.d/ceph-no-subscription.sources"
  }
}

resource "ssh_resource" "update_all_repositories" {
  # when = "create"
  depends_on = [ssh_resource.disable_enterprise_sources, ssh_resource.copy_no_subscription_sources]

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    "apt-get update"
  ]
}

# resource "ssh_resource" "delete_no_subscription_sources" {
#   when = "destroy"

#   count = local.resource_count

#   host        = local.ssh.host
#   user        = local.ssh.user
#   private_key = local.ssh.private_key

#   commands = [
#     "rm -f /etc/apt/sources.list.d/pve-no-subscription.sources",
#     "rm -f /etc/apt/sources.list.d/ceph-no-subscription.sources",
#   ]
# }

resource "ssh_resource" "enable_enterprise_sources" {
  when = "destroy"

  count = local.resource_count

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    "sed -i '/^Enabled: no$/d' /etc/apt/sources.list.d/pve-enterprise.sources",
    "sed -i '/^Enabled: no$/d' /etc/apt/sources.list.d/ceph.sources"
  ]
}

resource "ssh_resource" "update_all_repositories_enterprise" {
  when = "destroy"

  depends_on = [ssh_resource.enable_enterprise_sources]

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    "apt-get update"
  ]
}
