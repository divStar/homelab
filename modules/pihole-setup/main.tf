/**
 * # PiHole Setup
 *
 * This module sets up PiHole in an Alpine LXC container using the provided information.
 */

locals {
  admin_password = var.admin_password != null ? var.admin_password : random_password.admin_password.result
}

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
  packages       = var.packages
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

# Create a random password for the PiHole admin web UI
resource "random_password" "admin_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

# Configure PiHole
resource "ssh_resource" "configure" {
  depends_on = [module.setup_container]
  count      = var.init_configuration ? 1 : 0

  # when = "create"

  host        = var.ni_ip
  user        = "root"
  private_key = module.setup_container.ssh_private_key

  file {
    source      = "${path.module}/files/pihole.toml"
    destination = "/etc/pihole/pihole.toml"
    permissions = "0644"
  }

  timeout = "1m"
}

# Install PiHole
resource "ssh_resource" "install" {
  depends_on = [module.setup_container, ssh_resource.configure]

  # when = "create"

  host        = var.ni_ip
  user        = "root"
  private_key = module.setup_container.ssh_private_key

  file {
    source      = "${path.module}/files/upgrade_alpine.sh"
    destination = "/root/upgrade_alpine.sh"
    permissions = "0755"
  }

  file {
    source      = "${path.module}/files/upgrade_pihole.sh"
    destination = "/root/upgrade_pihole.sh"
    permissions = "0755"
  }

  commands = [
    <<-EOT
      # Run installation script
      curl -sSL https://raw.githubusercontent.com/jrittenh/pi-hole/refs/heads/alpine/automated%20install/basic-install.sh | sudo PIHOLE_SKIP_OS_CHECK=true bash
      # Set password
      pihole setpassword ${local.admin_password}
      # Restart service (also fixes blacklist issue)
      rc-service pihole-FTL restart
      
      # Set /etc/.pihole to the Alpine-compatible GitHub repo (for now)
      cd /etc/.pihole
      git remote set-url origin https://github.com/jrittenh/pi-hole.git
      git fetch --unshallow
      git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
      git fetch --all
      git checkout -b alpine origin/alpine
    EOT
  ]

  timeout = "1m"
}

# Install certificate
resource "ssh_resource" "install_cert" {
  depends_on = [ssh_resource.install]
  count      = var.init_certificate ? 1 : 0

  # when = "create"

  host        = var.ni_ip
  user        = "root"
  private_key = module.setup_container.ssh_private_key

  file {
    content     = <<-EOT
      ${module.setup_certificate[0].key_pem}

      ${module.setup_certificate[0].cert_pem}
    EOT
    destination = "/etc/pihole/tls.pem"
    permissions = "0600"
  }

  pre_commands = [
    <<-EOT
      # Remove stock certificate files
      rm /etc/pihole/tls*
    EOT
  ]

  commands = [
    <<-EOT
      # Restart pihole-FTL
      rc-service pihole-FTL restart
    EOT
  ]

  timeout = "1m"
}