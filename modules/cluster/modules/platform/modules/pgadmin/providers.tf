terraform {
  required_version = ">= 1.8.0"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.7.2"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 3.0.1"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.1.3"
    }
  }
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}

provider "kubectl" {
  load_config_file = true
}