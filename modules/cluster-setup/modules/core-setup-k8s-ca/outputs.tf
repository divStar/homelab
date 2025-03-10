output "k8s_ca_issuer" {
  description = "Name of the ClusterIssuer resource"
  value       = local.cluster_issuer_yaml_decoded.metadata.name
}

output "k8s_ca_secret_name" {
  description = "Name of the secret ClusterIssuer resource is referring to"
  value       = local.secret_name
}

output "k8s_sealed_secret_yaml" {
  description = "YAML string (not file) containing the /sealed/ secret of the intermediate Kubernetes CA certificate"
  value       = sealedsecret.k8s_ca.yaml_content
  sensitive   = true
}