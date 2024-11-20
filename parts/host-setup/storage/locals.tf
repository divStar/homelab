locals {
  # SSH connection settings for reuse
  ssh = {
    host        = var.ssh.host
    user        = var.ssh.user
    private_key = file(var.ssh.id_file)
  }

  proxmox = {
    name = var.proxmox.name
    host = var.proxmox.host
    port = var.proxmox.port
  }

  token = var.token

  # Storage data
  pools       = [for item in var.storage : item if item.type == "pool"]
  directories = [for item in var.storage : item if item.type == "directory"]

  storage_api_url = "https://${local.proxmox.host}:${local.proxmox.port}/api2/json/storage"
  storage_api_headers = {
    "Content-Type"  = "application/json"
    "Authorization" = "${local.token}"
  }
}