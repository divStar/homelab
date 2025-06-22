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