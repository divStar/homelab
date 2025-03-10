/**
 * # Setup k8s intermediate CA
 *
 * Handles the setup the intermediate Kubernetes CA certificate.
 * In particular:
 * * it creates the CA certificate from the Proxmox CA certificate
 * * seals the CA certificate
 * * applies it to the running Talos Kubernetes cluster
 */

locals {
  sealed_secret_yaml = yamldecode(sealedsecret.k8s_ca.yaml_content)
  secret_name        = local.sealed_secret_yaml.metadata.name

  cluster_issuer_yaml = templatefile("${path.module}/cluster_issuer.yaml.tftpl", {
    k8s_ca_secret_name = local.secret_name
  })
  cluster_issuer_yaml_decoded = yamldecode(local.cluster_issuer_yaml)
}

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

# Create sealed-secret of the intermediate Kubernetes CA certificate
resource "sealedsecret" "k8s_ca" {
  name      = var.secret_name
  namespace = var.secret_namespace

  data = {
    "tls.crt" : tls_locally_signed_cert.k8s_ca.cert_pem
    "tls.key" : tls_private_key.k8s_ca.private_key_pem
  }
}

# Install the sealed-secret
resource "kubectl_manifest" "install_sealed_k8s_ca_tls" {
  yaml_body = sealedsecret.k8s_ca.yaml_content

  wait = true
}

# Install the ClusterIssuer resource
resource "kubectl_manifest" "install_cluster_issuer" {
  depends_on = [kubectl_manifest.install_sealed_k8s_ca_tls]

  yaml_body = local.cluster_issuer_yaml

  wait = true
}