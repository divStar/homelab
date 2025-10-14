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

variable "relative_path_to_versions_yaml" {
  description = "Relative path to the `versions.yaml` file"
  type        = string
  nullable    = false
}

variable "pgadmin_secret_name" {
  description = "Name of the Secret resource, that will contain the passwords"
  type        = string
  default     = "pgadmin4-extra-secrets"
  nullable    = false
}

variable "pgadmin_configmap_name" {
  description = "Name of the ConfigMap resource, that will contain the extra configuration"
  type        = string
  default     = "pgadmin4-extra-config"
  nullable    = false
}

variable "pgadmin_email" {
  description = "Email address for the pgAdmin admin user"
  type        = string
  default     = "admin@my.world"
  nullable    = false
}

variable "zitadel_orga_name" {
  description = "Name of the organization in Zitadel"
  type        = string
  nullable    = false
}
