/**
 * # Install `longhorn`
 *
 * Handles the setup of `longhorn` (storage solution for PV/PVCs).
 */

resource "kubectl_manifest" "longhorn_namespace" {
  yaml_body = templatefile("${path.module}/namespace.yaml.tftpl", {
    namespace = var.namespace
  })

  wait = true
}

resource "helm_release" "longhorn" {
  provider = helm.deploying

  depends_on = [kubectl_manifest.longhorn_namespace]

  name      = var.name
  namespace = var.namespace
  # We create the namespace on our own
  create_namespace = false

  repository = "https://charts.longhorn.io"
  chart      = "longhorn"
  version    = var.chart_version

  timeout         = var.timeout
  atomic          = true
  force_update    = true
  cleanup_on_fail = true

  values = compact([
    templatefile("${path.module}/values.yaml.tftpl", {
      replica_count = var.nodes_count
      service_host  = var.service_host
      ca_issuer     = var.ca_issuer
    }),
    var.values
  ])
}