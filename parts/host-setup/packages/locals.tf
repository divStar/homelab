locals {
  # SSH connection settings for reuse
  ssh = {
    host        = var.ssh.host
    user        = var.ssh.user
    private_key = file(var.ssh.id_file)
  }

  # Package management
  pkg_install_cmd = [for pkg in var.packages : "DEBIAN_FRONTEND=noninteractive apt-get install -y ${pkg}"]
  pkg_remove_cmd  = [for pkg in var.packages : "DEBIAN_FRONTEND=noninteractive apt-get remove -y ${pkg}"]
}