terraform {
  required_version = ">= 1.8.0"

  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
}