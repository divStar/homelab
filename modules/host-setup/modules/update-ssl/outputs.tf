# Output the certificate details for verification
output "certificate_info" {
  value = {
    subject          = tls_cert_request.pve_ssl_cert_request.subject
    domains          = tls_cert_request.pve_ssl_cert_request.dns_names
    ip_addresses     = tls_cert_request.pve_ssl_cert_request.ip_addresses
    validity_hours   = var.proxmox_domain_cert.validity_period_hours
    backup_timestamp = local.timestamp
  }
}