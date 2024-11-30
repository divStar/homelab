locals {
  # SSH connection settings for reuse
  ssh = {
    host        = var.ssh.host
    user        = var.ssh.user
    private_key = file(var.ssh.id_file)
  }

  # no-subscription related local variables
  resource_count = var.no_subscription.enabled ? 1 : 0
}