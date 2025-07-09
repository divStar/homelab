/**
 * # PostgreSQL
 *
 * This module installs PostgreSQL (postgres) onto a given cluster.
 *
 * > [!NOTE]
 * > The cluster is required to be configured in a way, that allows all resources to deploy correctly.
 */

locals {
  versions = yamldecode(file("${path.module}/${var.versions_yaml}"))
}

# Installs [PostgreSQL (`postgres`)](https://github.com/bitnami/charts/tree/main/bitnami/postgresql),
# a database for other services to use.
module "postgres" {
  source = "../../../common/modules/helm-terraform-installer"

  chart_name    = "postgresql"
  chart_repo    = "oci://registry-1.docker.io/bitnamicharts"
  chart_version = local.versions.postgres_version
  namespace     = var.postgres_namespace
  release_name  = "postgres-release"

  chart_values = templatefile("${path.module}/files/postgres.values.yaml.tftpl", {
    postgres_secret_name = var.postgres_secret_name
    user_name            = var.user_name
  })

  pre_install_resources = [
    templatefile("${path.module}/files/postgres.secret.pre-install.yaml.tftpl", {
      postgres_secret_name = var.postgres_secret_name
      postgres_namespace   = var.postgres_namespace
      admin_password       = base64encode(var.admin_password)
      user_password        = base64encode(var.user_password)
    })
  ]
}