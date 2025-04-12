terraform {
  required_version = ">= 1.8.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.75.0"
    }
    ssh = {
      source  = "loafoe/ssh"
      version = "~> 2.7"
    }
  }
}