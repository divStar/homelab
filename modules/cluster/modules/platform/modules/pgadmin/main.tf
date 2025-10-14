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
  versions = yamldecode(file("${var.relative_path_to_versions_yaml}/versions.yaml"))

  pgAdmin = local.versions.pgAdmin
  # We expect there to only be one company; this *should* always be the case!
  sanctum_orga_id = data.zitactl_orgs.this.ids[0]
}

# This data source retrieves the organization ID of `zitadel_orga_name`.
data "zitactl_orgs" "this" {
  name = var.zitadel_orga_name
}

# Creates the `pgadmin` project within the given `var.zitadel_orga_name` organization.
resource "zitactl_project" "this" {
  name                   = "pgadmin"
  org_id                 = local.sanctum_orga_id
  project_role_assertion = true
  project_role_check     = true
}

resource "zitactl_application_oidc" "this" {
  project_id = zitactl_project.this.id

  name                      = "pgadmin"
  redirect_uris             = ["https://pgadmin.${var.cluster.domain}/oauth2/authorize"]
  response_types            = ["OIDC_RESPONSE_TYPE_CODE"]
  grant_types               = ["OIDC_GRANT_TYPE_AUTHORIZATION_CODE"]
  app_type                  = "OIDC_APP_TYPE_WEB"
  auth_method_type          = "OIDC_AUTH_METHOD_TYPE_BASIC"
  post_logout_redirect_uris = ["https://pgadmin.${var.cluster.domain}/"]
}

# Installs [pgAdmin 4](https://github.com/rowanruseler/helm-charts/tree/main/charts/pgadmin4),
# a web-based administration tool for PostgreSQL.
module "pgadmin" {
  source = "../../../../../common/modules/helm-terraform-installer"

  chart_name    = local.pgAdmin.chartName
  chart_repo    = local.pgAdmin.chartRepo
  chart_version = local.pgAdmin.chartVersion
  namespace     = local.pgAdmin.namespace
  release_name  = local.pgAdmin.releaseName
  chart_timeout = 300 // 5 minutes

  chart_values = templatefile("${path.module}/files/pgadmin.values.yaml.tftpl", {
    pgadmin_email          = var.pgadmin_email
    pgadmin_secret_name    = var.pgadmin_secret_name
    pgadmin_configmap_name = var.pgadmin_configmap_name
    cluster_lbcidr         = var.cluster.lb_cidr
  })

  pre_install_resources = [
    {
      yaml = templatefile("${path.module}/files/pgadmin.secret.env.pre-install.yaml.tftpl", {
        pgadmin_namespace    = local.pgAdmin.namespace
        pgadmin_secret_name  = var.pgadmin_secret_name
        oauth2_client_id     = zitactl_application_oidc.this.client_id
        oauth2_client_secret = zitactl_application_oidc.this.client_secret
      })
    },
    {
      yaml = templatefile("${path.module}/files/pgadmin.secret.admin-password.pre-install.yaml.tftpl", {
        pgadmin_namespace   = local.pgAdmin.namespace
        pgadmin_secret_name = var.pgadmin_secret_name
      })
    },
    {
      yaml = templatefile("${path.module}/files/pgadmin.configmap.pre-install.yaml.tftpl", {
        pgadmin_namespace      = local.pgAdmin.namespace
        pgadmin_configmap_name = var.pgadmin_configmap_name
        cluster_domain         = var.cluster.domain
      })
    }
  ]

  post_install_resources = [{
    yaml = templatefile("${path.module}/files/pgadmin.ingress-route.post-install.yaml.tftpl", {
      pgadmin_namespace   = local.pgAdmin.namespace
      cluster_domain      = var.cluster.domain
      external_dns_target = "${var.cluster.name}.${var.cluster.domain}" # adding a CNAME record
    })
  }]
}