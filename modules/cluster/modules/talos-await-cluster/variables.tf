variable "talos_linux_version" {
  description = "Version of Talos (Linux/Kubernetes) to install"
  type        = string
  nullable    = false
}

variable "cluster" {
  description = "Cluster configuration"
  type = object({
    name     = string
    endpoint = string
  })
}

variable "talos_machine_secrets" {
  description = "Talos cluster machine configuration"
  type        = any
}

variable "talos_client_configuration" {
  description = "Talos cluster client configuration"
  type        = map(any)
}

variable "bootstrap_timeout" {
  description = "Cluster bootstrap timeout"
  type        = string
  default     = "5m"
  nullable    = false
}

variable "health_check_timeout" {
  description = "Cluster health-check timeout"
  type        = string
  default     = "10m"
  nullable    = false
}

variable "kubeconfig_timeout" {
  description = "Cluster kubeconfig creation timeout"
  type        = string
  default     = "1m"
  nullable    = false
}

variable "nodes" {
  description = "Configuration for cluster nodes"
  type = list(object({
    name         = string
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
