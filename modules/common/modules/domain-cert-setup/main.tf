/**
 * # Domain certificate setup
 *
 * This module generates a domain certificate using the provided information.<br>
 * Note: it does _not_ output any files. 
 */

# Fetch Proxmox CA public certificate
resource "ssh_resource" "proxmox_ca_cert" {
  host        = var.proxmox.host
  user        = var.proxmox.ssh_user
  private_key = file(var.proxmox.ssh_key)

  # when = "create"

  commands = [
    "cat ${var.proxmox_root_ca.pve_root_cert}"
  ]
}

# Fetch Proxmox CA key
resource "ssh_resource" "proxmox_ca_key" {
  host        = var.proxmox.host
  user        = var.proxmox.ssh_user
  private_key = file(var.proxmox.ssh_key)

  # when = "create"

  commands = [
    "cat ${var.proxmox_root_ca.pve_root_key}"
  ]
}

# Define private key for the intermediate Kubernetes cluster certificate
resource "tls_private_key" "key" {
  algorithm = var.private_key.algorithm
  rsa_bits  = var.private_key.rsa_bits
}

# Create certificate request
resource "tls_cert_request" "cert_request" {
  private_key_pem = tls_private_key.key.private_key_pem

  subject {
    common_name  = var.subject.common_name
    organization = var.subject.organization
  }

  dns_names    = var.dns_names
  ip_addresses = var.ip_addresses
}

# Sign the certificate with the CA
resource "tls_locally_signed_cert" "cert" {
  cert_request_pem   = tls_cert_request.cert_request.cert_request_pem
  ca_cert_pem        = ssh_resource.proxmox_ca_cert.result
  ca_private_key_pem = ssh_resource.proxmox_ca_key.result

  allowed_uses          = var.allowed_uses
  validity_period_hours = var.validity_period_hours
  early_renewal_hours   = var.early_renewal_hours
}