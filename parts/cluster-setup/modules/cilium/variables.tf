variable "cilium_version" {
  description = "Cilium version"
  type        = string
}

variable "cilium_name" {
  description = "Name of the Cilium Helm release"
  type        = string
  default     = "cilium"
  nullable    = false
}

variable "cilium_repository" {
  description = "URL of the Cilium Helm repository to use"
  type        = string
  default     = "https://helm.cilium.io"
  nullable    = false
}

variable "cilium_chart" {
  description = "Name of the Cilium Helm Chart to use"
  type        = string
  default     = "cilium"
  nullable    = false
}

variable "cilium_timeout" {
  description = "Cilium Helm template creation timeout"
  type        = number
  default     = 60
  nullable    = false
}