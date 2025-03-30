# Alpine container ID
output "alpine_container_id" {
  description = "Alpine container ID"
  value       = proxmox_virtual_environment_container.alpine_container.vm_id
}

# Alpine SSH password
output "alpine_container_password" {
  description = "Alpine SSH password"
  value       = random_password.alpine_password.result
  sensitive   = true
}

# Alpine SSH private key
output "alpine_container_private_key" {
  description = "Alpine SSH private key"
  value       = tls_private_key.alpine_ssh_key.private_key_pem
  sensitive   = true
}

# Alpine SSH public key
output "alpine_container_public_key" {
  description = "Alpine SSH public key"
  value       = tls_private_key.alpine_ssh_key.public_key_openssh
}

# PiHole admin web UI password
output "pihole_admin_password" {
  description = "Password for Pi-hole admin interface"
  value       = local.pihole_admin_password
  sensitive   = true
}

# PiHole admin web UI URL
output "pihole_admin_url" {
  description = "PiHole admin web UI URL"
  value       = "http://${var.pihole_ip}/admin"
}