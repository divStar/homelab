variable "acme_server_directory_url" {
  description = "ACME server directory URL"
  type        = string
  nullable    = false
}

variable "acme_contact" {
  description = "E-Mail address of the ACME account"
  type        = string
  nullable    = false
}

variable "secret_namespace" {
  description = "Namespace to deploy the secret and - by extension - the sealed secret to"
  type        = string
  nullable    = false
}

variable "secret_name" {
  description = "Name of the secret and - by extension - the sealed secret"
  type        = string
  default     = "k8s-acme-secret"
  nullable    = false
}