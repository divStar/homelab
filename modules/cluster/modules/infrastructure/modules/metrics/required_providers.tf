terraform {
  required_version = ">= 1.8.0"

  required_providers {
    kubectl = {
      source = "alekc/kubectl"
    }
    talos = {
      source = "siderolabs/talos"
    }
  }
}