variable "proxmox" {
  description = "Proxmox host configuration"
  type = object({
    name      = string
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
    name     = string
    gateway  = string
    endpoint = string
    lb_cidr  = string
  })
}

variable "talos_machine_secrets" {
  description = "Talos cluster machine configuration"
  type        = any
}

variable "talos_client_configuration" {
  description = "Talos cluster client configuration"
  type        = any
}

variable "node_description" {
  description = "Description to set for the given node"
  type        = string
  default     = ""
  nullable    = false
}

variable "node_tags" {
  description = "Tags to set for the given node"
  type        = list(string)
  default     = []
  nullable    = false
}

variable "node_name" {
  description = "Name of the cluster node"
  type        = string
}

variable "node_host" {
  description = "Host node for the cluster"
  type        = string
}

variable "node_machine_type" {
  description = "Type of machine (controlplane or worker)"
  type        = string

  validation {
    condition     = contains(["controlplane", "worker"], var.node_machine_type)
    error_message = "The machine_type must be either 'controlplane' or 'worker'."
  }
}

variable "node_bridge" {
  description = "Network bridge to use for this node"
  type        = string
  default     = "vmbr0"
  nullable    = false
}

variable "node_ip" {
  description = "IP address of the node"
  type        = string

  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}$", var.node_ip))
    error_message = "The IP address must be in valid IPv4 format (e.g., 192.168.1.1)."
  }
}

variable "node_mac_address" {
  description = "MAC address of the node"
  type        = string

  validation {
    condition     = can(regex("^([0-9A-Fa-f]{2}:){5}([0-9A-Fa-f]{2})$", var.node_mac_address))
    error_message = "The MAC address must be in valid Proxmox format with colons (e.g., BC:24:11:2E:C8:00)."
  }
}

variable "node_vm_id" {
  description = "VM ID of the node"
  type        = number
}

variable "node_cpu" {
  description = "Number of CPUs for the node"
  type        = number
}

variable "node_ram" {
  description = "Dedicated RAM for the node"
  type        = number
}

variable "node_iso" {
  description = "The path to the Talos node ISO, that is supposed to be used"
}

variable "node_vfs_mappings" {
  description = "List of VirtioFS mapping names to attach to all VMs"
  type        = list(string)
  nullable    = false
}

variable "node_datastore_id" {
  description = "Datastore ID for the node"
  type        = string
  default     = "local"
  nullable    = false
}

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

variable "step_ca_host" {
  description = "Step CA IP or host, _*not*_ including the protocol (`https`)."
  type        = string
  nullable    = false
}