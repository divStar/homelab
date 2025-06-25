terraform {
  required_version = ">= 1.8.0"

  required_providers {
    sealedsecret = {
      source = "jifwin/sealedsecret"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
    }
    helm = {
      source                = "hashicorp/helm"
      configuration_aliases = [helm.deploying]
    }
  }
}