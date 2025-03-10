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

variable "configuration_files" {
  description = "Configuration files to copy to the host"
  # @field item.source Source of the file on the system, that OpenTofu / Terraform is running on
  # @field item.destination Destination of the file on the host
  # @field item.permissions Permissions of the file to be set on the host
  # @field item.owner (optional) Owner of the file to be set on the host
  # @field item.group (optional) Group of the file to be set on the host
  type = list(object({
    source      = string
    destination = string
    permissions = optional(number)
    owner       = optional(string)
    group       = optional(string)
  }))
}