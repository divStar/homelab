/**
 * # Share user
 *
 * Handles the creation and deletion of a dedicated `share-user:share-users` (UID:GID),
 * who will own the media and other data files in the ZFS pool `storage-pool`.
 */
locals {
  # SSH connection settings for reuse
  ssh = {
    host        = var.ssh.host
    user        = var.ssh.user
    private_key = file(var.ssh.id_file)
  }
}

# Create user and set up repository
resource "ssh_resource" "add_share_user" {
  # when = "create"
  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    # Create group
    "getent group ${var.share_user.group} > /dev/null || groupadd -g ${var.share_user.gid} ${var.share_user.group}",

    # Create user
    "useradd --no-create-home --shell /usr/sbin/nologin -u ${var.share_user.uid} -g ${var.share_user.group} ${var.share_user.user}"
  ]
}

# Cleanup on destroy
resource "ssh_resource" "remove_share_user" {
  when = "destroy"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    # Remove user and their home directory
    "userdel ${var.share_user.user}"
    # No group deletion - group will remain in the system, but 'add_share_user' can work with that
  ]
}