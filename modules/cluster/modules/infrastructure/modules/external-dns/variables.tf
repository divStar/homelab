variable "cluster" {
  description = "Cluster configuration"
  type = object({
    name    = string
    lb_cidr = string
    domain  = string
  })
}

variable "relative_path_to_versions_yaml" {
  description = "Relative path to the `versions.yaml` file"
  type        = string
  nullable    = false
}

variable "external_dns_secret_name" {
  description = "Name of the external-dns PiHole secret"
  type        = string
  default     = "external-dns-pihole-secret"
  nullable    = false
}