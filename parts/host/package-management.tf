/**
 * ## Package Management
 * 
 * Handles the installation and removal of packages on the host
 *
 * Note: `ssh_resource` and CLI is used, because `apt-get install`
 * and `apt-get remove` are not yet supported by Proxmox API.
 */

locals {
  # Package management
  pkg_install_cmd = [for pkg in var.packages : "DEBIAN_FRONTEND=noninteractive apt-get install -y ${pkg}"]
  pkg_remove_cmd  = [for pkg in var.packages : "DEBIAN_FRONTEND=noninteractive apt-get remove -y ${pkg}"]
}

resource "ssh_resource" "package_install" {
  host        = local.ssh_config.host
  user        = local.ssh_config.user
  private_key = local.ssh_config.private_key

  # when = "create"
  depends_on = [ssh_resource.add_no_sub_repository]

  commands = concat(
    ["apt-get update"],
    local.pkg_install_cmd
  )
}

resource "ssh_resource" "package_remove" {
  host        = local.ssh_config.host
  user        = local.ssh_config.user
  private_key = local.ssh_config.private_key

  when = "destroy"

  commands = concat(
    local.pkg_remove_cmd,
    ["apt-get autoremove -y"],
    ["apt-get clean"]
  )
}