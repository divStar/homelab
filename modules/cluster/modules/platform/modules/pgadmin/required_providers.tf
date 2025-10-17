terraform {
  required_version = ">= 1.10.5"

  required_providers {
    kubectl = {
      source = "alekc/kubectl"
    }
    helm = {
      source = "hashicorp/helm"
    }
    random = {
      source = "hashicorp/random"
    }
    zitactl = {
      source = "divstar/zitactl"
    }
  }
}