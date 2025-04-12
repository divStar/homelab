output "ca_cert_pem" {
  description = "Proxmox public CA certificate in PEM format, trimmed"
  value       = trimspace(ssh_resource.proxmox_ca_cert.result)
}

output "key_pem" {
  description = "Generated key in PEM format, trimmed"
  value       = trimspace(tls_private_key.key.private_key_pem)
}

output "cert_pem" {
  description = "Generated certificate in PEM format, trimmed"
  value       = trimspace(tls_locally_signed_cert.cert.cert_pem)
}