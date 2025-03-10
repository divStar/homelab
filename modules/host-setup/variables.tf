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

variable "packages" {
  description = "List of packages to install via apt-get"
  # @example ["git", "curl", "wget"]
  type    = list(string)
  default = []
}

variable "scripts" {
  description = "Configuration for script management including shared directory and script items"
  # @field directory Shared directory where all scripts will be downloaded to
  # @field items.name Name of the script file
  # @field items.url URL to download the script from
  # @field items.apply_params Parameters to pass when executing the script (defaults to "")
  # @field items.destroy_params Parameters to pass when cleaning up the script (defaults to "")
  # @field items.run_on_destroy Whether to execute the script with destroy_params before removal (defaults to true)
  # @example
  #   {
  #     directory = "/opt/scripts"
  #     items = [
  #       {
  #         name = "setup.sh"
  #         url = "https://example.com/setup.sh"
  #         apply_params = "--verbose"
  #       }
  #     ]
  #   }
  # @type object
  type = object({
    directory = optional(string, "scripts")
    items = list(object({
      name           = string
      url            = string
      apply_params   = optional(string, "")
      destroy_params = optional(string, "")
      run_on_destroy = optional(bool, true)
    }))
  })
  default = {
    directory = "scripts"
    items     = []
  }
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
        "VM.Monitor",
        "Datastore.Allocate",
        "Datastore.AllocateSpace",
        "Datastore.AllocateTemplate",
        "Datastore.Audit",
        "SDN.Use",
        "Sys.Audit",
        "Sys.Modify"
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

variable "no_subscription" {
  description = "Whether to use no-subscription repository instead of enterprise repository or not"
  # @field enabled true if no-subscription repository should be used, false otherwise
  # @field list_file Name of the file within the /etc/apt/sources.list.d/ directory
  # @field list_file_content Repository line to add (e.g. deb http://... <version> <name>)
  type = object({
    enabled           = bool
    list_file         = optional(string, "pve-no-subscription.list")
    list_file_content = optional(string, "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription")
  })

  default = {
    enabled = true
  }

  validation {
    condition     = !can(regex("\\s", var.no_subscription.list_file))
    error_message = "The 'list_file' field cannot contain whitespace characters"
  }
}