output "schematic_id" {
  value = talos_image_factory_schematic.this.id
}

output "installer_image" {
  value = data.talos_image_factory_urls.this.urls.iso
}