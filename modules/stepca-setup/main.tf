/**
 * # Step-CA Setup
 *
 * This module sets up Step-CA in an Alpine LXC container using the provided information.
 */
locals {
  timestamp            = "+%Y-%m-%d-%H-%M-%S"
  setup_host_script    = "setup-host.sh"
  teardown_host_script = "teardown-host.sh"
}

# Alpine LXC container setup
module "setup_container" {
  source = "../common/modules/alpine-setup"

  proxmox = {
    host     = var.proxmox.host
    name     = var.proxmox.name
    ssh_user = var.proxmox.ssh_user
    ssh_key  = var.proxmox.ssh_key
  }
  vm_id          = var.vm_id
  hostname       = var.hostname
  description    = var.description
  mount_points   = var.mount_points
  imagestore_id  = var.imagestore_id
  ni_ip          = var.ni_ip
  ni_gateway     = var.ni_gateway
  ni_mac_address = var.ni_mac_address
  ni_subnet_mask = var.ni_subnet_mask
  ni_name        = var.ni_name
  ni_bridge      = var.ni_bridge
  startup_order  = var.startup_order
}

# Configure Step-CA
resource "ssh_resource" "configure_container" {
  # when = "create"

  depends_on = [module.setup_container]

  host        = var.ni_ip
  user        = "root"
  private_key = module.setup_container.ssh_private_key

  commands = [
    <<-EOT
      apk add step-cli step-certificates
      rc-service step-ca start
      step ca bootstrap --ca-url https://${var.ni_ip} --fingerprint $(echo "${file(var.fingerprint_file)}") --install --force

      echo "${file("${var.proxmox.ssh_key}.pub")}" >> /root/.ssh/authorized_keys
      rc-service sshd restart
    EOT
  ]

  timeout = "1m"
}

# Configure ACME domain and order certificates
resource "ssh_resource" "configure_host" {
  # when = "create"
  count = var.skip_host_configuration == true ? 0 : 1

  depends_on = [ssh_resource.configure_container]

  # Note: connecting to Proxmox host here
  host        = var.proxmox.host
  user        = var.proxmox.ssh_user
  private_key = file(var.proxmox.ssh_key)

  file {
    source      = "${path.module}/files/${local.setup_host_script}"
    destination = "/tmp/${local.setup_host_script}"
    permissions = "0755"
  }

  file {
    source      = "${path.module}/files/${local.teardown_host_script}"
    destination = "/tmp/${local.teardown_host_script}"
    permissions = "0755"
  }

  commands = [
    <<-EOT
      /tmp/${local.setup_host_script} \
        --step-server ${var.ni_ip} \
        --proxmox-node-name ${var.proxmox.name} \
        --fingerprint ${file(var.fingerprint_file)} \
        --acme-name ${var.acme_name} \
        --acme-contact ${var.acme_contact} \
        --acme-domains "${join(";", var.acme_proxmox_domains)}" \
        --log-file /tmp/${local.setup_host_script}.$(date ${local.timestamp}).log
    EOT
  ]

  timeout = "1m"
}

# ACME Cleanup on destroy
resource "ssh_resource" "revert_host" {
  when = "destroy"
  count = var.skip_host_configuration == true ? 0 : 1

  depends_on = [
    ssh_resource.configure_host,
    ssh_resource.configure_container
  ]

  # Note: connecting to Proxmox host here
  host        = var.proxmox.host
  user        = var.proxmox.ssh_user
  private_key = file(var.proxmox.ssh_key)

  commands = [
    <<-EOT
      /tmp/${local.teardown_host_script} \
        --proxmox-node-name ${var.proxmox.name} \
        --acme-name ${var.acme_name} \
        --log-file /tmp/${local.teardown_host_script}.$(date ${local.timestamp}).log
      
      # Remove the setup and teardown host scripts as they're not automatically deleted
      rm /tmp/${local.setup_host_script} /tmp/${local.teardown_host_script}
    EOT
  ]
}