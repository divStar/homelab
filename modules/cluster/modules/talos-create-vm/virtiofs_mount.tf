locals {
  virtiofs_patch_filename          = "04-mount-virtiofs.yaml"
  virtiofs_patch_full_filename     = "${path.module}/${local.control_plane_patches_dir}/${local.virtiofs_patch_filename}"
  virtiofs_patch_full_filename_tpl = "${local.virtiofs_patch_full_filename}.tftpl"
}

resource "local_file" "virtiofs_patch" {
  count = var.node_machine_type == "controlplane" ? 1 : 0

  filename = local.virtiofs_patch_full_filename
  content = templatefile(local.virtiofs_patch_full_filename_tpl, {
    vfs_mappings = var.node_vfs_mappings
  })
  file_permission = "0600"
}