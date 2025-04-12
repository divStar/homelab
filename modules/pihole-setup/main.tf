locals {
  admin_password = var.admin_password != null ? var.admin_password : random_password.admin_password.result
}

module "setup_container" {
  source = "../common/modules/alpine-setup"

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
  packages     = var.packages
}

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

# Pre-configure PiHole
resource "ssh_resource" "preconfigure_pihole" {
  depends_on = [module.setup_container]
  count      = var.init_configuration ? 1 : 0

  when = "create"

  host        = var.ip
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
resource "ssh_resource" "install_pihole" {
  depends_on = [module.setup_container,ssh_resource.preconfigure_pihole]

  when = "create"

  host        = var.ip
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
  depends_on = [ssh_resource.install_pihole]
  count      = var.init_certificate ? 1 : 0

  when = "create"

  host        = var.ip
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