locals {
  sealed_secret = yamldecode(var.sealed_k8s_ca_tls)
  secret_name   = local.sealed_secret.metadata.name

  cluster_issuer_yaml = templatefile("${path.module}/cluster_issuer.yaml.tftpl", {
    k8s_ca_secret_name = local.secret_name
  })
  cluster_issuer_yaml_decoded = yamldecode(local.cluster_issuer_yaml)
}

resource "kubectl_manifest" "install_sealed_k8s_ca_tls" {
  yaml_body = var.sealed_k8s_ca_tls

  wait = true
}

resource "kubectl_manifest" "install_cluster_issuer" {
  depends_on = [kubectl_manifest.install_sealed_k8s_ca_tls]

  yaml_body = local.cluster_issuer_yaml

  wait = true
}