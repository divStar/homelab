/**
 * # Host Setup
 *
 * This module and its sub-modules setup the Proxmox host.
 */
locals {
  ssh                   = var.ssh
  configuration_files   = var.configuration_files
  packages              = var.packages
  scripts               = var.scripts
  no_subscription       = var.no_subscription
  terraform_user        = var.terraform_user
  gitops_user           = var.gitops_user
  org_source_repo_owner = var.org_source_repo_owner
  storage               = var.storage_pools
  token                 = module.terraform_user.token
}

# Handles the creation of a Terraform user and API token.
# This user can be used for various Proxmox interactions.
module "terraform_user" {
  source = "./modules/terraform-user"

  ssh            = var.ssh
  terraform_user = var.terraform_user
}

# Handles creating a share user.
module "share_user" {
  source = "./modules/share-user"

  ssh        = var.ssh
  share_user = var.share_user
}

# Handles copying configuration files.
module "copy_configs" {
  source = "./modules/copy-configs"

  ssh                 = var.ssh
  configuration_files = var.configuration_files
}

# Handles the deactivation of the enterprise `apt` repository and the activation of the `pve-no-subscription` `apt` repository.
module "repositories" {
  source = "./modules/repositories"

  ssh             = var.ssh
  no_subscription = var.no_subscription
}

# Handles the execution of various *non-interactive* scripts.
module "scripts" {
  source = "./modules/scripts"

  ssh     = var.ssh
  scripts = var.scripts
}

# Handles the import of ZFS pools.
module "zfs_storage" {
  source = "./modules/zfs-storage"

  ssh           = var.ssh
  storage_pools = var.storage_pools
}

# Handles letting Proxmox trust its own CA certificate.
module "trust_proxmox_ca" {
  source = "./modules/trust-proxmox-ca"

  ssh = var.ssh
}

# Handles the installation of additional `apt` packages.
module "packages" {
  source = "./modules/packages"

  depends_on = [module.repositories]

  ssh      = var.ssh
  packages = var.packages
}

# Handles mapping directories for future use (e.g. file sharing via `virtiofs` into VMs).
module "directory_mappings" {
  source = "./modules/directory-mappings"

  depends_on = [module.zfs_storage]

  ssh                = var.ssh
  proxmox_node_name  = var.proxmox_node_name
  directory_mappings = var.directory_mappings
}

# Handles creating a gitops user, providing it with access to the gitops git repository
# and exposing it for git+ssh access (gitops).
# > [!NOTE]
# > In order to make use of the gitops git repository and user, public SSH keys of users/applications,
# > who need access, have to be introduced into the `/home/<user, e.g. gitops>/.ssh/authorized_keys` file.<br>
# > You can use the [`authorized-keys-appender`](./modules/authorized-keys-appender/README.md) module for this.
module "gitops_user" {
  source     = "./modules/gitops-user"
  depends_on = [module.zfs_storage]

  ssh = var.ssh
}

# Handles adding the SSH key of the machine running this script to the gitops user and git+ssh repository.
module "authorized_keys_appender" {
  source     = "./modules/authorized-keys-appender"
  depends_on = [module.gitops_user]

  ssh = var.ssh

  ssh_key_file = "~/.ssh/id_rsa.pub"
  target_user  = module.gitops_user.user
  repo_name    = module.gitops_user.repo_name
}