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
 *   ssh = {
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

module "terraform_user" {
  source = "./terraform_user"

  ssh            = local.ssh
  terraform_user = local.terraform_user
}

module "copy_configs" {
  source = "./copy_configs"

  ssh                 = local.ssh
  configuration_files = local.configuration_files
}

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

module "storage" {
  source = "./storage"

  depends_on = [module.scripts, module.terraform_user]

  providers = {
    restapi = restapi
  }

  ssh     = local.ssh
  proxmox = local.proxmox
  storage = local.storage
  token   = local.token
}

module "gitops_user" {
  source = "./gitops_user"

  # this module depends on module.storage in order for the gitops repository to be present beforehand
  depends_on = [module.storage]

  # this is the SSH user, that is used to create the gitops git+ssh user
  ssh = local.ssh

  gitops_user           = local.gitops_user
  org_source_repo_owner = local.org_source_repo_owner

  # Note: in order to make use of the gitops git repository and user,
  # public SSH keys of users/applications, who want to access it,
  # have to be introduced into the /home/<user, e.g. gitops>/.ssh/authorized_keys file.
  # You can use the `authorized_keys_appender` script for it.
}