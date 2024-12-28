output "schematic_id" {
  description = "The calculated ID of the schematic, that's being used"
  value       = talos_image_factory_schematic.this.id
}

output "installer" {
  description = "The installer URL without http/https"
  value       = data.talos_image_factory_urls.this.urls.installer
}

output "downloaded_iso_file_name" {
  description = "The filename on the local node"
  value       = resource.proxmox_virtual_environment_download_file.this.file_name
}

output "downloaded_iso_id" {
  description = "The full ID on the local node"
  value       = resource.proxmox_virtual_environment_download_file.this.id
}