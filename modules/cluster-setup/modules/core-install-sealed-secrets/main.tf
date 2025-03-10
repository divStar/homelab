/**
 * # Install `sealed-secrets`
 *
 * Handles the setup of `sealed-secrets`.
 */

resource "helm_release" "sealed_secrets" {
  provider = helm.deploying

  name             = var.name
  namespace        = var.namespace
  create_namespace = true

  repository = "https://bitnami-labs.github.io/sealed-secrets"
  chart      = "sealed-secrets"
  version    = var.chart_version

  timeout         = var.timeout
  atomic          = true
  force_update    = true
  cleanup_on_fail = true

  values = compact([var.values])
}