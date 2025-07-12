/**
 * # pgAdmin
 *
 * This module installs pgAdmin onto a given cluster for PostgreSQL database administration.
 *
 * > [!NOTE]
 * > In order to install this application successfully, the cluster is *required* to be configured properly.
 * > This module assumes you have a PostgreSQL instance running that pgAdmin can connect to.
 */

locals {
  pgAdmin = yamldecode(file("${path.module}/${var.versions_yaml}")).pgAdmin
}

# Installs [pgAdmin 4](https://github.com/rowanruseler/helm-charts/tree/main/charts/pgadmin4),
# a web-based administration tool for PostgreSQL.
module "pgadmin" {
  source = "../../../common/modules/helm-terraform-installer"

  chart_name    = local.pgAdmin.chartName
  chart_repo    = local.pgAdmin.chartRepo
  chart_version = local.pgAdmin.chartVersion
  namespace     = local.pgAdmin.namespace
  release_name  = local.pgAdmin.releaseName

  chart_values = templatefile("${path.module}/files/pgadmin.values.yaml.tftpl", {
    pgadmin_secret_name = var.pgadmin_secret_name
    pgadmin_email       = var.pgadmin_email
    cluster_lbcidr      = var.cluster.lb_cidr
  })

  pre_install_resources = [
    templatefile("${path.module}/files/pgadmin.secret.pre-install.yaml.tftpl", {
      pgadmin_secret_name = var.pgadmin_secret_name
      pgadmin_namespace   = local.pgAdmin.namespace
      pgadmin_password    = base64encode(var.pgadmin_password)
    }),
    templatefile("${path.module}/files/pgadmin.servers.pre-install.yaml.tftpl", {
      pgadmin_namespace     = local.pgAdmin.namespace
      postgres_service_name = var.postgres_service_name
      postgres_port         = var.postgres_port
      postgres_username     = var.postgres_username
      postgres_database     = var.postgres_database
    })
  ]

  post_install_resources = [
    templatefile("${path.module}/files/pgadmin.ingress-route.post-install.yaml.tftpl", {
      pgadmin_namespace   = local.pgAdmin.namespace
      cluster_domain      = var.cluster.domain
      external_dns_target = "${var.cluster.name}.${var.cluster.domain}" # adding a CNAME record
    })
  ]
}