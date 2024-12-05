/**
 * # Host setup module
 */

module "terraform_user" {
  source = "./modules/terraform_user"

  ssh            = local.ssh
  terraform_user = local.terraform_user
}

module "copy_configs" {
  source = "./modules/copy_configs"

  ssh                 = local.ssh
  configuration_files = local.configuration_files
}

module "repositories" {
  source = "./modules/repositories"

  ssh             = local.ssh
  no_subscription = local.no_subscription
}

module "packages" {
  source = "./modules/packages"

  depends_on = [module.repositories]

  ssh      = local.ssh
  packages = local.packages
}

module "scripts" {
  source = "./modules/scripts"

  depends_on = [module.terraform_user]

  ssh     = local.ssh
  scripts = local.scripts
}

module "storage" {
  source = "./modules/storage"

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
  source = "./modules/gitops_user"

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