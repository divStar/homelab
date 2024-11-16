terraform {
  required_providers {
    ssh = {
      source  = "loafoe/ssh"
      version = "~> 2.7"
    }
    restapi = {
      source  = "Mastercard/restapi"
      version = ">= 1.20.0"
    }
  }
}

provider "restapi" {
  uri = "https://${var.proxmox_configuration.host}:${var.proxmox_configuration.port}/api2/json"
  insecure = true  # For self-signed certs

  write_returns_object = true
  debug = true

  headers = {
    Authorization = local.token
    Content-Type  = "application/json"
  }

  create_returns_object = true
}