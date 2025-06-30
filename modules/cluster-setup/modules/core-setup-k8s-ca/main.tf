/**
 * # Setup cert-manager ACME issuer
 *
 * Handles the setup of cert-manager ACME ClusterIssuer for Step CA.
 * This configures cert-manager to use the Step CA ACME server
 * for automatic certificate issuance via HTTP-01 challenges.
 */

locals {
  cluster_issuer_yaml = templatefile("${path.module}/cluster_issuer.yaml.tftpl", {
    acme_server_directory_url = var.acme_server_directory_url
    acme_contact              = var.acme_contact
    secret_name               = var.secret_name
    acme_root_certificate     = data.http.step_ca_root_pem.response_body
  })

  cluster_issuer_name = yamldecode(local.cluster_issuer_yaml).metadata.name
}

data "http" "step_ca_root_pem" {
  url                = "https://${var.step_ca_host}/roots.pem"
  request_timeout_ms = 5000
}

# Install the ACME ClusterIssuer resource
resource "kubectl_manifest" "install_acme_cluster_issuer" {
  yaml_body = local.cluster_issuer_yaml

  wait = true
}