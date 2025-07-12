variable "versions_yaml" {
  description = "Absolute path and filename to the `versions.yaml` file, that contains all relevant Helm Chart descriptions and versions"
  type        = string
  default     = "../../versions.yaml"
  nullable    = false
}