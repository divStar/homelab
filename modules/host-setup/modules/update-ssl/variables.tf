variable "ssh" {
  description = "SSH configuration for remote connection"
  # @field host The target host to connect to using SSH
  # @field user SSH user to connect with
  # @field id Path to SSH private key file (defaults to ~/.ssh/id_rsa)
  # @type object
  type = object({
    host    = string
    user    = string
    id_file = optional(string, "~/.ssh/id_rsa")
  })
}

variable "proxmox_host" {
  description = "Name of the target Proxmox host"
  type        = string
}

variable "proxmox_root_ca" {
  description = "Proxmox root CA certificate and key to use"
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

variable "proxmox_domain_cert" {
  description = "Proxmox certificate details"
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
      common_name         = "sanctum.my.world"
      organization        = "Proxmox Virtual Environment"
      organizational_unit = "PVE Cluster Node"
      country             = "DE"
      locality            = "Home Lab"
      province            = "Private Network"
    }
    private_key = {
      algorithm = "RSA"
      rsa_bits  = 2048
    }
    dns_names             = ["localhost", "sanctum", "sanctum.my.world", "sanctum.fritz.box"]
    ip_addresses          = ["127.0.0.1", "192.168.178.27"]
    validity_period_hours = 78840 # 9 years
  }
  nullable = false
}