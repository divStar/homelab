terraform {
  required_version = ">= 1.8.0"

  required_providers {
    ssh = {
      source  = "loafoe/ssh"
      version = "~> 2.7"
    }
    sealedsecret = {
      source  = "jifwin/sealedsecret"
      version = ">=1.1.16"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.19.0"
    }
  }
}