resource "proxmox_virtual_environment_vm" "this" {
  node_name = var.node_host

  on_boot     = true
  name        = var.node_name
  description = var.node_description
  tags        = var.node_tags
  vm_id       = var.node_vm_id

  machine       = "q35"
  scsi_hardware = "virtio-scsi-single"
  bios          = "seabios"

  agent {
    enabled = true
  }

  cpu {
    cores = var.node_cpu
    type  = "host"
  }

  memory {
    dedicated = var.node_ram_dedicated
  }

  network_device {
    bridge      = "vmbr0"
    mac_address = var.node_mac_address
  }

  disk {
    datastore_id = var.node_datastore_id
    file_id      = var.node_update == false ? var.node_iso : var.node_update_iso
    interface    = "scsi0"
    iothread     = true
    cache        = "writethrough"
    discard      = "on"
    ssd          = true
    file_format  = "raw"
    size         = 20
  }

  boot_order = ["scsi0"]

  operating_system {
    type = "l26" # Linux Kernel 2.6 - 6.X.
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