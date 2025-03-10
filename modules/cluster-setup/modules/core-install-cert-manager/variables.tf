variable "chart_version" {
  description = "Helm Chart version to install"
  type        = string
}

variable "name" {
  description = "Name of the Helm release"
  type        = string
  default     = "cert-manager-release"
  nullable    = false
}

variable "namespace" {
  description = "Kubernetes namespace to install into"
  type        = string
  default     = "cert-manager"
  nullable    = false
}

variable "timeout" {
  description = "Time in seconds to wait for the Helm Chart to be installed"
  type        = number
  default     = 120
  nullable    = false
}

variable "values" {
  description = "Additional values to pass to the helm chart (in YAML format)"
  type        = string
  default     = ""
}
