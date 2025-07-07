/**
 * # Zitadel
 *
 * This module installs Zitadel onto a given cluster.
 *
 * > [!NOTE]
 * > The cluster is required to be configured in a way, that allows all resources to deploy correctly.
 */

locals {
  versions = yamldecode(file("${path.module}/${var.versions_yaml}"))
}

# Installs [`zitadel`](https://zitadel.com/), which is used for Authentication and Authorization of users and services.
module "zitadel" {
  source     = "../common/modules/helm-terraform-installer"

  chart_name    = "zitadel"
  chart_repo    = "https://charts.zitadel.com"
  chart_version = local.versions.zitadel_version
  namespace     = "zitadel"
  release_name  = "zitadel-release"

  chart_values            = file("${path.module}/files/local-path-provisioner.values.yaml")
  is_privileged_namespace = true
}