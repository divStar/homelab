variable "homelab_root" {
  description = "Path to the gitops git repository root"
  type        = string
  default     = "~/Documents/homelab-tofu/"
  nullable    = false
}

variable "cluster" {
  description = "Cluster configuration"
  type = object({
    name    = string
    lb_cidr = string
    domain  = string
  })
}

variable "external_dns_secret_name" {
  description = "Name of the external-dns PiHole secret"
  type        = string
  default     = "external-dns-pihole-secret"
  nullable    = false
}