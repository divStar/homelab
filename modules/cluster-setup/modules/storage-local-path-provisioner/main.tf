/**
 * # Install `local-path-provisioner`
 *
 * Handles the setup of `local-path-provisioner` for local storage provisioning.
 */

resource "kubectl_manifest" "local_path_provisioner_namespace" {
  yaml_body = templatefile("${path.module}/namespace.yaml.tftpl", {
    namespace = var.namespace
  })

  wait = false
}

resource "helm_release" "local_path_provisioner" {
  provider   = helm.deploying
  depends_on = [kubectl_manifest.local_path_provisioner_namespace]

  name      = var.name
  namespace = var.namespace
  # Namespace must've been already created
  create_namespace = false

  repository = "https://charts.containeroo.ch"
  chart      = "local-path-provisioner"
  version    = var.chart_version

  timeout         = var.timeout
  atomic          = true
  force_update    = true
  cleanup_on_fail = true

  values = compact([
    templatefile("${path.module}/values.yaml.tftpl", {
      storage_path          = var.storage_path
      default_storage_class = var.default_storage_class
    }),
    var.values
  ])
}