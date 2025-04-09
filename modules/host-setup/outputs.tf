output "configuration_files" {
  description = "Configuration files copied to host"
  value       = module.copy_configs.configuration_files
}

output "no_subscription" {
  description = "States, whether a no-subscription repository was used (and some further details)"
  value       = module.repositories.no_subscription
}

output "installed_packages" {
  description = "The packages, that have been installed/removed"
  value       = module.packages.installed_packages
}

output "installed_scripts" {
  description = "The scripts, that have been installed/removed"
  value       = module.scripts.installed_scripts
}

output "pve-user" {
  description = "The user and role created on the Proxmox host"
  value       = module.terraform_user.pve-user
  sensitive   = true
}

output "token" {
  description = "The API token created on the Proxmox host"
  value       = module.terraform_user.token
  sensitive   = true
}

output "storage_pools" {
  description = "List of storage pools that were imported and added to Proxmox"
  value       = module.storage.storage_pools
}

output "storage_pools_directories" {
  description = "List of directories/datasets that were configured in Proxmox"
  value       = module.storage.storage_pools_directories
}

output "certificate_info" {
  description = "pve-ssl Certificate information"
  value       = module.update_ssl.certificate_info
}