resource "helm_release" "pihole" {
  name             = var.name
  namespace        = var.namespace
  create_namespace = true

  repository = "https://mojo2600.github.io/pihole-kubernetes"
  chart      = "pihole"
  version    = var.chart_version

  timeout         = var.timeout
  atomic          = true
  force_update    = true
  cleanup_on_fail = true

  values = compact([
    file("${path.module}/values.yaml"),
    var.values
  ])
}