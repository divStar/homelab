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
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.6"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.13.0"
    }
  }
}

provider "restapi" {
  uri      = "https://${local.proxmox.host}:${local.proxmox.port}/api2/json"
  insecure = true # For self-signed certs

  write_returns_object = true
  debug                = true

  headers = {
    Authorization = local.token
    Content-Type  = "application/json"
  }

  create_returns_object = true
}