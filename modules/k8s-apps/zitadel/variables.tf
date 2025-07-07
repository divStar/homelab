variable "versions_yaml" {
  description = "Path to the `versions.yaml` file, that contains all relevant versions"
  type        = string
  default     = "../../versions.yaml"
  nullable    = false
}