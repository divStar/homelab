locals {
  ssh                   = var.ssh
  proxmox               = var.proxmox
  configuration_files   = var.configuration_files
  packages              = var.packages
  scripts               = var.scripts
  no_subscription       = var.no_subscription
  terraform_user        = var.terraform_user
  gitops_user           = var.gitops_user
  org_source_repo_owner = var.org_source_repo_owner
  storage               = var.storage
  token                 = module.terraform_user.token
}