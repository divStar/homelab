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
resource "tls_private_key" "pihole_key" {
  algorithm = var.pihole_domain_cert.private_key.algorithm
  rsa_bits  = var.pihole_domain_cert.private_key.rsa_bits
}

# Create certificate request
resource "tls_cert_request" "pihole_cert_request" {
  private_key_pem = tls_private_key.pihole_key.private_key_pem

  subject {
    common_name         = var.pihole_domain_cert.subject.common_name
    organization        = var.pihole_domain_cert.subject.organization
    organizational_unit = var.pihole_domain_cert.subject.organizational_unit
    country             = var.pihole_domain_cert.subject.country
    locality            = var.pihole_domain_cert.subject.locality
    province            = var.pihole_domain_cert.subject.province
  }

  dns_names    = var.pihole_domain_cert.dns_names
  ip_addresses = var.pihole_domain_cert.ip_addresses
}

# Sign the certificate with the CA
resource "tls_locally_signed_cert" "pihole_cert" {
  cert_request_pem   = tls_cert_request.pihole_cert_request.cert_request_pem
  ca_cert_pem        = ssh_resource.proxmox_ca_cert.result
  ca_private_key_pem = ssh_resource.proxmox_ca_key.result

  validity_period_hours = var.pihole_domain_cert.validity_period_hours

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
    "client_auth" # Allows for client authentication if needed
  ]

  # Add early renewal option if desired
  early_renewal_hours = 720 # Renew 30 days before expiry
}

resource "ssh_resource" "install_pihole_cert" {
  depends_on = [ssh_resource.install_pihole]

  when = "create"

  host        = var.pihole_ip
  user        = "root"
  private_key = tls_private_key.alpine_ssh_key.private_key_pem

  file {
    content     = <<-EOT
      ${trimspace(tls_private_key.pihole_key.private_key_pem)}
    
      ${trimspace(tls_locally_signed_cert.pihole_cert.cert_pem)}
    EOT
    destination = "/etc/pihole/tls.pem"
    permissions = "0600"
  }

  pre_commands = [
    <<-EOT
      # Remove stock certificate files
      rm /etc/pihole/tls*
    EOT
  ]

  commands = [
    <<-EOT
      # Restart pihole-FTL
      rc-service pihole-FTL restart
    EOT
  ]
}