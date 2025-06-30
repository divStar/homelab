variable "chart_name" {
  description = "Helm Chart to install"
  type        = string
}

variable "chart_repo" {
  description = "Helm Chart repository"
  type        = string
}

variable "chart_version" {
  description = "Helm Chart version"
  type        = string
}

variable "release_name" {
  description = "Name of the Helm release"
  type        = string
  nullable    = false
}

variable "chart_values" {
  description = "Additional values to pass to the helm chart (in YAML format)"
  type        = string
  default     = ""
}

variable "chart_timeout" {
  description = "Time in seconds the Helm Chart installation times out after"
  type        = number
  default     = 120
  nullable    = false
}

variable "namespace" {
  description = "Kubernetes namespace to install into"
  type        = string
  nullable    = false
}

variable "is_privileged_namespace" {
  description = "Whether the Kubernetes namespace is a privileged namespace or not"
  type        = bool
  default     = false
  nullable    = false
}

variable "pre_install_resources" {
  description = "List of resources to deploy before installing the application"
  type        = list(string)
  default     = []
  nullable    = false

  validation {
    condition     = alltrue([for pre_install_resource in var.pre_install_resources : can(yamldecode(pre_install_resource))])
    error_message = "All pre_install_resources must be valid YAML."
  }
}

variable "post_install_resources" {
  description = "List of resources to deploy before installing the application"
  type        = list(string)
  default     = []
  nullable    = false

  validation {
    condition     = alltrue([for post_install_resource in var.post_install_resources : can(yamldecode(post_install_resource))])
    error_message = "All post_install_resources must be valid YAML."
  }
}
