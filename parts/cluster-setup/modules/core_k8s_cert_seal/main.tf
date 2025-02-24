resource "sealedsecret" "k8s_ca" {
  name      = var.secret_name
  namespace = var.secret_namespace

  data = {
    "tls.crt" : var.k8s_ca_tls_crt
    "tls.key" : var.k8s_ca_tls_key
  }
}