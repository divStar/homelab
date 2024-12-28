output "cilium_patch_file" {
  description = "manifests"
  value       = data.helm_template.cilium.manifest
}