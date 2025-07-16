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

variable "user" {
  description = "User to own the gitops directory"
  type        = string
  default     = "gitops"
  nullable    = false
}

variable "group" {
  description = "Group to own the gitops directory"
  type        = string
  default     = "gitops"
  nullable    = false
}

variable "repository" {
  description = "Full path to the git repository; note: this will be owned by `user`:`group` and a symlink in `home_directory` will point to this directory"
  type        = string
  default     = "/mnt/storage/gitops"
  nullable    = false
}

variable "repository_symlink" {
  description = "Name of the symlink (directory), which will be created in `home_directory` and will point to `repository`"
  type        = string
  default     = "gitops"
  nullable    = false
}