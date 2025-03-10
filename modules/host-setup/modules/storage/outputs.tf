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