terraform {
  required_version = ">= 1.5.7"

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
    zitadel = {
      source = "zitadel/zitadel"
    }
  }
}