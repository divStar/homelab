/**
 * # LLDAP Setup
 *
 * This module sets up LLDAP in an Alpine LXC container using the provided information.
 */

# Alpine LXC container setup
module "setup_container" {
  source = "../common/modules/alpine-setup"

  proxmox = {
    host     = var.proxmox.host
    name     = var.proxmox.name
    ssh_user = var.proxmox.ssh_user
    ssh_key  = var.proxmox.ssh_key
  }
  vm_id          = var.vm_id
  hostname       = var.hostname
  mount_points   = var.mount_points
  imagestore_id  = var.imagestore_id
  ni_ip          = var.ni_ip
  ni_gateway     = var.ni_gateway
  ni_mac_address = var.ni_mac_address
  ni_subnet_mask = var.ni_subnet_mask
  ni_name        = var.ni_name
  ni_bridge      = var.ni_bridge
  startup_order  = var.startup_order
}

# Domain certificate setup
module "setup_certificate" {
  count  = var.init_certificate ? 1 : 0
  source = "../common/modules/domain-cert-setup"

  proxmox = {
    host     = var.proxmox.host
    ssh_user = var.proxmox.ssh_user
    ssh_key  = var.proxmox.ssh_key
  }
  subject      = var.subject
  ip_addresses = var.ip_addresses
  dns_names    = var.dns_names
}

# Install the generated certificate
resource "ssh_resource" "install_cert" {
  depends_on = [module.setup_container, module.setup_certificate]
  count      = var.init_certificate ? 1 : 0

  when = "create"

  host        = var.ni_ip
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

# Configure LLDAP
resource "ssh_resource" "configure" {
  depends_on = [module.setup_container]
  count      = var.init_configuration ? 1 : 0

  when = "create"

  host        = var.ni_ip
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
resource "ssh_resource" "install" {
  depends_on = [ssh_resource.install_cert]

  when = "create"

  host        = var.ni_ip
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