output "zitadel_pat" {
  description = "Personal Access Token of the Zitadel Admin"
  value       = module.zitadel.machine_user_pat
  sensitive   = true
}