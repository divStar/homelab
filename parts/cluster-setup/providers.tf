terraform {
  required_version = ">= 1.8.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.68.0"
    }
    talos = {
      source  = "siderolabs/talos"
      version = ">= 0.6.1"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox.endpoint
  insecure  = var.proxmox.insecure
  api_token = var.proxmox.api_token

  ssh {
    username    = var.proxmox.ssh_user
    private_key = file(var.proxmox.ssh_key)
  }
}