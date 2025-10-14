/**
 * # Prepare Talos cluster
 *
 * Creates the Talos machine secrets and the Talos client configuration.
 */

resource "talos_machine_secrets" "this" {
  talos_version = var.talos_linux_version
}

# Defines the Talos client configuration
data "talos_client_configuration" "this" {
  cluster_name         = var.cluster_name
  client_configuration = talos_machine_secrets.this.client_configuration
  nodes                = [for node in var.nodes : node.ip]
  endpoints            = [for node in var.nodes : node.ip if node.machine_type == "controlplane"]
}