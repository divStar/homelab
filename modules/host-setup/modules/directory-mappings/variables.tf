variable "proxmox_node_name" {
  description = "Proxmox node name"
  type        = string
}

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

variable "directory_mappings" {
  description = "Directory mappings for the Proxmox node"
  # @field id name of the directory-mapping
  # @field path path to the actual directory, that's to be mapped
  # @field comment comment for the directory-mapping
  type = list(object({
    id      = string
    path    = string
    comment = optional(string, "")
  }))
  default = []
}
