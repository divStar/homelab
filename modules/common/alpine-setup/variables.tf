variable "proxmox" {
  description = "Proxmox host configuration"
  type = object({
    name     = string
    host     = string
    ssh_user = string
    ssh_key  = string
  })
}

variable "hostname" {
  description = "Container host name"
  type        = string
  nullable    = false
}

variable "vm_id" {
  description = "VM (Container) ID"
  type        = number
  nullable    = false
}

variable "ip" {
  description = "Network interface IP address"
  type        = string
  nullable    = false
}

variable "gateway" {
  description = "Network interface gateway"
  type        = string
  nullable    = false
}

variable "mac_address" {
  description = "Network interface MAC address"
  type        = string
  nullable    = false
}

variable "alpine_image" {
  description = "Alpine image configuration"
  type = object({
    url                = string
    checksum           = string
    checksum_algorithm = string
  })
  default = {
    url                = "http://download.proxmox.com/images/system/alpine-3.21-default_20241217_amd64.tar.xz"
    checksum           = "211ac75f4b66494e78a6e72acc206b8ac490e0d174a778ae5be2970b0a1a57a8dddea8fc5880886a3794b8bb787fe93297a1cad3aee75d07623d8443ea9062e4"
    checksum_algorithm = "sha512"
  }
  nullable = false
}

variable "packages" {
  description = "List of packages to install on the container"
  type        = list(string)
  default     = ["bash"]
  nullable    = false
}

variable "mount_points" {
  description = "List of mount points for the container"
  type = list(object({
    volume = string
    path   = string
  }))
  default  = []
  nullable = false
}

variable "description" {
  description = "Description of the container"
  type        = string
  default     = "Alpine Linux based LXC container"
}

variable "tags" {
  description = "Tags"
  type        = list(string)
  default     = ["lxc", "alpine"]
}

variable "imagestore_id" {
  description = "DataStore ID for the Alpine template"
  type        = string
  default     = "images-host"
  nullable    = false
}

variable "subnet_mask" {
  description = "Subnet mask in CIDR notation"
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

variable "bridge" {
  description = "Network interface bridge"
  type        = string
  default     = "vmbr0"
  nullable    = false
}