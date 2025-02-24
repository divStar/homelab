resource "kubectl_manifest" "longhorn_namespace" {
  yaml_body = templatefile("${path.module}/ingress.yaml.tftpl", {
    ca_issuer    = var.ca_issuer
    service_host = var.service_host
  })

  wait = true
}