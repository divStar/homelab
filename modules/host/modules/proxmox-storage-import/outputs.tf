output "configured_storages" {
  description = "List of configured storage names"
  value       = keys(var.storage_directories)
}

output "storage_details" {
  description = "Full storage configuration details"
  value = {
    for k, v in var.storage_directories : k => {
      storage_id = k
      path       = v.path
      content    = v.content
    }
  }
}