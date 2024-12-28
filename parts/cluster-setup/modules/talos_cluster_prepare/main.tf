resource "talos_machine_secrets" "this" {
  talos_version = var.cluster.talos_version
}

data "talos_client_configuration" "this" {
  cluster_name         = var.cluster.name
  client_configuration = talos_machine_secrets.this.client_configuration
  nodes                = [for node in var.nodes : node.ip]
  endpoints            = [for node in var.nodes : node.ip if node.machine_type == "controlplane"]
}