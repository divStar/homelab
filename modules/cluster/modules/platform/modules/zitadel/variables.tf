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

variable "relative_path_to_versions_yaml" {
  description = "Relative path to the `versions.yaml` file"
  type        = string
  nullable    = false
}

# PostgreSQL Connection configuration
variable "postgres_database" {
  description = "PostgreSQL database name for Zitadel"
  type        = string
  default     = "zitadel"
  nullable    = false
}

variable "postgres_user" {
  description = "PostgreSQL username for Zitadel"
  type        = string
  default     = "zitadel"
  nullable    = false
}

# Zitadel user configuration
variable "zitadel_admin_password" {
  description = "Password of the `zitadel-admin` user"
  type        = string
  nullable    = false
}

variable "zitadel_orga_name" {
  description = "Name of the organization in Zitadel"
  type        = string
  nullable    = false
}
