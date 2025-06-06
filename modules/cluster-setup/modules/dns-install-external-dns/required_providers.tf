terraform {
  required_version = ">= 1.8.0"

  required_providers {
    sealedsecret = {
      source  = "jifwin/sealedsecret"
      version = ">=1.1.16"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.19.0"
    }
    helm = {
      source                = "hashicorp/helm"
      version               = ">= 2.17.0"
      configuration_aliases = [helm.deploying]
    }
  }
}