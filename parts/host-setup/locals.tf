locals {
  ssh             = var.ssh
  proxmox         = var.proxmox
  packages        = var.packages
  scripts         = var.scripts
  no_subscription = var.no_subscription
  terraform_user  = var.terraform_user
  storage         = var.storage
  token           = module.users.token
}