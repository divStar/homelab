terraform {
  required_version = ">= 1.8.0"

  required_providers {
    ssh = {
      source  = "loafoe/ssh"
      version = "~> 2.7"
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