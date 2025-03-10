/**
 * # Install `external-dns`
 *
 * Handles the setup of `external-dns`.
 */

locals {
  pihole_secret_yaml = yamldecode(
    templatefile("${path.module}/secret_pihole.yaml.tftpl", {
      namespace_external_dns = var.namespace
    })
  )
  pihole_secret_name = local.pihole_secret_yaml.metadata.name
  pihole_secret_data = local.pihole_secret_yaml.data
}

resource "kubectl_manifest" "external_dns_namespace" {
  yaml_body = templatefile("${path.module}/namespace.yaml.tftpl", {
    namespace = var.namespace
  })

  # No need to wait at this point
  wait = false
}

resource "sealedsecret" "pihole_secret" {
  name      = local.pihole_secret_name
  namespace = var.namespace

  data = local.pihole_secret_data
}

resource "kubectl_manifest" "install_pihole_secret" {
  depends_on = [sealedsecret.pihole_secret, kubectl_manifest.external_dns_namespace]
  yaml_body  = sealedsecret.pihole_secret.yaml_content

  wait = true
}

resource "helm_release" "external_dns" {
  provider   = helm.deploying
  depends_on = [kubectl_manifest.install_pihole_secret]

  name      = var.name
  namespace = var.namespace
  # Namespace must've been already created
  create_namespace = false

  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "external-dns"
  version    = var.chart_version

  timeout         = var.timeout
  atomic          = true
  force_update    = true
  cleanup_on_fail = true

  values = compact([
    templatefile("${path.module}/values.yaml.tftpl", {
      pihole_secret_name = local.pihole_secret_name
    }),
    var.values
  ])
}