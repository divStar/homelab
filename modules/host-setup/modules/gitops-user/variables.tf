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

variable "gitops_user" {
  description = "Configuration of GitOps user."
  type = object({
    user        = optional(string, "gitops")
    group       = optional(string, "gitops")
    repo_name   = optional(string, "repo")
    source_repo = optional(string, "/storage-pool/gitops")
  })

  default = {}
}

variable "org_source_repo_owner" {
  description = "Original owner of the source repository (before, e.g. root:root)"
  type = object({
    owner = optional(string, "root")
    group = optional(string, "root")
  })

  default = {}
}