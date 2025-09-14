terraform {
  required_version = ">= 1.8.0"

  required_providers {
    kubectl = {
      source = "alekc/kubectl"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    helm = {
      source = "hashicorp/helm"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}