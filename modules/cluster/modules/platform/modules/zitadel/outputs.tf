output "zitadel_master_key" {
  description = "Generated master key for Zitadel"
  value       = random_password.zitadel_master_key.result
  sensitive   = true
}

output "machine_user_pat" {
  description = "PAT of the machine user of the FirstInstance"
  value       = base64decode(data.kubernetes_resource.login_client_pat.object.data.pat)
  sensitive   = true
}