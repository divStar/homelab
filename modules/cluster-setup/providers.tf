terraform {
  required_version = ">= 1.8.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.69.0"
    }
    talos = {
      source  = "siderolabs/talos"
      version = ">= 0.7.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.17.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.19.0"
    }
    sealedsecret = {
      version = ">=1.1.16"
      source  = "jifwin/sealedsecret"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox.endpoint
  insecure  = var.proxmox.insecure
  api_token = var.proxmox.api_token

  ssh {
    username    = var.proxmox.ssh_user
    private_key = file(var.proxmox.ssh_key)
  }
}

provider "talos" {
  image_factory_url = var.cluster.talos_factory_url
}

provider "helm" {
  alias = "templating"

  kubernetes {}
}

provider "helm" {
  alias = "deploying"

  kubernetes {
    host                   = module.await_talos_cluster.kube_config.kubernetes_client_configuration.host
    client_certificate     = base64decode(module.await_talos_cluster.kube_config.kubernetes_client_configuration.client_certificate)
    client_key             = base64decode(module.await_talos_cluster.kube_config.kubernetes_client_configuration.client_key)
    cluster_ca_certificate = base64decode(module.await_talos_cluster.kube_config.kubernetes_client_configuration.ca_certificate)
  }
}

provider "kubectl" {
  host                   = module.await_talos_cluster.kube_config.kubernetes_client_configuration.host
  client_certificate     = base64decode(module.await_talos_cluster.kube_config.kubernetes_client_configuration.client_certificate)
  client_key             = base64decode(module.await_talos_cluster.kube_config.kubernetes_client_configuration.client_key)
  cluster_ca_certificate = base64decode(module.await_talos_cluster.kube_config.kubernetes_client_configuration.ca_certificate)
  load_config_file       = false
}

provider "sealedsecret" {
  controller_name      = var.sealed_secrets_controller_name
  controller_namespace = var.sealed_secrets_namespace

  kubernetes {
    host                   = module.await_talos_cluster.kube_config.kubernetes_client_configuration.host
    client_certificate     = base64decode(module.await_talos_cluster.kube_config.kubernetes_client_configuration.client_certificate)
    client_key             = base64decode(module.await_talos_cluster.kube_config.kubernetes_client_configuration.client_key)
    cluster_ca_certificate = base64decode(module.await_talos_cluster.kube_config.kubernetes_client_configuration.ca_certificate)
  }
}