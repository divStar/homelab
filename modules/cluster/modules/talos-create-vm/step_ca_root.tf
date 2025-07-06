locals {
  stepca_patch_filename          = "05-insert-step-ca-root.yaml"
  stepca_patch_full_filename     = "${path.module}/${local.control_plane_patches_dir}/${local.stepca_patch_filename}"
  stepca_patch_full_filename_tpl = "${local.stepca_patch_full_filename}.tftpl"
}

resource "local_file" "step_ca_root_pem_patch" {
  count = var.node_machine_type == "controlplane" ? 1 : 0

  filename = local.stepca_patch_full_filename
  content = templatefile(local.stepca_patch_full_filename_tpl, {
    step_ca_root_pem = var.root_ca_certificate
  })
  file_permission = "0600"
}