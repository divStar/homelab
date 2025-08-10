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

variable "root_ca_certificate" {
  description = "Step CA root CA certificate."
  type        = string
  nullable    = false
}

variable "acme_server_directory_url" {
  description = "ACME server directory URL"
  type        = string
  default     = "https://step-ca.my.world/acme/step-ca-acme/directory"
  nullable    = false
}

variable "acme_contact" {
  description = "E-Mail address of the ACME account"
  type        = string
  default     = "admin@my.world"
  nullable    = false
}