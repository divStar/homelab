variable "proxmox" {
  description = "Proxmox host configuration"
  type = object({
    name      = string
    host      = string
    port      = number
    endpoint  = string
    insecure  = bool
    api_token = string
    ssh_user  = string
    ssh_key   = string
  })
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

variable "proxmox_root_ca" {
  description = "Proxmox root CA certificate and key to use for the PiHole admin UI"
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

variable "pihole_domain_cert" {
  description = "PiHole domain certificate details"
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
    dns_names             = list(string)
    ip_addresses          = list(string)
    validity_period_hours = number
  })
  default = {
    subject = {
      common_name         = "pihole.my.world"
      organization        = "Home Network"
      organizational_unit = "Network Services"
      country             = "DE"
      locality            = "Home Lab"
      province            = "Private Network"
    }
    private_key = {
      algorithm = "RSA"
      rsa_bits  = 4096
    }
    dns_names             = ["pihole.my.world", "pihole.local", "pi.hole"]
    ip_addresses          = ["192.168.178.150"]
    validity_period_hours = 78840 # 9 years
  }
  nullable = false
}

variable "pihole_hostname" {
  description = "PiHole host name"
  type        = string
  default     = "pihole"
  nullable    = false
}

variable "pihole_imagestore_id" {
  description = "PiHole imagestore ID"
  type        = string
  default     = "images-host"
  nullable    = false
}

variable "pihole_datastore_id" {
  description = "PiHole datastore ID"
  type        = string
  default     = "storage-pool"
  nullable    = false
}

variable "pihole_vm_id" {
  description = "PiHole VM ID"
  type        = number
  default     = 700
  nullable    = false
}

variable "pihole_ni_name" {
  description = "PiHole network interface name"
  type        = string
  default     = "eth0"
  nullable    = false
}

variable "pihole_ip" {
  description = "PiHole IP address"
  type        = string
  default     = "192.168.178.150"
  nullable    = false
}

variable "pihole_gateway" {
  description = "PiHole gateway"
  type        = string
  default     = "192.168.178.1"
  nullable    = false
}

variable "pihole_mac_address" {
  description = "PiHole MAC address"
  type        = string
  default     = "3C:77:71:89:24:58"
  nullable    = false
}

variable "pihole_bridge" {
  description = "PiHole bridge"
  type        = string
  default     = "vmbr0"
  nullable    = false
}

variable "pihole_admin_password" {
  description = "PiHole Administrator password"
  type        = string
  default     = ""
  nullable    = false
}