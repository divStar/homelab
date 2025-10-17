terraform {
  required_version = ">= 1.10.5"

  required_providers {
    ssh = {
      source  = "loafoe/ssh"
      version = "~> 2.7"
    }
  }
}