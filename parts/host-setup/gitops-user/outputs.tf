output "git_ssh_url" {
  description = "The git+ssh address / URL"
  value       = "${var.gitops_user.user}@${local.ssh.host}:repo"
}

output "user" {
  description = "Name of the gitops user, that allows access to the gitops git repository via SSH"
  value       = var.gitops_user.user
}

output "user_home" {
  description = "Home directory of the git user"
  value       = local.user_home
}

output "repo_local_path" {
  description = "Local path to the repository symlink"
  value       = "${local.user_home}/${var.gitops_user.repo_name}"
}

output "repo_actual_path" {
  description = "Actual path to the git repository"
  value       = var.gitops_user.source_repo
}