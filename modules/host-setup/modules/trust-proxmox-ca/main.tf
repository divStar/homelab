/**
 * # Trust Proxmox CA certificate (add to trust store).
 *
 * This module installs the already existing Proxmox CA to the Proxmox host's
 * own trust store and updates the certificates.
 *
 * Note: this is necessary for the `lldap-setup` LXC container to connect
 * via LDAPS while also verifying the self-signed certificate.
 */
# Fetch Proxmox CA public certificate
resource "ssh_resource" "install_proxmox_ca" {
  host        = var.ssh.host
  user        = var.ssh.user
  private_key = file(var.ssh.id_file)

  # when = "create"

  commands = [
    "cp ${var.pve_root_ca_pem_source} ${var.pve_root_ca_pem_target}",
    "update-ca-certificates"
  ]
}

resource "ssh_resource" "uninstall_proxmox_ca" {
  host        = var.ssh.host
  user        = var.ssh.user
  private_key = file(var.ssh.id_file)

  when = "destroy"

  commands = [
    "rm ${var.pve_root_ca_pem_target}",
    "update-ca-certificates"
  ]
}

resource "ssh_resource" "restart_pveproxy" {
  count       = var.restart_pveproxy ? 1 : 0
  host        = var.ssh.host
  user        = var.ssh.user
  private_key = file(var.ssh.id_file)

  # when = "create"

  commands = [
    "systemctl restart pveproxy"
  ]
}