terraform {
  required_version = ">= 1.8.0"

  required_providers {
    helm = {
      source                = "hashicorp/helm"
      version               = ">= 2.17.0"
      configuration_aliases = [helm.deploying]
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.19.0"
    }
  }
}