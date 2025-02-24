# Fetch public CA certificate
resource "ssh_resource" "proxmox_ca_cert" {
  host        = var.proxmox.host
  user        = var.proxmox.ssh_user
  private_key = file(var.proxmox.ssh_key)

  commands = [
    "cat ${var.proxmox_root_ca.pve_root_cert}"
  ]
}

# Fetch CA key
resource "ssh_resource" "proxmox_ca_key" {
  host        = var.proxmox.host
  user        = var.proxmox.ssh_user
  private_key = file(var.proxmox.ssh_key)

  commands = [
    "cat ${var.proxmox_root_ca.pve_root_key}"
  ]
}

# Define private key for the intermediate Kubernetes cluster certificate
resource "tls_private_key" "k8s_ca" {
  algorithm = var.k8s_ca.private_key.algorithm
  rsa_bits  = var.k8s_ca.private_key.rsa_bits
}

# Define the intermediate Kubernetes cluster certificate using the private key
resource "tls_cert_request" "k8s_ca" {
  private_key_pem = tls_private_key.k8s_ca.private_key_pem

  subject {
    common_name         = var.k8s_ca.subject.common_name
    organization        = var.k8s_ca.subject.organization
    organizational_unit = var.k8s_ca.subject.organizational_unit
    country             = var.k8s_ca.subject.country
    locality            = var.k8s_ca.subject.locality
    province            = var.k8s_ca.subject.province
  }
}

# Locally sign the intermediate Kubernetes cluster certificate
resource "tls_locally_signed_cert" "k8s_ca" {
  cert_request_pem   = tls_cert_request.k8s_ca.cert_request_pem
  ca_private_key_pem = ssh_resource.proxmox_ca_key.result
  ca_cert_pem        = ssh_resource.proxmox_ca_cert.result

  validity_period_hours = var.k8s_ca.validity_period_hours

  is_ca_certificate = true

  allowed_uses = [
    "cert_signing",
    "crl_signing"
  ]
}