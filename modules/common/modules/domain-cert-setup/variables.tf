variable "proxmox" {
  description = "Proxmox host configuration"

  type = object({
    host     = string
    ssh_user = string
    ssh_key  = string
  })
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

variable "subject" {
  description = "Subject information for the certificate"

  type = object({
    common_name  = string
    organization = string
  })

  nullable = false
}

variable "dns_names" {
  description = "DNS names for the certificate"
  type        = list(string)
  nullable    = false
}

variable "ip_addresses" {
  description = "IP addresses for the certificate"
  type        = list(string)
  nullable    = false
}

variable "private_key" {
  description = "Private key configuration for the certificate"

  type = object({
    algorithm = string
    rsa_bits  = number
  })

  default = {
    algorithm = "RSA"
    rsa_bits  = 4096
  }

  nullable = false
}

variable "allowed_uses" {
  description = "Allowed uses of the certificate"
  type        = list(string)
  default     = ["key_encipherment", "digital_signature", "server_auth", "client_auth"]
  nullable    = false
}

variable "validity_period_hours" {
  description = "Validity period in hours for the certificate"
  type        = number
  default     = 8766 # 1 year; (78840 hours = 9 years)
  nullable    = false
}

variable "early_renewal_hours" {
  description = "Early renewal period in hours for the certificate"
  type        = number
  default     = 720 # 30 days;
  nullable    = false
}