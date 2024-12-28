terraform {
  required_version = ">= 1.8.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.69.0"
    }
    talos = {
      source  = "siderolabs/talos"
      version = ">= 0.7.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.17.0"
    }
  }
}