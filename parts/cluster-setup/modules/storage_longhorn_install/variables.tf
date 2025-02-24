variable "chart_version" {
  description = "Helm Chart version to install"
  type        = string
}

variable "nodes_count" {
  description = "Amount of nodes (usually worker nodes only); will be used for Longhorn replicaCount properties"
  type        = number
}

variable "ca_issuer" {
  description = "CA certificate issuer (for Certificate resource managed by cert-manager)"
  type        = string
}

variable "name" {
  description = "Name of the Helm release"
  type        = string
  default     = "longhorn-release"
  nullable    = false
}

variable "namespace" {
  description = "Kubernetes namespace to install into"
  type        = string
  default     = "longhorn-system"
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
  nullable    = false
}

variable "service_host" {
  description = "Host to expose the longhorn UI on, e.g. longhorn.my.domain"
  type        = string
  default     = "longhorn.my.world"
  nullable    = false
}