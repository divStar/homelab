terraform {
  required_version = ">= 1.8.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.78.2"
    }
    talos = {
      source  = "siderolabs/talos"
      version = ">= 0.8.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 3.0.1"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.1.3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.38.0"
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
  kubernetes = {
    host                   = module.talos_cluster_ready.kube_config.kubernetes_client_configuration.host
    client_certificate     = base64decode(module.talos_cluster_ready.kube_config.kubernetes_client_configuration.client_certificate)
    client_key             = base64decode(module.talos_cluster_ready.kube_config.kubernetes_client_configuration.client_key)
    cluster_ca_certificate = base64decode(module.talos_cluster_ready.kube_config.kubernetes_client_configuration.ca_certificate)
  }
}

provider "kubectl" {
  host                   = module.talos_cluster_ready.kube_config.kubernetes_client_configuration.host
  client_certificate     = base64decode(module.talos_cluster_ready.kube_config.kubernetes_client_configuration.client_certificate)
  client_key             = base64decode(module.talos_cluster_ready.kube_config.kubernetes_client_configuration.client_key)
  cluster_ca_certificate = base64decode(module.talos_cluster_ready.kube_config.kubernetes_client_configuration.ca_certificate)
  load_config_file       = false
}

provider "kubernetes" {
  host                   = module.talos_cluster_ready.kube_config.kubernetes_client_configuration.host
  client_certificate     = base64decode(module.talos_cluster_ready.kube_config.kubernetes_client_configuration.client_certificate)
  client_key             = base64decode(module.talos_cluster_ready.kube_config.kubernetes_client_configuration.client_key)
  cluster_ca_certificate = base64decode(module.talos_cluster_ready.kube_config.kubernetes_client_configuration.ca_certificate)
}