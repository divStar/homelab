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
  versions      = yamldecode(file("${var.relative_path_to_versions_yaml}/versions.yaml"))
  zitadel       = local.versions.zitadel
  postgres_host = "${var.postgres_database}-rw.${local.zitadel.namespace}.svc.cluster.local"
}

# Generate a secure master key for Zitadel symmetrical encryption
resource "random_password" "zitadel_master_key" {
  length  = 32
  special = false
}

# Install [Zitadel](https://github.com/zitadel/zitadel-charts) - an identity and access management solution.
module "zitadel" {
  source = "../../../../../common/modules/helm-terraform-installer"

  chart_name    = local.zitadel.chartName
  chart_repo    = local.zitadel.chartRepo
  chart_version = local.zitadel.chartVersion
  namespace     = local.zitadel.namespace
  release_name  = local.zitadel.releaseName
  chart_timeout = 300 // give it 5 minutes to install - should be enough

  chart_values = templatefile("${path.module}/files/zitadel.values.yaml.tftpl", {
    postgres_host          = local.postgres_host
    cluster_domain         = var.cluster.domain
    master_key             = random_password.zitadel_master_key.result
    zitadel_admin_password = var.zitadel_admin_password
    zitadel_orga_name      = var.zitadel_orga_name
    postgres_database      = var.postgres_database
    postgres_user          = var.postgres_user
  })

  pre_install_resources = [{
    yaml = templatefile("${path.module}/files/zitadel.cluster.pre-install.yaml.tftpl", {
      zitadel_namespace = local.zitadel.namespace
      postgres_database = var.postgres_database
      postgres_user     = var.postgres_user
    })
    wait_for = {
      conditions = [{
        type   = "Ready"
        status = "True"
      }]
    }
  }]

  post_install_resources = [{
    yaml = templatefile("${path.module}/files/zitadel.ingress-route.post-install.yaml.tftpl", {
      zitadel_namespace   = local.zitadel.namespace
      cluster_domain      = var.cluster.domain
      external_dns_target = "${var.cluster.name}.${var.cluster.domain}" # adding a CNAME record
    })
  }]
}

data "kubernetes_resource" "zitadel_admin_sa_key" {
  depends_on = [module.zitadel]

  api_version = "v1"
  kind        = "Secret"

  metadata {
    name      = "zitadel-admin-sa"
    namespace = local.zitadel.namespace
  }
}
