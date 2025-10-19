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

variable "terraform_user" {
  description = "Configuration for Terraform provisioner user. Individual fields can be overridden."
  type = object({
    name    = optional(string, "terraform@pve")
    comment = optional(string, "Terraform automation user")
    role = object({
      name = optional(string, "TerraformProv")
      privileges = optional(list(string), [
        "VM.Allocate",
        "VM.Clone",
        "VM.Audit",
        "VM.Config.HWType",
        "VM.Config.Disk",
        "VM.Config.CPU",
        "VM.Config.Memory",
        "VM.Config.Network",
        "VM.Config.Cloudinit",
        "VM.Config.Options",
        "VM.PowerMgmt",
        "Datastore.Allocate",
        "Datastore.AllocateSpace",
        "Datastore.AllocateTemplate",
        "Datastore.Audit",
        "SDN.Use",
        "Sys.Audit",
        "Sys.Modify",
        "Mapping.Use",
        "Mapping.Modify"
      ])
    })
    token = object({
      name    = optional(string, "terraform-token")
      comment = optional(string, "Terraform automation user API token")
    })
  })

  default = {
    role  = {}
    token = {}
  }

  validation {
    condition = alltrue([
      for privilege in var.terraform_user.role.privileges :
      can(regex("^[A-Za-z]+\\.[A-Za-z]+(\\.?[A-Za-z]+)*$", privilege))
    ])
    error_message = "Each privilege must be in the format of 'Category.Action' or 'Category.Subcategory.Action'"
  }
}