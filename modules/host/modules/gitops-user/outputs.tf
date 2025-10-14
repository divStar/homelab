output "git_ssh_url" {
  description = "The git+ssh address / URL"
  value       = "${var.user}@${local.ssh.host}:${var.repository_symlink}"
}

output "user" {
  description = "Name of the gitops user, that allows access to the gitops git repository via SSH"
  value       = var.user
}

output "user_home" {
  description = "Home directory of the git user"
  value       = local.user_home
}

output "repo_name" {
  description = "Name of the symbolic link inside the home directory, which points to the actual gitops git repository"
  value       = var.repository_symlink
}

output "repo_local_path" {
  description = "Local path to the repository symlink"
  value       = "${local.user_home}/${var.repository}"
}

output "repo_actual_path" {
  description = "Actual path to the git repository"
  value       = var.repository_symlink
}