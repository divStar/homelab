variable "proxmox" {
  description = "Proxmox host configuration"
  type = object({
    name      = string
    endpoint  = string
    insecure  = bool
    api_token = string
    iso_store = optional(string, "local")
    ssh_user  = string # not used in talos_image
    ssh_key   = string # not used in talos_image
  })
}

variable "talos_linux_version" {
  description = "Version of Talos (Linux/Kubernetes) to install"
  type        = string
  nullable    = false
}

variable "schematic" {
  description = "Schematic configuration as YAML string"
  type        = string
  default     = "schematic/default.yaml"
  nullable    = false
}

variable "platform" {
  description = "Platform to use (e.g. metal, nocloud, aws, etc., see https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/image_factory_urls#platform-8)"
  type        = string
  default     = "nocloud"
  nullable    = false
}

variable "arch" {
  description = "Architecture to use (amd64 or arm64)"
  type        = string
  default     = "amd64"
  nullable    = false
}