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

variable "ssh_key_file" {
  description = "Path to SSH public key file to add to authorized_keys (e.g. ~/.ssh/id_rsa.pub)"
  type        = string
}

variable "target_user" {
  description = "Username to add SSH key for"
  type        = string
}

variable "repo_name" {
  description = "Name of the symbolic link to the actual gitops git repository"
  type        = string
}

variable "git_access_mode" {
  description = "Git access mode: 'read-only' or 'read-write'"
  type        = string
  default     = "read-write"

  validation {
    condition     = contains(["read-only", "read-write"], var.git_access_mode)
    error_message = "git_access_mode must be either 'read-only' or 'read-write'"
  }
}