output "user" {
  description = "The user and role created on the Proxmox host"
  value = {
    name    = var.terraform_user.name
    comment = var.terraform_user.comment
    role    = var.terraform_user.role
  }
  sensitive = true
}

output "token" {
  description = "The API token created on the Proxmox host"
  value       = local.token
  sensitive   = true
}