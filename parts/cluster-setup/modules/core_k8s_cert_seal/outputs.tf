output "sealed_k8s_ca_tls" {
  value     = sealedsecret.k8s_ca.yaml_content
  sensitive = true
}

resource "local_file" "sealed_k8s_ca_tls_file" {
  filename        = "output/sealed_k8s_ca_tls.yaml"
  content         = sealedsecret.k8s_ca.yaml_content
  file_permission = "0600"
}