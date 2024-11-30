/**
 * ## Package Management
 * 
 * Handles the installation and removal of packages on the host
 *
 * Note: `ssh_resource` and CLI is used, because `apt-get install`
 * and `apt-get remove` are not yet supported by Proxmox API.
 */
resource "ssh_resource" "package_install" {
  # when = "create"
  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = concat(
    local.pkg_install_cmd
  )
}

resource "ssh_resource" "package_remove" {
  when = "destroy"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = concat(
    local.pkg_remove_cmd,
    ["apt-get autoremove -y"],
    ["apt-get clean"]
  )
}