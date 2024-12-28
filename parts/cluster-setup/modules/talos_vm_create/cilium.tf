locals {
  # since using a different namespace needs a namespace
  # creation resource, this is not a variable
  cilium_namespace = "kube-system"
}

data "helm_template" "cilium" {
  name       = var.cilium_name
  namespace  = local.cilium_namespace
  repository = var.cilium_repository
  chart      = var.cilium_chart
  version    = var.cilium_version
  timeout    = var.cilium_timeout

  kube_version = "1.32"

  values = [file("${path.module}/cilium/values.yaml")]
}

resource "local_file" "cilium_patch" {
  filename = "${path.module}/patches/03-install-cilium.yaml"
  content = <<-EOT
cluster:
  inlineManifests:
    - name: cilium-setup
      contents: >
        ${indent(8, data.helm_template.cilium.manifest)}
  EOT
  file_permission = "0600"

  depends_on = [data.helm_template.cilium]
}