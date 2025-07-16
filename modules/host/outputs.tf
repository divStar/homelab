output "configuration_files" {
  description = "Configuration files copied to host"
  value       = module.copy_configs.configuration_files
}

output "directory_mappings" {
  description = "List of directories mapped for further use in Proxmox"
  value       = module.directory_mappings.directory_mappings
}

output "installed_packages" {
  description = "The packages, that have been installed/removed"
  value       = module.packages.installed_packages
}

output "installed_scripts" {
  description = "The scripts, that have been installed/removed"
  value       = module.scripts.installed_scripts
}

output "no_subscription" {
  description = "States, whether a no-subscription repository was used (and some further details)"
  value       = module.repositories.no_subscription
}

output "share_user" {
  description = "The user to manage file shares on the Proxmox host storage"
  value = {
    user  = module.share_user.user
    group = module.share_user.group
  }
  sensitive = true
}

output "storage_pools" {
  description = "List of storage pools that were imported and added to Proxmox"
  value       = module.zfs_storage.storage_pools
}

output "terraform_user" {
  description = "The user and role created to manage the Proxmox host via Terraform/OpenTofu"
  value = {
    user  = module.terraform_user.user
    token = module.terraform_user.token
  }
  sensitive = true
}

output "gitops_user" {
  description = "User and git+ssh URL for gitops purposes"
  value = {
    git_ssh_url = module.gitops_user.git_ssh_url
    user        = module.gitops_user.user
    user_home   = module.gitops_user.user_home
    local_repo  = module.gitops_user.repo_local_path
    org_repo    = module.gitops_user.repo_actual_path
  }
}