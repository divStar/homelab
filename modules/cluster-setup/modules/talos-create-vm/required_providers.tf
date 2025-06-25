terraform {
  required_version = ">= 1.8.0"

  required_providers {
    proxmox = {
      source = "bpg/proxmox"
    }
    talos = {
      source = "siderolabs/talos"
    }
    helm = {
      source                = "hashicorp/helm"
      configuration_aliases = [helm.templating]
    }
  }
}