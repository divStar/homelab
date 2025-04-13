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
  description = "LLDAP VM ID"
  type        = number
  default     = 701
  nullable    = false
}

variable "hostname" {
  description = "LLDAP host name"
  type        = string
  default     = "lldap"
  nullable    = false
}

variable "description" {
  description = "Description of the container"
  type        = string
  default     = "Alpine Linux based LXC container with LLDAP"
  nullable    = false
}

variable "tags" {
  description = "Tags"
  type        = list(string)
  default     = ["lxc", "alpine"]
  nullable    = false
}

variable "mount_points" {
  description = "List of mount points for the container"
  type = list(object({
    volume = string
    path   = string
  }))
  default = [{
    volume = "/storage-pool/lxc-data/lldap-data"
    path   = "/data"
  }]
  nullable = false
}

variable "imagestore_id" {
  description = "LLDAP imagestore ID"
  type        = string
  default     = "images-host"
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

# Certificate configuration
variable "init_certificate" {
  description = "Initialize certificate as new (also needed for renewal)"
  type        = bool
  default     = false
  nullable    = false
}

variable "subject" {
  description = "Subject information for the certificate"
  type = object({
    common_name  = string
    organization = string
  })
  default = {
    common_name  = "lldap.my.world"
    organization = "Home Network"
  }
  nullable = false
}

variable "dns_names" {
  description = "DNS names for the certificate"
  type        = list(string)
  default     = ["localhost", "lldap", "lldap.local", "lldap.my.world", "lldap.fritz.box"]
  nullable    = false
}

variable "ip_addresses" {
  description = "IP addresses for the certificate"
  type        = list(string)
  default     = ["127.0.0.1", "::1", "192.168.178.155"]
  nullable    = false
}

# Application configuration
variable "init_configuration" {
  description = "Initialize a new stock configuration"
  type        = bool
  default     = false
  nullable    = false
}