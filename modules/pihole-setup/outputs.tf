# Root password
output "root_password" {
  description = "Root password"
  value       = module.setup_container.root_password
  sensitive   = true
}

# Private SSH key
output "ssh_private_key" {
  description = "Private SSH key"
  value       = module.setup_container.ssh_private_key
  sensitive   = true
}

# PiHole admin web UI password
output "admin_password" {
  description = "Password for Pi-hole admin interface"
  value       = local.admin_password
  sensitive   = true
}

# PiHole admin web UI URL
output "admin_url" {
  description = "PiHole admin web UI URL"
  value       = "http://${var.ip}/admin"
}