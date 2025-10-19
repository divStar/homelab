terraform {
  required_version = ">= 1.10.5"

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
    zitactl = {
      source = "divstar/zitactl"
    }
  }
}