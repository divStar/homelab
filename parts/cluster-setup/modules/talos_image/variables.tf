variable "factory_url" {
  description = "URL of the Talos image factory"
  type        = string
  default     = "https://factory.talos.dev"
}

variable "talos_version" {
  description = "Talos version to use"
  type        = string
}

variable "schematic" {
  description = "Schematic configuration as YAML string"
  type        = string
}

variable "platform" {
  description = "Platform to use (e.g. metal, nocloud, aws, etc., see https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/image_factory_urls#platform-8)"
  type        = string
}

variable "arch" {
  description = "Architecture to use (amd64 or arm64)"
  type        = string
}

variable "proxmox" {
  description = "Proxmox host configuration"
  type = object({
    name      = string
    endpoint  = string
    datastore = string
    insecure  = bool
    api_token = string
  })
}