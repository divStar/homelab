locals {
  cilium_patch_file   = "01-install-cilium.yaml"
  patch_file          = "${path.module}/${local.control_plane_patches_dir}/${local.cilium_patch_file}"
  patch_template_file = "${local.patch_file}.tftpl"

  cilium_values_template_file = "values.yaml.tftpl"
  values_template_file        = "${path.module}/cilium/${local.cilium_values_template_file}"
}

data "helm_template" "cilium" {
  provider = helm.templating

  count = var.node_machine_type == "controlplane" ? 1 : 0

  name       = var.cilium_name
  namespace  = var.cilium_namespace
  repository = var.cilium_repository
  chart      = var.cilium_chart
  version    = var.cilium_version
  timeout    = var.cilium_timeout

  kube_version = var.target_kube_version

  values = [templatefile(local.values_template_file, {
    cluster_name              = var.cluster.name
    cluster_loadbalancer_cidr = var.cluster.lb_cidr
  })]
}

resource "local_file" "cilium_patch" {
  count = var.node_machine_type == "controlplane" ? 1 : 0

  depends_on = [data.helm_template.cilium]

  filename = local.patch_file
  content = templatefile(local.patch_template_file, {
    cilium_namespace         = var.cilium_namespace
    cilium_manifest          = data.helm_template.cilium[0].manifest
    cilium_loadbalancer_cidr = var.cluster.lb_cidr
  })
  file_permission = "0600"
}