output "configuration_files" {
  description = "Configuration files copied to host"
  value       = [for configuration_file in var.configuration_files : configuration_file.destination]
}