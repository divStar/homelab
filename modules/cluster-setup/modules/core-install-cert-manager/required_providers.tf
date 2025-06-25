terraform {
  required_version = ">= 1.8.0"

  required_providers {
    helm = {
      source                = "hashicorp/helm"
      configuration_aliases = [helm.deploying]
    }
  }
}