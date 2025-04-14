/**
 * # Host Setup
 *
 * This module and its sub-modules setup the Proxmox host.
 */

# Handles the creation and deletion of a dedicated user with a custom role
# and API token for the Terraform provisioner on the host.
module "terraform_user" {
  source = "./modules/terraform-user"

  ssh            = var.ssh
  terraform_user = var.terraform_user
}

# Handles the copying of configuration files to the host.
module "copy_configs" {
  source = "./modules/copy-configs"

  ssh                 = var.ssh
  configuration_files = var.configuration_files
}

# Handles the deactivation of the enterprise repositories and
# the creation and activation of the no-subscription repositories.
module "repositories" {
  source = "./modules/repositories"

  ssh             = var.ssh
  no_subscription = var.no_subscription
}

# Handles the installation and removal of packages on the host
# <blockquote>
# **Note:** `ssh_resource` and CLI is used, because `apt-get install`
# and `apt-get remove` are not yet supported by Proxmox API.
# </blockquote>
module "packages" {
  source = "./modules/packages"

  depends_on = [module.repositories]

  ssh      = var.ssh
  packages = var.packages
}

# Handles the download, execution and cleanup of (shell-)scripts on the host
module "scripts" {
  source = "./modules/scripts"

  depends_on = [module.terraform_user]

  ssh     = var.ssh
  scripts = var.scripts
}

# Handles the import and export of ZFS pools as well as directories.
module "storage" {
  source = "./modules/storage"

  depends_on = [module.scripts, module.terraform_user]

  providers = {
    restapi = restapi
  }

  ssh     = var.ssh
  proxmox = var.proxmox
  storage = var.storage
  token   = module.terraform_user.token
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

  ssh                   = var.ssh
  gitops_user           = var.gitops_user
  org_source_repo_owner = var.org_source_repo_owner
}

module "trust_proxmox_ca" {
  source = "./modules/trust-proxmox-ca"

  ssh          = var.ssh
  proxmox_host = var.proxmox.name
}

module "update_ssl" {
  source = "./modules/update-ssl"

  ssh          = var.ssh
  proxmox_host = var.proxmox.name
}

module "share_user" {
  source = "./modules/share-user"

  ssh        = var.ssh
  share_user = var.share_user
}