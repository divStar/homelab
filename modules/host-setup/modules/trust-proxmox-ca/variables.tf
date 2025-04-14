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

variable "pve_root_ca_pem_source" {
  description = "Proxmox public root CA certificate source"
  type        = string
  default     = "/etc/pve/pve-root-ca.pem"
  nullable    = false
}

variable "pve_root_ca_pem_target" {
  description = "Proxmox public root CA certificate target"
  type        = string
  default     = "/usr/local/share/ca-certificates/pve-root-ca.crt"
  nullable    = false
}

variable "restart_pveproxy" {
  description = "Flag, specifying whether to restart the `pveproxy` service (`default = true`) or not."
  type        = bool
  default     = true
  nullable    = false
}