terraform {
  required_providers {
    ssh = {
      source  = "loafoe/ssh"
      version = "~> 2.7"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.13.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.6"
    }
  }
}
