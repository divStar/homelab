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

module "repositories" {
  source = "./repositories"

  ssh             = local.ssh
  no_subscription = local.no_subscription
}

module "packages" {
  source = "./packages"

  depends_on = [module.repositories]

  ssh      = local.ssh
  packages = local.packages
}

module "scripts" {
  source = "./scripts"

  ssh     = local.ssh
  scripts = local.scripts
}

module "users" {
  source = "./users"

  ssh            = local.ssh
  terraform_user = local.terraform_user
}

module "storage" {
  source = "./storage"

  depends_on = [module.scripts, module.users]

  providers = {
    restapi = restapi
  }

  ssh     = local.ssh
  proxmox = local.proxmox
  storage = local.storage
  token   = local.token
}