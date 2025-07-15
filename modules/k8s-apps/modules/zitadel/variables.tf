variable "versions_yaml" {
  description = "Absolute path and filename to the `versions.yaml` file, that contains all relevant Helm Chart descriptions and versions"
  type        = string
  default     = "../../../../versions.yaml"
  nullable    = false
}

variable "cluster" {
  description = "Cluster configuration"
  type = object({
    name   = string
    domain = string
  })
}

# PostgreSQL Connection configuration
variable "postgres_service_name" {
  description = "PostgreSQL service name (FQDN or service.namespace format)"
  type        = string
  default     = "postgres-release-postgresql.postgres.svc.cluster.local"
}

variable "postgres_port" {
  description = "PostgreSQL port"
  type        = number
  default     = 5432
}

variable "postgres_database" {
  description = "PostgreSQL database name for Zitadel"
  type        = string
  default     = "zitadel"
}

variable "postgres_user" {
  description = "PostgreSQL username for Zitadel"
  type        = string
  default     = "zitadel"
}

variable "postgres_password" {
  description = "PostgreSQL password for Zitadel user"
  type        = string
  sensitive   = true
}

variable "postgres_admin_user" {
  description = "PostgreSQL admin username"
  type        = string
  default     = "postgres"
}

variable "postgres_admin_password" {
  description = "PostgreSQL admin password"
  type        = string
  sensitive   = true
}