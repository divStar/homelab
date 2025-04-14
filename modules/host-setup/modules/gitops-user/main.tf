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

  user_home = "/home/${var.gitops_user.user}"
}

# Create user and set up repository
resource "ssh_resource" "add_gitops_user" {
  # when = "create"
  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    # Create git user with git-shell
    "useradd -m -s /usr/bin/git-shell ${var.gitops_user.user}",

    # Set up SSH directory with proper permissions
    "mkdir -p ${local.user_home}/.ssh",
    "chmod 0700 ${local.user_home}/.ssh",
    "chown -R ${var.gitops_user.user}:${var.gitops_user.user} ${local.user_home}/.ssh",

    # Create 'authorized-keys' file with proper permissions
    "touch ${local.user_home}/.ssh/authorized_keys",
    "chmod 0600 ${local.user_home}/.ssh/authorized_keys",

    # Set repository permissions
    "chown -R ${var.gitops_user.user}:${var.gitops_user.group} ${var.gitops_user.source_repo}",
    "chmod -R 0755 ${var.gitops_user.source_repo}",

    # Create symbolic link
    "ln -s ${var.gitops_user.source_repo} ${local.user_home}/${var.gitops_user.repo_name}"
  ]
}

# Cleanup on destroy
resource "ssh_resource" "remove_gitops_user" {
  when = "destroy"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    # Restore repository ownership
    "chown -R ${var.org_source_repo_owner.owner}:${var.org_source_repo_owner.group} ${var.gitops_user.source_repo}",

    # Remove user and their home directory
    "userdel -r ${var.gitops_user.user}"
  ]
}