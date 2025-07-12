variable "versions_yaml" {
  description = "Absolute path and filename to the `versions.yaml` file, that contains all relevant Helm Chart descriptions and versions"
  type        = string
  default     = "../../../../versions.yaml"
  nullable    = false
}

variable "postgres_secret_name" {
  description = "Name of the secret, that will contain the passwords"
  type        = string
  default     = "postgres-passwords"
  nullable    = false
}

variable "admin_password" {
  description = "Password used as POSTGRES_ADMIN_PASSWORD"
  type        = string
  nullable    = false
  sensitive   = true
}

variable "user_name" {
  description = "Custom user, that will be created upon deployment"
  type        = string
  default     = "appuser"
  nullable    = false
}

variable "user_password" {
  description = "Password used as POSTGRES_PASSWORD"
  type        = string
  nullable    = false
  sensitive   = true
}