output "machine_secrets" {
  description = "Machine secrets for Talos cluster"
  value       = talos_machine_secrets.this.machine_secrets
  sensitive   = true
}

output "client_configuration" {
  description = "Client configuration for Talos cluster"
  value       = talos_machine_secrets.this.client_configuration
  sensitive   = true
}

output "talos_config" {
  description = "Talos configuration file"
  value       = data.talos_client_configuration.this.talos_config
  sensitive   = true
}