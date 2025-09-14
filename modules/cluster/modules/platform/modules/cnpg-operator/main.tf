/**
 * # CloudNative PostgreSQL
 *
 * This module installs PostgreSQL (postgres) onto a given cluster.
 *
 * > [!NOTE]
 * > In order to install this application successfully, the cluster is *required* to be configured properly.
 */

locals {
  versions      = yamldecode(file("${var.relative_path_to_versions_yaml}/versions.yaml"))
  cnpg_operator = local.versions.cnpgOperator
}

# Installs [PostgreSQL (`postgres`)](https://github.com/bitnami/charts/tree/main/bitnami/postgresql),
# a database for other services to use.
module "cnpg_operator" {
  source = "../../../../../common/modules/helm-terraform-installer"

  chart_name    = local.cnpg_operator.chartName
  chart_repo    = local.cnpg_operator.chartRepo
  chart_version = local.cnpg_operator.chartVersion
  namespace     = local.cnpg_operator.namespace
  release_name  = local.cnpg_operator.releaseName

  chart_values = file("${path.module}/files/cnpg-operator.values.yaml")
}