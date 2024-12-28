locals {
  control_plane_nodes = [for node in var.nodes : node.ip if node.machine_type == "controlplane"]
  worker_nodes        = [for node in var.nodes : node.ip if node.machine_type == "worker"]
}

resource "talos_machine_bootstrap" "this" {
  for_each = toset(local.control_plane_nodes)

  node                 = each.value
  endpoint             = var.cluster.endpoint
  client_configuration = var.talos_client_configuration

  timeouts = {
    create = var.bootstrap_timeout
  }
}

data "talos_cluster_health" "this" {
  skip_kubernetes_checks = false
  client_configuration   = var.talos_client_configuration
  endpoints              = local.control_plane_nodes
  control_plane_nodes    = local.control_plane_nodes
  worker_nodes           = local.worker_nodes

  timeouts = {
    read = var.health_check_timeout
  }
}

data "talos_machine_configuration" "this" {
  for_each         = toset([for node in var.nodes : node.name])
  cluster_name     = var.cluster.name
  cluster_endpoint = "https://${var.cluster.endpoint}:6443"
  machine_type     = "controlplane"
  machine_secrets  = var.talos_machine_secrets
}

resource "talos_cluster_kubeconfig" "this" {
  depends_on = [data.talos_cluster_health.this]

  node                 = var.cluster.endpoint
  endpoint             = var.cluster.endpoint
  client_configuration = var.talos_client_configuration
  timeouts = {
    read = var.kubeconfig_timeout
  }
}