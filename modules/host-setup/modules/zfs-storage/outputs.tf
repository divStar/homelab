output "storage_pools" {
  description = "List of storage pools that were imported"
  value = [
    for pool in var.storage_pools : {
      name   = pool
      status = "added to Proxmox host"
    }
  ]
}
