resource "talos_image_factory_schematic" "this" {
  schematic = file(var.schematic)
}

data "talos_image_factory_urls" "this" {
  talos_version = var.talos_version
  schematic_id  = talos_image_factory_schematic.this.id
  platform      = var.platform
}

resource "proxmox_virtual_environment_download_file" "this" {
  node_name    = var.proxmox.name
  content_type = "iso"
  datastore_id = var.proxmox.datastore
  overwrite    = false
  url          = data.talos_image_factory_urls.this.urls.iso

  file_name = format("talos-%s-%s-%s-%s.iso",
    var.talos_version,
    var.arch,
    var.platform,
    talos_image_factory_schematic.this.id
  )
}