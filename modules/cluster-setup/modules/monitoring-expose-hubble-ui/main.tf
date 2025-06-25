/**
 * # Expose Hubble UI (Cilium)
 *
 * Exposes the Hubble UI from Cilium CNI.
 */

resource "kubectl_manifest" "cilium_namespace" {
  yaml_body = templatefile("${path.module}/ingress.yaml.tftpl", {
    ca_issuer    = var.ca_issuer
    service_host = var.service_host
  })

  wait = true
}