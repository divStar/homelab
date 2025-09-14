/**
 * # Platform Setup
 *
 * This module sets up k8s applications, that are used as part of the platform.
 */

locals {
  versions      = yamldecode(file("${var.homelab_root}/versions.yaml"))
  cnpg_operator = local.versions.cnpgOperator
  pg_admin      = local.versions.pgAdmin
  zitadel       = local.versions.zitadel

  helm_terraform_installer_path = pathexpand("${var.homelab_root}/modules/common/modules/helm-terraform-installer")
}

# Installs [`CNPG operator`](https://github.com/cloudnative-pg/charts/tree/main/charts/cloudnative-pg)
# for PostgreSQL/PostGIS databases. **NOTE:** This does **not** set up a database as each service is
# responsible for managing its own PostgreSQL/PostGIS database.
module "cnpg_operator" {
  source = "./modules/cnpg-operator"

  cluster                        = var.cluster
  relative_path_to_versions_yaml = var.relative_path_to_versions_yaml
}

# Installs [`Zitadel`](https://github.com/zitadel/zitadel) for managing authentication.
module "zitadel" {
  source     = "./modules/zitadel"
  depends_on = [module.cnpg_operator]

  cluster                        = var.cluster
  relative_path_to_versions_yaml = var.relative_path_to_versions_yaml
  zitadel_admin_password         = var.zitadel_admin_password
}