terraform {
  required_version = ">= 1.10.5"

  required_providers {
    proxmox = {
      source = "bpg/proxmox"
    }
    talos = {
      source = "siderolabs/talos"
    }
  }
}