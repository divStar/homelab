# Downloads the `alpine` image.
resource "proxmox_virtual_environment_download_file" "alpine_template" {
  content_type       = "vztmpl"
  datastore_id       = var.pihole_imagestore_id
  node_name          = var.proxmox.name
  url                = var.alpine_image.url
  checksum           = var.alpine_image.checksum
  checksum_algorithm = var.alpine_image.checksum_algorithm
}

# Generate SSH key for the container
resource "tls_private_key" "alpine_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Generate a random password for the container
resource "random_password" "alpine_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

# Create Alpine LXC container
resource "proxmox_virtual_environment_container" "alpine_container" {
  description = "Alpine LXC container managed by Terraform"

  # Wait for the template to be downloaded before creating the container
  depends_on = [proxmox_virtual_environment_download_file.alpine_template]

  node_name    = var.proxmox.name
  vm_id        = var.pihole_vm_id
  unprivileged = true

  # Container initialization settings
  initialization {
    hostname = var.pihole_hostname

    # Network configuration
    ip_config {
      ipv4 {
        address = "${var.pihole_ip}/24"
        gateway = var.pihole_gateway
      }
    }

    # User authentication
    user_account {
      keys = [
        trimspace(tls_private_key.alpine_ssh_key.public_key_openssh)
      ]
      password = random_password.alpine_password.result
    }
  }

  # Network interface
  network_interface {
    name        = var.pihole_ni_name
    bridge      = var.pihole_bridge
    mac_address = var.pihole_mac_address
  }

  # Operating system - using Alpine template
  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.alpine_template.id
    type             = "alpine"
  }

  # CPU configuration
  cpu {
    cores = 1
    units = 1024
  }

  # Memory configuration
  memory {
    dedicated = 1024
    swap      = 0
  }

  # Disk configuration (default)
  disk {
    datastore_id = var.pihole_datastore_id
    size         = 2
  }

  # Mount points for Pi-hole data persistence
  mount_point {
    volume    = var.pihole_datastore_id
    path      = "/etc/pihole"
    size      = "128M"
    replicate = true
    backup    = true
  }

  mount_point {
    volume    = var.pihole_datastore_id
    path      = "/var/log/pihole"
    size      = "1G"
    replicate = true
    backup    = true
  }

  # Perhaps not needed
  # mount_point {
  #   volume    = var.pihole_datastore_id
  #   path      = "/var/www/html/admin"
  #   size      = "128M"
  #   replicate = true
  #   backup    = true
  # }

  # Probably not needed
  # mount_point {
  #   volume    = var.pihole_datastore_id
  #   path      = "/etc/.pihole"
  #   size      = "128M"
  #   replicate = true
  #   backup    = true
  # }

  # Basic startup configuration
  startup {
    order      = 1
    up_delay   = 20
    down_delay = 20
  }

  features {
    nesting = true
  }
}