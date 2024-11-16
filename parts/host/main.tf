/**
 * # Host setup module
 * 
 * This module manages remote script execution and package installation via SSH.
 * 
 * ## Usage
 * 
 * ```hcl
 * module "remote_setup" {
 *   source = "github.com/username/repo"
 *   
 *   ssh_configuration = {
 *     host = "example.com"
 *     user = "admin"
 *   }
 *
 *   packages = [
 *     "vim",
 *     "git"
 *   ]
 *
 *   scripts = {
 *     items = [
 *         {
 *             name = "pve-mod-nag-screen.sh"
 *             url = "https://raw.githubusercontent.com/Meliox/PVE-mods/refs/heads/main/pve-mod-nag-screen.sh"
 *             apply_params = "install"
 *             destroy_params = "uninstall"
 *             # run_on_destroy defaults to true if not specified
 *         }
 *     ]
 *   }
 * }
 * ```
 */

locals {
  # SSH connection settings for reuse
  ssh_config = {
    host        = var.ssh_configuration.host
    user        = var.ssh_configuration.user
    private_key = file(var.ssh_configuration.id)
  }
}