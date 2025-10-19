terraform {
  required_version = ">= 1.10.5"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.69.0"
    }
    ssh = {
      source  = "loafoe/ssh"
      version = "~> 2.7"
    }
  }
}

provider "proxmox" {
  endpoint = var.proxmox.endpoint
  insecure = var.proxmox.insecure
  # use root@pam because of bind-mounts
  username = "root@pam"
  password = var.proxmox.root_password

  ssh {
    username    = var.proxmox.ssh_user
    private_key = file(var.proxmox.ssh_key)
  }
}