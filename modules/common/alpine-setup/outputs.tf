# Root password
output "root_password" {
  description = "Root password"
  value       = random_password.root_password.result
  sensitive   = true
}

# Private SSH key
output "ssh_private_key" {
  description = "Private SSH key"
  value       = tls_private_key.ssh_key.private_key_pem
  sensitive   = true
}