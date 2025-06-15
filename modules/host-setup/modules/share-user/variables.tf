variable "ssh" {
  description = "SSH configuration for remote connection"
  type = object({
    host    = string
    user    = string
    id_file = optional(string, "~/.ssh/id_rsa")
  })
}

variable "share_user" {
  description = "Configuration of share user."

  type = object({
    user  = string
    group = string
    uid   = number
    gid   = number
  })

  default = {
    user  = "share-user"
    group = "share-users"
    uid   = 1000
    gid   = 1000
  }

  nullable = false
}