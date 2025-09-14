variable "versions_yaml" {
  description = "Absolute path and filename to the `versions.yaml` file, that contains all relevant Helm Chart descriptions and versions"
  type        = string
  default     = "../../../../versions.yaml"
  nullable    = false
}

variable "cluster" {
  description = "Cluster configuration"
  type = object({
    name    = string
    domain  = string
    lb_cidr = string
  })
}

variable "pgadmin_secret_name" {
  description = "Name of the secret, that will contain the passwords"
  type        = string
  default     = "pgadmin-passwords"
  nullable    = false
}

variable "pgadmin_email" {
  description = "Email address for the pgAdmin admin user"
  type        = string
  default     = "admin@my.world"
  nullable    = false
}

variable "pgadmin_password" {
  description = "Password for the pgAdmin admin user"
  type        = string
  nullable    = false
  sensitive   = true
}

# PostgreSQL connection variables
variable "postgres_service_name" {
  description = "PostgreSQL service name (FQDN or service.namespace format)"
  type        = string
  default     = "postgres-release-postgresql.postgres.svc.cluster.local"
}

variable "postgres_port" {
  description = "PostgreSQL service port"
  type        = string
  default     = "5432"
}

variable "postgres_database" {
  description = "Default PostgreSQL database name"
  type        = string
  default     = "postgres"
}

variable "postgres_username" {
  description = "PostgreSQL username for pgAdmin to connect with"
  type        = string
}

variable "postgres_password" {
  description = "PostgreSQL password for pgAdmin to connect with"
  type        = string
  sensitive   = true
}