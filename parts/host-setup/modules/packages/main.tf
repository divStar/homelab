/**
 * ## Package Management
 * 
 * Handles the installation and removal of packages on the host
 *
 * Note: `ssh_resource` and CLI is used, because `apt-get install`
 * and `apt-get remove` are not yet supported by Proxmox API.
 */
locals {
  # SSH connection settings for reuse
  ssh = {
    host        = var.ssh.host
    user        = var.ssh.user
    private_key = file(var.ssh.id_file)
  }

  # Package to install or remove
  packages_string = join(" ", var.packages)
}

resource "ssh_resource" "package_install" {
  # when = "create"
  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    "DEBIAN_FRONTEND=noninteractive apt-get install -y ${local.packages_string}"
  ]
}

resource "ssh_resource" "package_remove" {
  when = "destroy"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    "DEBIAN_FRONTEND=noninteractive apt-get remove -y ${local.packages_string}",
    "DEBIAN_FRONTEND=noninteractive apt-get autoremove -y",
    "DEBIAN_FRONTEND=noninteractive apt-get clean"
  ]
}