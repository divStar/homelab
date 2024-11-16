/**
 * ## Script Management
 * 
 * Handles the download, execution and cleanup of (shell-)scripts on the host
 */

locals {
  # Script paths and commands
  script_paths    = { for script in var.scripts.items : script.name => "${var.scripts.directory}/${script.name}" }
  cleanup_dir_cmd = "if [ -d '${var.scripts.directory}' ] && [ -z \"$(ls -A '${var.scripts.directory}')\" ]; then rmdir '${var.scripts.directory}'; fi"
}

resource "ssh_resource" "script_download" {
  host        = local.ssh_config.host
  user        = local.ssh_config.user
  private_key = local.ssh_config.private_key

  for_each = { for script in var.scripts.items : script.name => script }

  commands = [
    "mkdir -p '${var.scripts.directory}'",
    "wget -O '${local.script_paths[each.key]}' '${each.value.url}'",
    "chmod +x '${local.script_paths[each.key]}'"
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "ssh_resource" "script_execute" {
  host        = local.ssh_config.host
  user        = local.ssh_config.user
  private_key = local.ssh_config.private_key

  for_each = { for script in var.scripts.items : script.name => script }

  depends_on = [ssh_resource.script_download]

  commands = ["'${local.script_paths[each.key]}' ${each.value.apply_params}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "ssh_resource" "script_cleanup" {
  host        = local.ssh_config.host
  user        = local.ssh_config.user
  private_key = local.ssh_config.private_key

  for_each = { for script in var.scripts.items : script.name => script }

  when = "destroy"

  commands = each.value.run_on_destroy ? [
    "'${local.script_paths[each.key]}' ${each.value.destroy_params}",
    "rm -f '${local.script_paths[each.key]}'",
    local.cleanup_dir_cmd
    ] : [
    "rm -f '${local.script_paths[each.key]}'",
    local.cleanup_dir_cmd
  ]

  lifecycle {
    create_before_destroy = true
  }
}