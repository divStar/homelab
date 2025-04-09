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
    "bash"
  ]
}

variable "proxmox_root_ca" {
  description = "Proxmox root CA certificate and key to use for the LLDAP admin UI"
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

variable "lldap_domain_cert" {
  default = {
    subject = {
      common_name         = "lldap.my.world"
      organization        = "Home Network"
      organizational_unit = "Authentication Services"
      country             = "DE"
      locality            = "Home Lab"
      province            = "Private Network"
    }
    private_key = {
      algorithm = "RSA"
      rsa_bits  = 4096
    }
    dns_names             = ["localhost", "lldap", "lldap.local", "lldap.my.world", "lldap.fritz.box"]
    ip_addresses          = ["127.0.0.1", "::1", "192.168.178.155"]
    validity_period_hours = 78840 # 9 years
  }
}

variable "lldap_description" {
  description = "Description of the container"
  type        = string
  default     = "Alpine Linux based LXC container with LLDAP"
  nullable    = false
}

variable "lldap_tags" {
  description = "Tags"
  type        = list(string)
  default     = ["lxc", "alpine"]
  nullable    = false
}

variable "lldap_hostname" {
  description = "LLDAP host name"
  type        = string
  default     = "lldap"
  nullable    = false
}

variable "lldap_imagestore_id" {
  description = "LLDAP imagestore ID"
  type        = string
  default     = "images-host"
  nullable    = false
}

variable "lldap_datastore_id" {
  description = "LLDAP datastore ID"
  type        = string
  default     = "storage-pool"
  nullable    = false
}

variable "lldap_vm_id" {
  description = "LLDAP VM ID"
  type        = number
  default     = 695
  nullable    = false
}

variable "lldap_ni_name" {
  description = "LLDAP network interface name"
  type        = string
  default     = "eth0"
  nullable    = false
}

variable "lldap_ip" {
  description = "LLDAP IP address"
  type        = string
  default     = "192.168.178.155"
  nullable    = false
}

variable "lldap_gateway" {
  description = "LLDAP gateway"
  type        = string
  default     = "192.168.178.1"
  nullable    = false
}

variable "lldap_mac_address" {
  description = "LLDAP MAC address"
  type        = string
  default     = "E8:31:0E:A5:D8:4C"
  nullable    = false
}

variable "lldap_bridge" {
  description = "LLDAP bridge"
  type        = string
  default     = "vmbr0"
  nullable    = false
}