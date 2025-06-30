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

variable "storage_pools" {
  description = "Configuration of the storage (pools and directories) to import"
  type        = list(string)
  default     = []
}
