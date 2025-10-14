terraform {
  required_version = ">= 1.5.7"

  required_providers {
    kubectl = {
      source = "alekc/kubectl"
    }
    helm = {
      source = "hashicorp/helm"
    }
  }
}