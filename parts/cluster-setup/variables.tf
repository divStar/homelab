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
    name          = string
    endpoint      = string
    talos_version = string
    gateway       = string
    lb_cidr       = string
  })
}

variable "proxmox_root_ca" {
  description = "Proxmox root CA certificate and key to use for the intermediate k8s certificate"
  type = object({
    pve_root_cert = string
    pve_root_key  = string
  })
  default = {
    pve_root_cert = "/etc/pve/pve-root-ca.pem"
    pve_root_key  = "/etc/pve/priv/pve-root-ca.key"
  }
  nullable = false
}

variable "k8s_ca" {
  description = "Intermediate Kubernetes CA used as ClusterIssuer"
  type = object({
    subject = object({
      common_name         = string
      organization        = string
      organizational_unit = string
      country             = string
      locality            = string
      province            = string
    })
    private_key = object({
      algorithm = string
      rsa_bits  = number
    })
    validity_period_hours = number
  })
  default = {
    subject = {
      common_name         = "Proxmox VE Kubernetes Intermediate CA"
      organization        = "PVE Cluster Manager CA"
      organizational_unit = "Kubernetes"
      country             = "DE"
      locality            = "Home Lab"
      province            = "Private Network"
    }
    private_key = {
      algorithm = "RSA"
      rsa_bits  = 4096
    }
    validity_period_hours = 78840 # 9 years
  }
  nullable = false
}

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

variable "nodes" {
  description = "Configuration for cluster nodes"
  type = list(object({
    talos_version = string
    schematic     = optional(string)
    factory_url   = optional(string)
    platform      = optional(string)
    arch          = optional(string)
    name          = string
    description   = optional(string)
    tags          = optional(list(string))
    host          = string
    machine_type  = string
    bridge        = optional(string)
    ip            = string
    mac_address   = string
    vm_id         = number
    cpu           = number
    ram_dedicated = number
    datastore_id  = optional(string)
    update        = optional(bool)
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

variable "cilium_version" {
  description = "Cilium version"
  type        = string
  default     = "1.17.1"
  nullable    = false
}

variable "longhorn_version" {
  description = "Version of the Longhorn Helm Chart to install"
  type        = string
  default     = "1.8.0"
  nullable    = false
}

variable "cert_manager_version" {
  description = "Version of the cert-manager Helm Chart to install"
  type        = string
  default     = "1.17.1"
  nullable    = false
}

variable "cert_manager_namespace" {
  description = "Namespace where the cert-manager will be installed to"
  type        = string
  default     = "cert-manager"
  nullable    = false
}

variable "pihole_version" {
  description = "Version of the pihole Helm Chart to install"
  type        = string
  default     = "2.27.0"
  nullable    = false
}

variable "sealed_secrets_version" {
  description = "Version of the sealed-secrets Helm Chart to install"
  type        = string
  default     = "2.17.1"
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