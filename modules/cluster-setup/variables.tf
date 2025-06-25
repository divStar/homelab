# Versions
variable "talos_linux_version" {
  description = "Version of Talos (Linux/Kubernetes) to install"
  type        = string
  nullable    = false
}

variable "target_kube_version" {
  description = "Target version of Kubernetes the template is built for"
  type        = string
  nullable    = false
}

variable "cilium_version" {
  description = "Cilium version"
  type        = string
  nullable    = false
}

variable "cert_manager_version" {
  description = "Version of the cert-manager Helm Chart to install"
  type        = string
  nullable    = false
}

variable "external_dns_version" {
  description = "Version of the external-dns Helm Chart to install"
  type        = string
  nullable    = false
}

variable "sealed_secrets_version" {
  description = "Version of the sealed-secrets Helm Chart to install"
  type        = string
  nullable    = false
}

variable "local_path_provisioner_version" {
  description = "Version of the local_path_provisioner Helm Chart to install"
  type        = string
  nullable    = false
}

# Common settings
variable "proxmox" {
  description = "Proxmox host configuration"
  type = object({
    name      = string
    host      = string
    endpoint  = string
    insecure  = bool
    api_token = string
    iso_store = optional(string, "local")
    ssh_user  = string
    ssh_key   = string
  })
}

variable "cluster" {
  description = "Cluster configuration"
  type = object({
    name              = string
    gateway           = string
    endpoint          = string
    lb_cidr           = string
    talos_factory_url = optional(string, "https://factory.talos.dev/")
  })
}

variable "nodes" {
  description = "Configuration for cluster nodes"
  type = list(object({
    schematic    = optional(string)
    platform     = optional(string)
    arch         = optional(string)
    name         = string
    description  = optional(string)
    tags         = optional(list(string))
    host         = string
    machine_type = string
    bridge       = optional(string)
    ip           = string
    mac_address  = string
    vm_id        = number
    cpu          = number
    ram          = number
    datastore_id = optional(string)
    vfs_mappings = optional(list(string), [])
  }))

  validation {
    condition = alltrue([
      for node in var.nodes : can(regex("^[a-z0-9][a-z0-9-]*[a-z0-9]$", node.name))
    ])
    error_message = "node name must contain only lowercase letters, numbers and dashes and cannot start or end with a dash; invalid node name(s): ${join(", ",
    [for node in var.nodes : node.name if !can(regex("^[a-z0-9][a-z0-9-]*[a-z0-9]$", node.name))])}"
  }

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

  validation {
    condition = alltrue([
      for node in var.nodes : can(regex("^([0-9A-Fa-f]{2}:){5}([0-9A-Fa-f]{2})$", node.mac_address))
    ])
    error_message = "MAC addresses must be in valid format (e.g., BC:24:11:2E:C8:00)"
  }
}

# Output files
variable "kube_config_file" {
  description = "File name and path for the generated kube-config"
  type        = string
  default     = "output/kube-config.yaml"
  nullable    = false
}

variable "talos_config_file" {
  description = "File name and path for the generated talos-config"
  type        = string
  default     = "output/talos-config.yaml"
  nullable    = false
}

variable "talos_machine_config_file" {
  description = "File name and path for the generated talos-machine-config; use <node-name> in the file name to replace with node name"
  type        = string
  default     = "output/talos-machine-config-<node-name>.yaml"
  nullable    = false
}

variable "k8s_sealed_secret_ca_file" {
  description = "File name and path for the generated sealed secret of the intermediate Kubernetes CA certificate"
  type        = string
  default     = "output/k8s_sealed_secret_ca.yaml"
  nullable    = false
}

# ACME configuration
variable "acme_server_directory_url" {
  description = "ACME server directory URL"
  type        = string
  default     = "https://192.168.178.155/acme/step-ca-acme/directory"
  nullable    = false
}

variable "acme_contact" {
  description = "E-Mail address of the ACME account"
  type        = string
  default     = "admin@my.world"
  nullable    = false
}

# Misc configuration
variable "cert_manager_namespace" {
  description = "Namespace where the cert-manager will be installed to"
  type        = string
  default     = "cert-manager"
  nullable    = false
}

variable "sealed_secrets_namespace" {
  description = "Namespace where the sealed-secrets operator will be installed to"
  type        = string
  default     = "sealed-secrets"
  nullable    = false
}

variable "sealed_secrets_controller_name" {
  description = "Name of the sealed-secrets controller"
  type        = string
  default     = "sealed-secrets-release"
  nullable    = false
}