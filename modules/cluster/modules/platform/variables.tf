variable "homelab_root" {
  description = "Path to the gitops git repository root"
  type        = string
  default     = "~/Workspaces/homelab/"
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

variable "relative_path_to_versions_yaml" {
  description = "Relative path to the `versions.yaml` file; it's passed to sub-modules"
  type        = string
  default     = "../.."
  nullable    = false
}

variable "root_ca_certificate" {
  description = "Step CA root CA certificate."
  type        = string
  nullable    = false
}
