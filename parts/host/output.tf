output "installed_packages" {
  description = "The packages, that have been installed/removed"
  value = [for pkg in var.packages : {
    name   = pkg
    status = "installed at ${timestamp()}"
  }]
}

output "installed_scripts" {
  description = "The scripts, that have been installed/removed"
  value = { for script in var.scripts.items : script.name => {
    url            = script.url
    name           = script.name
    path_on_host   = var.scripts.directory
    run_on_destroy = script.run_on_destroy
    apply_params   = script.apply_params
    destroy_params = script.destroy_params
  } }
}

output "users" {
  description = "The user, role and API token created on the Proxmox host"
  value = {
    name    = var.terraform_user.name
    comment = var.terraform_user.comment
    role    = var.terraform_user.role
    token   = "Authorization: ${local.token}"
  }
  sensitive = true
}

output "storage_pools" {
  description = "List of storage pools that were imported and added to Proxmox"
  value = [
    for pool in local.pools : {
      name   = pool.name
      status = try(restapi_object.add_pool_storage[pool.name].id != "", false) ? "added to Proxmox" : "failed to add"
    }
  ]
}

output "storage_pools_directories" {
  description = "List of directories/datasets that were configured in Proxmox"
  value = [
    for dir in local.directories : {
      name          = dir.name
      type          = title(dir.type)
      path          = dir.path
      content_types = dir.content_types
      status        = try(restapi_object.add_directory_storage[dir.name].id != "", false) ? "added to Proxmox" : "failed to add"
    }
  ]
}

output "use_no_subscription_repository" {
  description = "States, whether a no-subscription repository was used (and some further details)"
  value = var.no_subscription_repository
}