variable "sealed_k8s_ca_tls" {
  description = "YAML containing the sealed-secret resource of the intermediate Kubernetes CA certificate"
  type        = string
  nullable    = false
}