variable "secret_name" {
  description = "Name of the secret and - by extension - the sealed secret"
  type        = string
  default     = "k8s-ca-secret"
  nullable    = false
}

variable "secret_namespace" {
  description = "Namespace to deploy the secret and - by extension - the sealed secret to"
  type        = string
  nullable    = false
}

variable "k8s_ca_tls_crt" {
  description = "Contains the public intermediate Kubernetes CA certificate"
  type        = string
  nullable    = false
}

variable "k8s_ca_tls_key" {
  description = "Contains the private key for the public certificate"
  type        = string
  nullable    = false
}