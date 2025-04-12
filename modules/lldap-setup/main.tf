module "setup_container" {
  source = "../common/alpine-setup"

  proxmox = {
    host     = var.proxmox.host
    name     = var.proxmox.name
    ssh_user = var.proxmox.ssh_user
    ssh_key  = var.proxmox.ssh_key
  }
  vm_id        = var.vm_id
  ip           = var.ip
  hostname     = var.hostname
  mac_address  = var.mac_address
  gateway      = var.gateway
  mount_points = var.mount_points
}

module "setup_certificate" {
  count  = var.init_certificate ? 1 : 0
  source = "../common/domain-cert-setup"

  proxmox = {
    host     = var.proxmox.host
    ssh_user = var.proxmox.ssh_user
    ssh_key  = var.proxmox.ssh_key
  }
  subject      = var.subject
  ip_addresses = var.ip_addresses
  dns_names    = var.dns_names
}

resource "ssh_resource" "install_cert" {
  depends_on = [module.setup_container, module.setup_certificate]
  count      = var.init_certificate ? 1 : 0

  when = "create"

  host        = var.ip
  user        = "root"
  private_key = module.setup_container.ssh_private_key

  file {
    content     = module.setup_certificate[0].key_pem
    destination = "/data/key.pem"
    permissions = "0644"
  }

  file {
    content     = <<-EOT
      ${module.setup_certificate[0].cert_pem}
      ${module.setup_certificate[0].ca_cert_pem}
    EOT
    destination = "/data/cert.pem"
    permissions = "0644"
  }
}

# Pre-configure LLDAP
resource "ssh_resource" "preconfigure_lldap" {
  depends_on = [module.setup_container]
  count      = var.init_configuration ? 1 : 0

  when = "create"

  host        = var.ip
  user        = "root"
  private_key = module.setup_container.ssh_private_key

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

  timeout = "1m"
}

# Install LLDAP
resource "ssh_resource" "install_lldap" {
  depends_on = [ssh_resource.install_cert]

  when = "create"

  host        = var.ip
  user        = "root"
  private_key = module.setup_container.ssh_private_key

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