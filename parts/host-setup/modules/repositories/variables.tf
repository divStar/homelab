variable "ssh" {
  description = "SSH configuration for remote connection"
  # @field host The target host to connect to using SSH
  # @field user SSH user to connect with
  # @field id Path to SSH private key file (defaults to ~/.ssh/id_rsa)
  # @type object
  type = object({
    host    = string
    user    = string
    id_file = optional(string, "~/.ssh/id_rsa")
  })
}

variable "no_subscription" {
  description = "Whether to use no-subscription repository instead of enterprise repository or not"
  # @field enabled true if no-subscription repository should be used, false otherwise
  # @field list_file Name of the file within the /etc/apt/sources.list.d/ directory
  # @field list_file_content Repository line to add (e.g. deb http://... <version> <name>)
  type = object({
    enabled           = bool
    list_file         = optional(string, "pve-no-subscription.list")
    list_file_content = optional(string, "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription")
  })

  default = {
    enabled = true
  }

  validation {
    condition     = !can(regex("\\s", var.no_subscription.list_file))
    error_message = "The 'list_file' field cannot contain whitespace characters"
  }
}