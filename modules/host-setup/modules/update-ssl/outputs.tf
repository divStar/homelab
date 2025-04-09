output "certificate_info" {
  description = "pve-ssl Certificate information"
  value = {
    subject          = tls_cert_request.pve_ssl_cert_request.subject
    domains          = tls_cert_request.pve_ssl_cert_request.dns_names
    ip_addresses     = tls_cert_request.pve_ssl_cert_request.ip_addresses
    validity_hours   = var.proxmox_domain_cert.validity_period_hours
    backup_timestamp = local.timestamp
  }
}