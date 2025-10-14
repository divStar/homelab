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