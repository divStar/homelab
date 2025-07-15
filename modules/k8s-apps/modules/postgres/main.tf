/**
 * # PostgreSQL
 *
 * This module installs PostgreSQL (postgres) onto a given cluster.
 *
 * > [!NOTE]
 * > In order to install this application successfully, the cluster is *required* to be configured properly.
 */

locals {
  postgres = yamldecode(file("${path.module}/${var.versions_yaml}")).postgres
}

# Installs [PostgreSQL (`postgres`)](https://github.com/bitnami/charts/tree/main/bitnami/postgresql),
# a database for other services to use.
module "postgres" {
  source = "../../../common/modules/helm-terraform-installer"

  chart_name    = local.postgres.chartName
  chart_repo    = local.postgres.chartRepo
  chart_version = local.postgres.chartVersion
  namespace     = local.postgres.namespace
  release_name  = local.postgres.releaseName

  chart_values = templatefile("${path.module}/files/postgres.values.yaml.tftpl", {
    postgres_secret_name = var.postgres_secret_name
  })

  pre_install_resources = [
    templatefile("${path.module}/files/postgres.secret.pre-install.yaml.tftpl", {
      postgres_namespace   = local.postgres.namespace
      postgres_secret_name = var.postgres_secret_name
      admin_password       = base64encode(var.admin_password)
    })
  ]
}