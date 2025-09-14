resource "local_file" "talos_config" {
  content         = module.talos_cluster_prepare.talos_config
  filename        = var.talos_config_file
  file_permission = "0600"
}

resource "local_file" "machine_configs" {
  for_each        = module.talos_cluster_ready.machine_config
  content         = each.value.machine_configuration
  filename        = replace(var.talos_machine_config_file, "<node-name>", each.key)
  file_permission = "0600"
}

resource "local_file" "kube_config" {
  content         = module.talos_cluster_ready.kube_config.kubeconfig_raw
  filename        = var.kube_config_file
  file_permission = "0600"
}

output "talos_config" {
  description = "String containing the `talos-config.yaml`"
  value       = module.talos_cluster_prepare.talos_config
  sensitive   = true
}

output "kube_config" {
  description = "String containing the `kube-config.yaml`"
  value       = module.talos_cluster_ready.kube_config.kubeconfig_raw
  sensitive   = true
}

output "zitadel_pat" {
  description = "Personal Access Token of the Zitadel Admin"
  value       = module.platform.zitadel_pat
  sensitive   = true
}