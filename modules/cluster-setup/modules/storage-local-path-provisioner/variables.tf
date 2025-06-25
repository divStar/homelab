variable "chart_version" {
  description = "Helm Chart version to install"
  type        = string
}

variable "name" {
  description = "Name of the Helm release"
  type        = string
  default     = "local-path-provisioner"
  nullable    = false
}

variable "namespace" {
  description = "Kubernetes namespace to install into"
  type        = string
  default     = "local-path-storage"
  nullable    = false
}

variable "timeout" {
  description = "Time in seconds to wait for the Helm Chart to be installed"
  type        = number
  default     = 120
  nullable    = false
}

variable "storage_path" {
  description = "Host path for local storage provisioning (Talos uses /var/mnt/local-path-provisioner)"
  type        = string
  default     = "/var/mnt/local-path-provisioner"
  nullable    = false
}

variable "default_storage_class" {
  description = "Whether to set this as the default StorageClass"
  type        = bool
  default     = true
  nullable    = false
}

variable "values" {
  description = "Additional values to pass to the helm chart (in YAML format)"
  type        = string
  default     = ""
}
