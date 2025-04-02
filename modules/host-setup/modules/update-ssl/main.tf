/**
 * # Update `pve-ssl` certificate with additional domain(s).
 *
 * Handles fetching the Proxmox CA certificate and key,
 * generating the `pve-ssl` certificate with additional
 * domain(s) and IP(s) anew and copying of it back onto
 * the host. 
 */
# Proxmox Certificate Management with Terraform
# Uses loafoe/ssh provider to interact with the Proxmox host
# and tls provider to generate certificates
# Proxmox Certificate Management with Terraform
# Uses loafoe/ssh provider to interact with the Proxmox host
# and tls provider to generate certificates
# Get current date for backup filenames
locals {
  timestamp = formatdate("YYYYMMDD", time_static.backup_timestamp.rfc3339)
}

resource "time_static" "backup_timestamp" {}

# Fetch Proxmox CA public certificate
resource "ssh_resource" "proxmox_ca_cert" {
  host        = var.ssh.host
  user        = var.ssh.user
  private_key = file(var.ssh.id_file)

  when = "create"

  commands = [
    "cat ${var.proxmox_root_ca.pve_root_cert}"
  ]
}

# Fetch Proxmox CA key
resource "ssh_resource" "proxmox_ca_key" {
  host        = var.ssh.host
  user        = var.ssh.user
  private_key = file(var.ssh.id_file)

  when = "create"

  commands = [
    "cat ${var.proxmox_root_ca.pve_root_key}"
  ]
}

# Generate private key for the SSL certificate
resource "tls_private_key" "pve_ssl_key" {
  algorithm = var.proxmox_domain_cert.private_key.algorithm
  rsa_bits  = var.proxmox_domain_cert.private_key.rsa_bits
}

# Create certificate request
resource "tls_cert_request" "pve_ssl_cert_request" {
  private_key_pem = tls_private_key.pve_ssl_key.private_key_pem

  subject {
    common_name         = var.proxmox_domain_cert.subject.common_name
    organization        = var.proxmox_domain_cert.subject.organization
    organizational_unit = var.proxmox_domain_cert.subject.organizational_unit
    country             = var.proxmox_domain_cert.subject.country
    locality            = var.proxmox_domain_cert.subject.locality
    province            = var.proxmox_domain_cert.subject.province
  }

  dns_names    = var.proxmox_domain_cert.dns_names
  ip_addresses = var.proxmox_domain_cert.ip_addresses
}

# Sign the certificate with the CA
resource "tls_locally_signed_cert" "pve_ssl_cert" {
  cert_request_pem   = tls_cert_request.pve_ssl_cert_request.cert_request_pem
  ca_cert_pem        = ssh_resource.proxmox_ca_cert.result
  ca_private_key_pem = ssh_resource.proxmox_ca_key.result

  validity_period_hours = var.proxmox_domain_cert.validity_period_hours

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

# Back up existing certificates
resource "ssh_resource" "backup_existing_certs" {
  host        = var.ssh.host
  user        = var.ssh.user
  private_key = file(var.ssh.id_file)

  when = "create"

  commands = [
    "cp /etc/pve/nodes/${var.proxmox_host}/pve-ssl.pem /etc/pve/nodes/${var.proxmox_host}/pve-ssl.pem.backup.${local.timestamp} || true",
    "cp /etc/pve/nodes/${var.proxmox_host}/pve-ssl.key /etc/pve/nodes/${var.proxmox_host}/pve-ssl.key.backup.${local.timestamp} || true"
  ]
}

# Install the new certificate and key on the Proxmox server
resource "ssh_resource" "install_pve_cert" {
  depends_on = [ssh_resource.backup_existing_certs]

  host        = var.ssh.host
  user        = var.ssh.user
  private_key = file(var.ssh.id_file)

  when = "create"

  # Install the private key
  file {
    content     = tls_private_key.pve_ssl_key.private_key_pem
    destination = "/etc/pve/nodes/${var.proxmox_host}/pve-ssl.key"
    permissions = "0640"
  }

  # Install the certificate
  file {
    content     = tls_locally_signed_cert.pve_ssl_cert.cert_pem
    destination = "/etc/pve/nodes/${var.proxmox_host}/pve-ssl.pem"
    permissions = "0640"
  }

  # Restart services to apply the new certificate
  commands = [
    "systemctl restart pveproxy"
  ]
}