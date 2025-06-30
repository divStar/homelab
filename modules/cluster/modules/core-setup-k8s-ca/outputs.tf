output "k8s_ca_issuer_name" {
  description = "Name of the secret ClusterIssuer resource is referring to"
  value       = local.cluster_issuer_name
}