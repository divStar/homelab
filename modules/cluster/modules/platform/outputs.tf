output "machine_user_key" {
  description = "Key of the Zitadel Admin Service Account"
  value       = module.zitadel.machine_user_key
  sensitive   = true
}