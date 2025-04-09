# Install necessary Alpine packages
resource "ssh_resource" "install_lldap" {
  depends_on = [ssh_resource.install_lldap_cert]

  when = "create"

  host        = var.lldap_ip
  user        = "root"
  private_key = tls_private_key.alpine_ssh_key.private_key_pem

  file {
    source      = "${path.module}/files/lldap_config.toml"
    destination = "/data/lldap_config.toml"
    permissions = "0644"
  }

  file {
    source      = "${path.module}/files/users.db"
    destination = "/data/users.db"
    permissions = "0644"
  }

  file {
    source      = "${path.module}/files/lldap.service"
    destination = "/etc/init.d/lldap"
    permissions = "0755"
  }

  file {
    source      = "${path.module}/files/setup_lldap.sh"
    destination = "/tmp/setup_lldap.sh"
    permissions = "0755"
  }

  commands = [
    <<-EOT
      # Install and start LLDAP
      /tmp/setup_lldap.sh
    EOT
  ]

  timeout = "1m"
}