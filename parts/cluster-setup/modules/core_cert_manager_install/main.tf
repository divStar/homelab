resource "helm_release" "cert_manager" {
  provider = helm.deploying

  name             = var.name
  namespace        = var.namespace
  create_namespace = true

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
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