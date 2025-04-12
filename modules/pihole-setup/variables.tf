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
  default     = "Alpine Linux based LXC container with PiHole"
  nullable    = false
}

variable "packages" {
  description = "List of packages to install on the container"
  type        = list(string)
  default = [
    "bash",
    "bind-tools",
    "binutils",
    "coreutils",
    "curl",
    "git",
    "grep",
    "iproute2-ss",
    "jq",
    "libcap",
    "logrotate",
    "ncurses",
    "nmap-ncat",
    "procps-ng",
    "psmisc",
    "shadow",
    "sudo",
    "tzdata",
    "unzip",
    "wget",
    "abuild",
    "build-base"
  ]
}

variable "tags" {
  description = "Tags"
  type        = list(string)
  default     = ["lxc", "alpine"]
  nullable    = false
}

variable "hostname" {
  description = "PiHole host name"
  type        = string
  default     = "pihole"
  nullable    = false
}

variable "imagestore_id" {
  description = "PiHole imagestore ID"
  type        = string
  default     = "images-host"
  nullable    = false
}

variable "datastore_id" {
  description = "PiHole datastore ID"
  type        = string
  default     = "/storage-pool/lxc-data"
  nullable    = false
}

variable "vm_id" {
  description = "PiHole VM ID"
  type        = number
  default     = 701
  nullable    = false
}

variable "ni_name" {
  description = "PiHole network interface name"
  type        = string
  default     = "eth0"
  nullable    = false
}

variable "ip" {
  description = "PiHole IP address"
  type        = string
  default     = "192.168.178.150"
  nullable    = false
}

variable "gateway" {
  description = "PiHole gateway"
  type        = string
  default     = "192.168.178.1"
  nullable    = false
}

variable "mac_address" {
  description = "PiHole MAC address"
  type        = string
  default     = "3C:77:71:89:24:58"
  nullable    = false
}

variable "bridge" {
  description = "PiHole bridge"
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
  default = [
    {
      volume = "/storage-pool/lxc-data/pihole-etc-pihole"
      path   = "/etc/pihole"
    },
    {
      volume = "/storage-pool/lxc-data/pihole-var-log-pihole"
      path   = "/var/log/pihole"
    }
  ]
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
    common_name  = "pihole.my.world"
    organization = "Home Network"
  }

  nullable = false
}

variable "dns_names" {
  description = "DNS names for the certificate"
  type        = list(string)
  default     = ["localhost", "pihole", "pi.hole", "pihole.local", "pihole.my.world", "pihole.fritz.box"]
  nullable    = false
}

variable "ip_addresses" {
  description = "IP addresses for the certificate"
  type        = list(string)
  default     = ["127.0.0.1", "::1", "192.168.178.150"]
  nullable    = false
}

### Application setup
variable "init_configuration" {
  description = "Initialize a new stock configuration"
  type        = bool
  default     = false
  nullable    = false
}

variable "admin_password" {
  description = "PiHole Administrator password"
  type        = string
  default     = null
}