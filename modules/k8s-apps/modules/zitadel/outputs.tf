output "zitadel_master_key" {
  description = "Generated master key for Zitadel"
  value       = random_password.zitadel_master_key.result
  sensitive   = true
}