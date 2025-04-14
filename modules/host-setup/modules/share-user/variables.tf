variable "ssh" {
  description = "SSH configuration for remote connection"
  type = object({
    host    = string
    user    = string
    id_file = optional(string, "~/.ssh/id_rsa")
  })
}

variable "share_user" {
  description = "Configuration of GitOps user."

  type = object({
    user  = string
    group = string
    uid   = number
    gid   = number
  })

  default = {
    user  = "share-user"
    group = "share-users"
    uid   = 1400
    gid   = 1400
  }

  nullable = false
}