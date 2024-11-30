/**
 * ## GitOps Management: authorized_keys appender
 * 
 * Handles appending of SSH keys to the authorized_keys file of a given user.
 */
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