# Install OpenSSH on Alpine LXC container
resource "ssh_resource" "install_openssh" {
  depends_on = [proxmox_virtual_environment_container.alpine_container]

  when = "create"

  # Note: we are connecting to the Proxmox host here rather than the LXC container
  host        = var.proxmox.host
  user        = var.proxmox.ssh_user
  private_key = file(var.proxmox.ssh_key)

  # Use a script that checks for OpenSSH and installs it only if needed
  commands = [
    <<-EOT
      # Check if OpenSSH is already installed
      if pct exec ${var.pihole_vm_id} -- which sshd > /dev/null 2>&1; then
        echo "OpenSSH is already installed on container ${var.pihole_vm_id}"
      else
        echo "Installing OpenSSH on container ${var.pihole_vm_id}..."
        pct exec ${var.pihole_vm_id} -- apk update
        pct exec ${var.pihole_vm_id} -- apk add openssh
        pct exec ${var.pihole_vm_id} -- rc-update add sshd default
        pct exec ${var.pihole_vm_id} -- /etc/init.d/sshd start
        echo "OpenSSH installed and started in container ${var.pihole_vm_id}"
        # Disable password authentication and only allow key-based authentication
        echo "Disabling password-based login..."
        pct exec ${var.pihole_vm_id} -- sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
        pct exec ${var.pihole_vm_id} -- sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
      fi
      # Add alias
      pct exec ${var.pihole_vm_id} -- /bin/sh -c "echo \"alias ll='ls -al'\" >> /etc/profile"
    EOT
  ]
}

# Install necessary Alpine packages
resource "ssh_resource" "install_packages" {
  depends_on = [ssh_resource.install_openssh]

  when = "create"

  host        = var.pihole_ip
  user        = "root"
  private_key = tls_private_key.alpine_ssh_key.private_key_pem

  commands = [
    <<-EOT
      # Prepare the Alpine installation
      apk add --no-cache ${join(" ", var.packages)}
    EOT
  ]
}