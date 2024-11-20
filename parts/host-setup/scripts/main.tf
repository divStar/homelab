/**
 * ## Script Management
 * 
 * Handles the download, execution and cleanup of (shell-)scripts on the host
 */
resource "ssh_resource" "script_download" {
  # when = "create"
  
  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

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
  # when = "create"
  depends_on = [ssh_resource.script_download]

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  for_each = { for script in var.scripts.items : script.name => script }

  commands = ["'${local.script_paths[each.key]}' ${each.value.apply_params}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "ssh_resource" "script_cleanup" {
  when = "destroy"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  for_each = { for script in var.scripts.items : script.name => script }

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