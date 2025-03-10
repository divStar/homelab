output "authorized_keys_path" {
  value       = "/home/${var.target_user}/.ssh/authorized_keys"
  description = "Path to the authorized_keys file where the key was added"
}

output "access_mode" {
  value       = var.git_access_mode
  description = "Applied access mode (read-only or read-write) for the SSH key"
}

output "ssh_key_file_used" {
  description = "Path to the SSH public key file that was used"
  value       = var.ssh_key_file
}

output "key_with_restrictions" {
  description = "Complete authorized_keys entry including all restrictions"
  value       = local.final_key
  sensitive   = true # Mark as sensitive since it contains key material
}

output "key_permissions" {
  description = "Summary of permissions applied to this key"
  value = {
    user      = var.target_user
    mode      = var.git_access_mode
    can_read  = true # Both modes can read
    can_write = var.git_access_mode == "read-write"
  }
}