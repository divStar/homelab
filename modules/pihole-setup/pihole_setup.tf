locals {
  pihole_admin_password = var.pihole_admin_password != "" ? var.pihole_admin_password : random_password.pihole_admin.result
}

# Create a random password for the PiHole admin web UI
resource "random_password" "pihole_admin" {
  length           = 16
  special          = true
  override_special = "_%@"
}

# Install necessary Alpine packages
resource "ssh_resource" "install_pihole" {
  depends_on = [ssh_resource.install_packages]

  when = "create"

  host        = var.pihole_ip
  user        = "root"
  private_key = tls_private_key.alpine_ssh_key.private_key_pem

  # We are using the original set up script
  # file {
  #   source      = "${path.module}/files/pihole_setup.sh"
  #   destination = "/tmp/pihole_setup.sh"
  #   permissions = "0700"
  # }

  # Not using specific
  # file {
  #   source      = "${path.module}/files/pihole-FTL.service"
  #   destination = "/etc/init.d/pihole-FTL"
  #   permissions = "0644"
  # }

  file {
    source      = "${path.module}/files/pihole.toml"
    destination = "/etc/pihole/pihole.toml"
    permissions = "0644"
  }

  commands = [
    <<-EOT
      # Run installation script
      curl -sSL https://raw.githubusercontent.com/jrittenh/pi-hole/refs/heads/alpine/automated%20install/basic-install.sh | sudo PIHOLE_SKIP_OS_CHECK=true bash
      # Set password
      pihole setpassword ${var.pihole_admin_password}
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
}