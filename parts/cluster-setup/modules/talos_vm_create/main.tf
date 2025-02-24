locals {
  control_plane_patches_dir = "control_plane_patches"
  worker_patches_dir        = "worker_patches"
  patches_dir               = var.node_machine_type == "controlplane" ? local.control_plane_patches_dir : local.worker_patches_dir
}

data "talos_machine_configuration" "this" {
  depends_on = [local_file.cilium_patch]

  cluster_name     = var.cluster.name
  cluster_endpoint = "https://${var.cluster.endpoint}:6443"
  talos_version    = var.cluster.talos_version
  machine_type     = var.node_machine_type
  machine_secrets  = var.talos_machine_secrets
  config_patches = [
    for patch in fileset("${path.module}/${local.patches_dir}", "*.yaml") : file("${path.module}/${local.patches_dir}/${patch}")
  ]
}

resource "talos_machine_configuration_apply" "this" {
  depends_on = [proxmox_virtual_environment_vm.this, local_file.cilium_patch]

  node                        = var.node_ip
  client_configuration        = var.talos_client_configuration
  machine_configuration_input = data.talos_machine_configuration.this.machine_configuration
  lifecycle {
    # re-run config apply if vm changes
    replace_triggered_by = [proxmox_virtual_environment_vm.this]
  }
}
