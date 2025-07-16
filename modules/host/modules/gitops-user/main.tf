/**
 * # GitOps user
 *
 * Handles the creation and deletion of a dedicated user with git+ssh access (gitops)
 * as well as setting and restoring owner / group of the original gitops repository.
 */
locals {
  # SSH connection settings for reuse
  ssh = {
    host        = var.ssh.host
    user        = var.ssh.user
    private_key = file(var.ssh.id_file)
  }

  user_home = "/home/${var.user}"
}

# Create user and set up repository
resource "ssh_resource" "add_gitops_user" {
  # when = "create"
  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    "useradd -m -s /usr/bin/git-shell ${var.user}",

    "mkdir -p ${local.user_home}/.ssh",
    "chmod 0700 ${local.user_home}/.ssh",
    "chown -R ${var.user}:${var.group} ${local.user_home}/.ssh",

    "touch ${local.user_home}/.ssh/authorized_keys",
    "chmod 0600 ${local.user_home}/.ssh/authorized_keys",

    "chown -R ${var.user}:${var.group} ${var.repository}",
    "chmod -R 0755 ${var.repository}",

    "ln -s ${var.repository} ${local.user_home}/${var.repository_symlink}"
  ]
}

# Cleanup on destroy
resource "ssh_resource" "remove_gitops_user" {
  when = "destroy"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    # Just remove the user home directory;
    # we do not want to reset owner or permissions on the repository home directory
    "userdel -r ${var.user}"
  ]
}