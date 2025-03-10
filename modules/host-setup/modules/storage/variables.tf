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

variable "proxmox" {
  description = "Proxmox host configuration"
  # @field name The name of the Proxmox node
  # @field host The target host for Proxmox API use
  # @field port The port to use for Proxmox API
  type = object({
    name = string
    host = string
    port = number
  })
}

variable "storage" {
  description = "Configuration of the storage (pools and directories) to import"
  # @field type[*].name           name / ID of the storage pool or directory
  # @field type[*].type           type of the storage; valid values are: pool, directory
  # @field type[*].path           (only if type=directory) path of the directory on the host
  # @field type[*].content_types  (only if type=directory) content types of the directory; valid values are: iso, vztmpl, backup, snippets, rootdir, images
  type = list(object({
    name = string
    type = string # "pool" or "directory"
    # For directories only:
    path          = optional(string)
    content_types = optional(list(string))
  }))

  validation {
    condition     = alltrue([for item in var.storage : contains(["pool", "directory"], item.type)])
    error_message = "Storage type must be either 'pool' or 'directory'."
  }

  validation {
    condition = alltrue([
      for item in var.storage :
      item.type == "directory" ? (item.content_types != null && length(item.content_types) > 0) : true
    ])
    error_message = "Directories must have at least one content_type specified."
  }

  validation {
    condition = alltrue([
      for item in var.storage :
      item.type == "directory" ?
      alltrue([
        for content_type in item.content_types :
        contains(["iso", "vztmpl", "backup", "snippets", "rootdir", "images"], content_type)
      ]) : true
    ])
    error_message = "Content types must be one or more of: iso, vztmpl, backup, snippets, rootdir, images."
  }
}

variable "token" {
  description = "API token for the terraform user on the Proxmox host"
  type        = string
}