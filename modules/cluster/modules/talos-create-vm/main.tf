/**
 * # Talos create VM
 *
 * Creates a Talos VM with a given ISO, type and other settings.
 */

locals {
  control_plane_patches_dir = "control_plane_patches"
  worker_patches_dir        = "worker_patches"
  patches_dir               = var.node_machine_type == "controlplane" ? local.control_plane_patches_dir : local.worker_patches_dir

  virtiofs_patch_filename          = "04-mount-virtiofs.yaml"
  virtiofs_patch_full_filename     = "${path.module}/${local.control_plane_patches_dir}/${local.virtiofs_patch_filename}"
  virtiofs_patch_full_filename_tpl = "${local.virtiofs_patch_full_filename}.tftpl"

  stepca_patch_filename          = "05-insert-step-ca-root.yaml"
  stepca_patch_full_filename     = "${path.module}/${local.control_plane_patches_dir}/${local.stepca_patch_filename}"
  stepca_patch_full_filename_tpl = "${local.stepca_patch_full_filename}.tftpl"
}

# Defines the Talos machine configuration
data "talos_machine_configuration" "this" {
  depends_on = [local_file.virtiofs_patch, local_file.step_ca_root_pem_patch]

  cluster_name     = var.cluster.name
  cluster_endpoint = "https://${var.cluster.endpoint}:6443"
  talos_version    = var.talos_linux_version
  machine_type     = var.node_machine_type
  machine_secrets  = var.talos_machine_secrets
  config_patches = [
    for patch in fileset("${path.module}/${local.patches_dir}", "*.yaml") :
    file("${path.module}/${local.patches_dir}/${patch}")
  ]
}

# Renders the virtiofs patch template
resource "local_file" "virtiofs_patch" {
  count = var.node_machine_type == "controlplane" ? 1 : 0

  filename = local.virtiofs_patch_full_filename
  content = templatefile(local.virtiofs_patch_full_filename_tpl, {
    vfs_mappings = var.node_vfs_mappings
  })
  file_permission = "0600"
}

# Renders the Step CA root certificate patch template
resource "local_file" "step_ca_root_pem_patch" {
  count = var.node_machine_type == "controlplane" ? 1 : 0

  filename = local.stepca_patch_full_filename
  content = templatefile(local.stepca_patch_full_filename_tpl, {
    step_ca_root_pem = var.root_ca_certificate
  })
  file_permission = "0600"
}

# Applies the Talos machine configuration
resource "talos_machine_configuration_apply" "this" {
  depends_on = [proxmox_virtual_environment_vm.this, local_file.virtiofs_patch, local_file.step_ca_root_pem_patch]

  node                        = var.node_ip
  client_configuration        = var.talos_client_configuration
  machine_configuration_input = data.talos_machine_configuration.this.machine_configuration

  lifecycle {
    # re-run config apply if vm changes
    replace_triggered_by = [proxmox_virtual_environment_vm.this]
  }
}

# Handles the creation of the VM
resource "proxmox_virtual_environment_vm" "this" {
  node_name = var.node_host

  on_boot     = true
  boot_order  = ["scsi0"]
  name        = var.node_name
  description = var.node_description
  tags        = var.node_tags
  vm_id       = var.node_vm_id

  machine       = "q35"
  scsi_hardware = "virtio-scsi-single"
  bios          = "seabios"

  operating_system {
    type = "l26" # Linux Kernel 2.6 - 6.X.
  }

  agent {
    enabled = true
  }

  cpu {
    cores = var.node_cpu
    type  = "host"
  }

  memory {
    dedicated = var.node_ram
  }

  disk {
    datastore_id = var.node_datastore_id
    file_id      = var.node_iso
    interface    = "scsi0"
    iothread     = true
    cache        = "writethrough"
    discard      = "on"
    ssd          = true
    file_format  = "raw"
    size         = 16
    serial       = "boot"
  }

  disk {
    datastore_id = var.node_datastore_id
    interface    = "scsi1"
    iothread     = true
    cache        = "writethrough"
    discard      = "on"
    ssd          = true
    file_format  = "raw"
    size         = 256
    serial       = "kube-state-storage"
  }

  disk {
    datastore_id = var.node_datastore_id
    interface    = "scsi2"
    iothread     = true
    cache        = "writethrough"
    discard      = "on"
    ssd          = true
    file_format  = "raw"
    size         = 256
    serial       = "pv-storage"
  }

  dynamic "virtiofs" {
    for_each = var.node_vfs_mappings
    content {
      mapping   = virtiofs.value
      cache     = "never"
      direct_io = true
    }
  }

  network_device {
    bridge      = var.node_bridge
    mac_address = var.node_mac_address
  }

  initialization {
    datastore_id = var.node_datastore_id
    ip_config {
      ipv4 {
        address = "${var.node_ip}/24"
        gateway = var.cluster.gateway
      }
    }
  }
}
