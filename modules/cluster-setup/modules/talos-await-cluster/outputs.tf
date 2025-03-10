output "machine_config" {
  description = "Talos machine configurations"
  value       = data.talos_machine_configuration.this
}

output "kube_config" {
  description = "Talos cluster kubeconfig"
  value       = talos_cluster_kubeconfig.this
  sensitive   = true
}
