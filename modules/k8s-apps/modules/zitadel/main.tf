/**
 * # Zitadel v3
 *
 * This module installs Zitadel v3+ onto a given cluster with PostgreSQL backend.
 *
 * > [!NOTE]
 * > Traefik handles TLS termination and `IngressRoute` service exposure.
 * > TLS is *not* used internally or between PostgreSQL database and Zitalde.
 */

locals {
  zitadel = yamldecode(file("${path.module}/${var.versions_yaml}")).zitadel
}

# Generate a secure master key for Zitadel symmetrical encryption
resource "random_password" "zitadel_master_key" {
  length  = 32
  special = false
}

# Install [Zitadel](https://github.com/zitadel/zitadel-charts) - an identity and access management solution.
module "zitadel" {
  source = "../../../common/modules/helm-terraform-installer"

  chart_name    = local.zitadel.chartName
  chart_repo    = local.zitadel.chartRepo
  chart_version = local.zitadel.chartVersion
  namespace     = local.zitadel.namespace
  release_name  = local.zitadel.releaseName

  chart_values = templatefile("${path.module}/files/zitadel.values.yaml.tftpl", {
    app_version             = local.zitadel.appVersion
    master_key              = random_password.zitadel_master_key.result
    cluster_domain          = var.cluster.domain
    postgres_service_name   = var.postgres_service_name
    postgres_port           = var.postgres_port
    postgres_database       = var.postgres_database
    postgres_user           = var.postgres_user
    postgres_password       = var.postgres_password
    postgres_admin_user     = var.postgres_admin_user
    postgres_admin_password = var.postgres_admin_password
  })

  post_install_resources = [
    templatefile("${path.module}/files/zitadel.middleware.redirect-to-console.post-install.yaml.tftpl", {
      zitadel_namespace = local.zitadel.namespace
    }),
    templatefile("${path.module}/files/zitadel.ingress-route.post-install.yaml.tftpl", {
      zitadel_namespace   = local.zitadel.namespace
      cluster_domain      = var.cluster.domain
      external_dns_target = "${var.cluster.name}.${var.cluster.domain}" # adding a CNAME record
    })
  ]
}