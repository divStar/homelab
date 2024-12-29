locals {
  # since using a different namespace needs a namespace
  # creation resource, this is not a variable
  cilium_namespace = "kube-system"
}

data "helm_template" "cilium" {
  count = var.node_machine_type == "controlplane" ? 1 : 0

  name       = var.cilium_name
  namespace  = local.cilium_namespace
  repository = var.cilium_repository
  chart      = var.cilium_chart
  version    = var.cilium_version
  timeout    = var.cilium_timeout

  kube_version = var.target_kube_version

  values = [file("${path.module}/cilium/values.yaml")]
}

resource "local_file" "cilium_patch" {
  count = var.node_machine_type == "controlplane" ? 1 : 0

  filename = "${path.module}/${local.control_plane_patches_dir}/02-install-cilium.yaml"
  content = templatefile("${path.module}/${local.control_plane_patches_dir}/02-install-cilium.yaml.tftpl", {
    cilium_manifest = data.helm_template.cilium[0].manifest
    node_name       = var.node_name
  })
  file_permission = "0600"

  depends_on = [data.helm_template.cilium]
}