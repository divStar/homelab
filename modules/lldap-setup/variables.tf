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

### Conainer related variables
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

variable "hostname" {
  description = "LLDAP host name"
  type        = string
  default     = "lldap"
  nullable    = false
}

variable "imagestore_id" {
  description = "LLDAP imagestore ID"
  type        = string
  default     = "images-host"
  nullable    = false
}

variable "datastore_id" {
  description = "LLDAP datastore ID"
  type        = string
  default     = "/storage-pool/lxc-data"
  nullable    = false
}

variable "vm_id" {
  description = "LLDAP VM ID"
  type        = number
  default     = 700
  nullable    = false
}

variable "ni_name" {
  description = "LLDAP network interface name"
  type        = string
  default     = "eth0"
  nullable    = false
}

variable "ip" {
  description = "LLDAP IP address"
  type        = string
  default     = "192.168.178.155"
  nullable    = false
}

variable "gateway" {
  description = "LLDAP gateway"
  type        = string
  default     = "192.168.178.1"
  nullable    = false
}

variable "mac_address" {
  description = "LLDAP MAC address"
  type        = string
  default     = "E8:31:0E:A5:D8:4C"
  nullable    = false
}

variable "bridge" {
  description = "LLDAP bridge"
  type        = string
  default     = "vmbr0"
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

### Certificate related variables
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

### Application setup
variable "init_configuration" {
  description = "Initialize a new stock configuration"
  type        = bool
  default     = false
  nullable    = false
}