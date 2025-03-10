/**
 * # Download Talos image
 *
 * Handles the download of Talos images based on the version,
 * architecture, platform and schematics.
 */

data "talos_image_factory_urls" "this" {
  talos_version = var.talos_version
  architecture  = var.arch
  platform      = var.platform
  schematic_id  = talos_image_factory_schematic.this.id
}

resource "talos_image_factory_schematic" "this" {
  schematic = file("${path.module}/${var.schematic}")
}

resource "proxmox_virtual_environment_download_file" "this" {
  content_type            = "iso"
  decompression_algorithm = "gz"
  overwrite               = false
  overwrite_unmanaged     = true
  node_name               = var.proxmox.name
  datastore_id            = var.proxmox.iso_store
  url                     = replace(data.talos_image_factory_urls.this.urls.disk_image, ".xz", ".gz") # Modify URL to get raw.gz

  file_name = format("talos-%s-%s-%s-%s.img",
    var.talos_version,
    var.arch,
    var.platform,
    talos_image_factory_schematic.this.id
  )
}