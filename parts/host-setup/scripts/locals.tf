locals {
  # SSH connection settings for reuse
  ssh = {
    host        = var.ssh.host
    user        = var.ssh.user
    private_key = file(var.ssh.id_file)
  }

  # Script paths and commands
  script_paths    = { for script in var.scripts.items : script.name => "${var.scripts.directory}/${script.name}" }
  cleanup_dir_cmd = "if [ -d '${var.scripts.directory}' ] && [ -z \"$(ls -A '${var.scripts.directory}')\" ]; then rmdir '${var.scripts.directory}'; fi"
}