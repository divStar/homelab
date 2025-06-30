# General container configuration
variable "proxmox" {
  description = "Proxmox host configuration"
  type = object({
    name          = string
    host          = string
    endpoint      = string
    insecure      = bool
    root_password = string
    ssh_user      = string
    ssh_key       = string
  })
}

variable "vm_id" {
  description = "Step-CA VM ID"
  type        = number
  default     = 701
  nullable    = false
}

variable "hostname" {
  description = "Step-CA host name"
  type        = string
  default     = "step-ca"
  nullable    = false
}

variable "description" {
  description = "Description of the container"
  type        = string
  default     = "Alpine Linux based LXC container with Step-CA"
  nullable    = false
}

variable "tags" {
  description = "Tags"
  type        = list(string)
  default     = ["alpine", "lxc"]
  nullable    = false
}

variable "mount_points" {
  description = "List of mount points for the container"
  type = list(object({
    volume = string
    path   = string
  }))
  default = [
    {
      volume = "/mnt/storage/service-configs/step-ca/step-lxc"
      path   = "/etc/step-ca"
    }
  ]
  nullable = false
}

variable "imagestore_id" {
  description = "Step-CA imagestore ID"
  type        = string
  default     = "proxmox-resources"
  nullable    = false
}

variable "startup_order" {
  description = "Container startup order; shutdowns happen in reverse order"
  type        = number
  default     = 1
  nullable    = false
}

# Network interface configuration
variable "ni_ip" {
  description = "Network interface IP address"
  type        = string
  default     = "192.168.178.155"
  nullable    = false
}

variable "ni_gateway" {
  description = "Network interface gateway"
  type        = string
  default     = "192.168.178.1"
  nullable    = false
}

variable "ni_mac_address" {
  description = "Network interface MAC address"
  type        = string
  default     = "E8:31:0E:A5:D8:4C"
  nullable    = false
}

variable "ni_subnet_mask" {
  description = "Network interface subnet mask in CIDR notation"
  type        = number
  default     = 24
  nullable    = false
}

variable "ni_name" {
  description = "Network interface name"
  type        = string
  default     = "eth0"
  nullable    = false
}

variable "ni_bridge" {
  description = "Network interface bridge"
  type        = string
  default     = "vmbr0"
  nullable    = false
}

# ACME variables
variable "acme_contact" {
  description = "E-Mail address of the ACME account in Proxmox"
  type        = string
  default     = "admin@my.world"
  nullable    = false
}

variable "acme_name" {
  description = "ACME account name"
  type        = string
  default     = "step-ca-acme"
  nullable    = false
}

variable "acme_proxmox_domains" {
  description = "Proxmox ACME domains to order certificates for"
  type        = list(string)
  default     = ["sanctum.my.world", "sanctum.fritz.box"]
  nullable    = false
}

# General Step CA server configuration
variable "fingerprint_file" {
  description = "File containing the fingerprint"
  type        = string
  default     = ""
  nullable    = false
}

variable "skip_host_configuration" {
  description = "Controls whether the Proxmox host will be configured with ACME or not"
  type        = bool
  default     = false
  nullable    = false
}