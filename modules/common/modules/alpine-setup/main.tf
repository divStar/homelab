/**
 * # Alpine LXC container setup
 *
 * This module creates an Alpine LXC container on the Proxmox host,
 * generates a `root_password` and a `ssh_key`, installs `openssh` as well as
 * other Alpine packages (if specified; `bash` is installed by default).
 */

# Downloads the `alpine` image.
resource "proxmox_virtual_environment_download_file" "template" {
  content_type       = "vztmpl"
  datastore_id       = var.imagestore_id
  node_name          = var.proxmox.name
  url                = var.alpine_image.url
  checksum           = var.alpine_image.checksum
  checksum_algorithm = var.alpine_image.checksum_algorithm
}

# Generate SSH key for the container
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Generate a random password for the container
resource "random_password" "root_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

# Create Alpine LXC container
resource "proxmox_virtual_environment_container" "container" {
  # Wait for the template to be downloaded before creating the container
  depends_on = [proxmox_virtual_environment_download_file.template]

  node_name    = var.proxmox.name
  description  = var.description
  tags         = var.tags
  vm_id        = var.vm_id
  unprivileged = true

  # Container initialization settings
  initialization {
    hostname = var.hostname

    # Network configuration
    ip_config {
      ipv4 {
        address = "${var.ni_ip}/${var.ni_subnet_mask}"
        gateway = var.ni_gateway
      }
    }

    # User authentication
    user_account {
      keys = [
        trimspace(tls_private_key.ssh_key.public_key_openssh)
      ]
      password = random_password.root_password.result
    }
  }

  # Network interface
  network_interface {
    name        = var.ni_name
    bridge      = var.ni_bridge
    mac_address = var.ni_mac_address
  }

  # Operating system - using Alpine template
  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.template.id
    type             = "alpine"
  }

  # CPU configuration
  cpu {
    cores = var.cpu_cores
    units = var.cpu_units
  }

  # Memory configuration
  memory {
    dedicated = var.memory_dedicated
    swap      = 0
  }

  # Disk configuration (default)
  disk {
    datastore_id = var.imagestore_id
    size         = var.disk_size
  }

  # Dynamic mount points, passed into this script via variable
  dynamic "mount_point" {
    for_each = var.mount_points
    content {
      volume = mount_point.value.volume
      path   = mount_point.value.path
    }
  }

  # Basic startup configuration
  startup {
    order      = var.startup_order
    up_delay   = var.startup_up_delay
    down_delay = var.startup_down_delay
  }

  features {
    nesting = true
  }
}

# Install OpenSSH into the Alpine LXC container
resource "ssh_resource" "install_openssh" {
  depends_on = [proxmox_virtual_environment_container.container]

  # when = "create"

  # Note: we are connecting to the Proxmox host here rather than the LXC container;
  # this is necessary, because we have to install `openssh` via `pct` from the host.
  host        = var.proxmox.host
  user        = var.proxmox.ssh_user
  private_key = file(var.proxmox.ssh_key)

  # Use a script that checks for OpenSSH and installs it only if needed
  commands = [
    <<-EOT
      # Check if OpenSSH is already installed
      if pct exec ${var.vm_id} -- which sshd > /dev/null 2>&1; then
        echo "OpenSSH is already installed on container ${var.vm_id}"
      else
        echo "Installing OpenSSH on container ${var.vm_id}..."
        pct exec ${var.vm_id} -- apk update
        pct exec ${var.vm_id} -- apk add openssh
        pct exec ${var.vm_id} -- rc-update add sshd default
        pct exec ${var.vm_id} -- /etc/init.d/sshd start
        echo "OpenSSH installed and started in container ${var.vm_id}"
        # Disable password authentication and only allow key-based authentication
        echo "Disabling password-based login..."
        pct exec ${var.vm_id} -- sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
        pct exec ${var.vm_id} -- sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
      fi
      # Add alias
      pct exec ${var.vm_id} -- /bin/sh -c "echo \"alias ll='ls -al'\" >> /etc/profile"
    EOT
  ]
}

# Install necessary Alpine packages
resource "ssh_resource" "install_packages" {
  depends_on = [ssh_resource.install_openssh]

  # when = "create"

  host        = var.ni_ip
  user        = "root"
  private_key = tls_private_key.ssh_key.private_key_pem

  commands = [
    <<-EOT
      # Install additional packages
      apk add --no-cache ${join(" ", var.packages)}
    EOT
  ]
}