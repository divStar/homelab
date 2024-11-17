variable "proxmox" {
  description = "Proxmox (host) object, containing Proxmox-related configuration"
  type = object({
    name         = string
    cluster_name = string
    endpoint     = string
    insecure     = bool
    username     = string
    api_token    = string
  })
}

variable "talos" {
  description = "Talos (VM) object, containing Talos-related configuration"
  type = object({
    cluster_name = string
    endpoint     = string
    gateway      = string
    version      = string
    nodes = list(object({
      name          = string
      host_node     = optional(string)
      machine_type  = string
      ip            = string
      mac_address   = string
      vm_id         = number
      cpu           = number
      ram_dedicated = number
    }))
  })

  validation {
    condition = alltrue([
      for node in var.talos.nodes :
      contains(["controlplane", "worker"], node.machine_type)
    ])
    error_message = "All nodes must have a machine_type of either 'controlplane' or 'worker'."
  }
}

variable "cilium" {
  description = "Cilium object, containing Cilium-related configuration"
  type = object({
    version = string
  })
}

variable "ssh_private_key_path" {
  description = "Path to the SSH private key file"
  type        = string
  default     = "~/.ssh/id_rsa"

  validation {
    condition     = can(fileexists(pathexpand(var.ssh_private_key_path))) && can(file(pathexpand(var.ssh_private_key_path)))
    error_message = "The specified SSH private key file does not exist or is not accessible."
  }
}