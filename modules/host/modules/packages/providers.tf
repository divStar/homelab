terraform {
  required_version = ">= 1.8.0"

  required_providers {
    ssh = {
      source = "loafoe/ssh"
    }
  }
}