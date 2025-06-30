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