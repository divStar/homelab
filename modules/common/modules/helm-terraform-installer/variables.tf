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
  type = list(object({
    yaml = string
    wait_for = optional(object({
      fields = optional(list(object({
        key        = string
        value      = string
        value_type = optional(string, "eq")
      })), [])
      conditions = optional(list(object({
        type   = string
        status = string
      })), [])
    }))
  }))
  default  = []
  nullable = false

  # validation {
  #   condition     = alltrue([for pre_install_resource in var.pre_install_resources : can(yamldecode(pre_install_resource.yaml))])
  #   error_message = "All pre_install_resources must be valid YAML. Found this: \n${nonsensitive(join("\n---\n", [for r in var.pre_install_resources : r.yaml]))}"
  # }
}

variable "post_install_resources" {
  description = "List of resources to deploy before installing the application"
  type = list(object({
    yaml = string
    wait_for = optional(object({
      fields = optional(list(object({
        key        = string
        value      = string
        value_type = optional(string, "eq")
      })), [])
      conditions = optional(list(object({
        type   = string
        status = string
      })), [])
    }))
  }))
  default  = []
  nullable = false

  validation {
    condition     = alltrue([for post_install_resource in var.post_install_resources : can(yamldecode(post_install_resource.yaml))])
    error_message = "All post_install_resources must be valid YAML."
  }
}

variable "is_atomic" {
  description = "Specifies whether `helm_release` will deploy in an 'atomic', revertible way"
  type        = bool
  default     = true
  nullable    = false
}

variable "cleanup_on_fail" {
  description = "Specifies whether to clean up the `helm_release` if deployment fails; this setting is useful for debugging purposes"
  type        = bool
  default     = true
  nullable    = false
}