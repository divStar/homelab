/**
 * # Host Setup
 *
 * This module and its sub-modules setup the Proxmox host.
 */

# Handles the creation and deletion of a dedicated user with a custom role
# and API token for the Terraform provisioner on the host.
module "terraform_user" {
  source = "./modules/terraform-user"

  ssh            = local.ssh
  terraform_user = local.terraform_user
}

# Handles the copying of configuration files to the host.
module "copy_configs" {
  source = "./modules/copy-configs"

  ssh                 = local.ssh
  configuration_files = local.configuration_files
}

# Handles the deactivation of the enterprise repositories and
# the creation and activation of the no-subscription repositories.
module "repositories" {
  source = "./modules/repositories"

  ssh             = local.ssh
  no_subscription = local.no_subscription
}

# Handles the installation and removal of packages on the host
# <blockquote>
# **Note:** `ssh_resource` and CLI is used, because `apt-get install`
# and `apt-get remove` are not yet supported by Proxmox API.
# </blockquote>
module "packages" {
  source = "./modules/packages"

  depends_on = [module.repositories]

  ssh      = local.ssh
  packages = local.packages
}

# Handles the download, execution and cleanup of (shell-)scripts on the host
module "scripts" {
  source = "./modules/scripts"

  depends_on = [module.terraform_user]

  ssh     = local.ssh
  scripts = local.scripts
}

# Handles the import and export of ZFS pools as well as directories.
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

# Handles the creation and deletion of a dedicated user git+ssh access (gitops)
# as well as setting and restoring owner / group of the original gitops repository.
# <blockquote>
# **Note:** in order to make use of the gitops git repository and user, public SSH keys of users/applications, who need access,
# have to be introduced into the `/home/<user, e.g. gitops>/.ssh/authorized_keys` file.<br>
# You can use the `authorized-keys-appender` script for this.
# </blockquote>
module "gitops_user" {
  source = "./modules/gitops-user"

  depends_on = [module.storage]

  ssh                   = local.ssh
  gitops_user           = local.gitops_user
  org_source_repo_owner = local.org_source_repo_owner
}