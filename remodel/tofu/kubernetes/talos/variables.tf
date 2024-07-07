variable "talos_image" {
  type = object({
    base_url = string
    version  = string
    datastore = string
  })
}

variable "cluster_config" {
  description = "Talos node configuration"
  type = object({

    cluster_name    = string
    proxmox_cluster = string
    endpoint        = string
    talos_version   = string

    nodes = map(object({
      host_node     = string
      machine_type  = string
      ip            = string
      mac_address   = string
      vm_id         = number
      cpu           = number
      ram_dedicated = number
      igpu = optional(bool, false)
    }))
  })
}

variable "cilium" {
  type = object({
    values = string
    install = string
  })
}