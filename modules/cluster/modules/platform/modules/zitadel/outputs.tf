output "zitadel_master_key" {
  description = "Generated master key for Zitadel"
  value       = random_password.zitadel_master_key.result
  sensitive   = true
}

output "machine_user_key" {
  description = "Key of the Zitadel Admin Service Account (FirstInstance)"
  value       = data.kubernetes_resource.zitadel_admin_sa_key.object.data["zitadel-admin-sa.json"]
  sensitive   = true
}