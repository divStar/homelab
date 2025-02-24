output "k8s_ca_tls_crt" {
  description = "Contains the intermediate Kubernetes CA public certificate"
  value       = tls_locally_signed_cert.k8s_ca.cert_pem
  sensitive   = true
}

output "k8s_ca_tls_key" {
  description = "Contains the intermediate Kubernetes CA private key"
  value       = tls_private_key.k8s_ca.private_key_pem
  sensitive   = true
}

resource "local_file" "k8s_ca_tls_crt_file" {
  filename        = "output/k8s_ca_tls.crt"
  content         = tls_locally_signed_cert.k8s_ca.cert_pem
  file_permission = "0600"
}

resource "local_file" "k8s_ca_tls_key_file" {
  filename        = "output/k8s_ca_tls.key"
  content         = tls_private_key.k8s_ca.private_key_pem
  file_permission = "0600"
}