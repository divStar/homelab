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