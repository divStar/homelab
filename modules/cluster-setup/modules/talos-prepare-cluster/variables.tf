variable "cluster_name" {
  description = "Cluster configuration"
  type        = string
  nullable    = false
}

variable "talos_linux_version" {
  description = "Version of Talos (Linux/Kubernetes) to install"
  type        = string
  nullable    = false
}

variable "nodes" {
  description = "Configuration for cluster nodes"
  type = list(object({
    machine_type = string
    ip           = string
  }))

  validation {
    condition = alltrue([
      for node in var.nodes : contains(["controlplane", "worker"], node.machine_type)
    ])
    error_message = "machine_type must be either 'controlplane' or 'worker'"
  }

  validation {
    condition = alltrue([
      for node in var.nodes : can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}$", node.ip))
    ])
    error_message = "IP addresses must be in valid IPv4 format"
  }
}
