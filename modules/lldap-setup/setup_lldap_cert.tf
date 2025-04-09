# Fetch Proxmox CA public certificate
resource "ssh_resource" "proxmox_ca_cert" {
  host        = var.proxmox.host
  user        = var.proxmox.ssh_user
  private_key = file(var.proxmox.ssh_key)

  when = "create"

  commands = [
    "cat ${var.proxmox_root_ca.pve_root_cert}"
  ]
}

# Fetch Proxmox CA key
resource "ssh_resource" "proxmox_ca_key" {
  host        = var.proxmox.host
  user        = var.proxmox.ssh_user
  private_key = file(var.proxmox.ssh_key)

  when = "create"

  commands = [
    "cat ${var.proxmox_root_ca.pve_root_key}"
  ]
}

# Define private key for the intermediate Kubernetes cluster certificate
resource "tls_private_key" "lldap_key" {
  algorithm = var.lldap_domain_cert.private_key.algorithm
  rsa_bits  = var.lldap_domain_cert.private_key.rsa_bits
}

# Create certificate request
resource "tls_cert_request" "lldap_cert_request" {
  private_key_pem = tls_private_key.lldap_key.private_key_pem

  subject {
    common_name         = var.lldap_domain_cert.subject.common_name
    organization        = var.lldap_domain_cert.subject.organization
    organizational_unit = var.lldap_domain_cert.subject.organizational_unit
    country             = var.lldap_domain_cert.subject.country
    locality            = var.lldap_domain_cert.subject.locality
    province            = var.lldap_domain_cert.subject.province
  }

  dns_names    = var.lldap_domain_cert.dns_names
  ip_addresses = var.lldap_domain_cert.ip_addresses
}

# Sign the certificate with the CA
resource "tls_locally_signed_cert" "lldap_cert" {
  cert_request_pem   = tls_cert_request.lldap_cert_request.cert_request_pem
  ca_cert_pem        = ssh_resource.proxmox_ca_cert.result
  ca_private_key_pem = ssh_resource.proxmox_ca_key.result

  validity_period_hours = var.lldap_domain_cert.validity_period_hours

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth" # Allows for client authentication if needed
  ]

  # Add early renewal option if desired
  early_renewal_hours = 720 # Renew 30 days before expiry
}

resource "ssh_resource" "install_lldap_cert" {
  depends_on = [ssh_resource.install_packages]

  when = "create"

  host        = var.lldap_ip
  user        = "root"
  private_key = tls_private_key.alpine_ssh_key.private_key_pem

  file {
    content     = "${trimspace(tls_private_key.lldap_key.private_key_pem)}"
    destination = "/data/key.pem"
    permissions = "0644"
  }

  file {
    content     = "${trimspace(tls_locally_signed_cert.lldap_cert.cert_pem)}"
    destination = "/data/cert.pem"
    permissions = "0644"
  }
}