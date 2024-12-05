/**
 * ## GitOps Management: authorized_keys appender
 * 
 * Handles appending of SSH keys to the authorized_keys file of a given user.
 */
locals {
  # SSH connection settings for reuse
  ssh = {
    host        = var.ssh.host
    user        = var.ssh.user
    private_key = file(var.ssh.id_file)
  }

  # Command restrictions based on access mode
  command_restriction = {
    "read-only"  = "command=\"git-upload-pack '/home/${var.target_user}/repo'\""
    "read-write" = "" # No command restriction needed for read-write, git-shell handles it
  }

  # Read the SSH key from file
  ssh_key = trimspace(file(var.ssh_key_file))

  # Combine restrictions with the key
  final_key = "${local.command_restriction[var.git_access_mode]},no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ${local.ssh_key}"
}

resource "ssh_resource" "add_key" {
  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  when = "create"

  commands = [
    # Append the SSH key to authorized_keys with access mode restrictions
    "echo '${local.final_key}' >> /home/${var.target_user}/.ssh/authorized_keys"
  ]
}