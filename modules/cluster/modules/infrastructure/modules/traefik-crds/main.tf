/**
 * # Traefik CRDs setup
 *
 * This module installs the Traefik CRDs Helm Chart, ultimately allowing each application to bring its own `IngressRoute`
 * even before the [Traefik module](../traefik/README.md) is installed.
 */

locals {
  versions    = yamldecode(file("${var.homelab_root}/versions.yaml"))
  traefikCrds = local.versions.traefikCrds

  helm_terraform_installer_path = pathexpand("${var.homelab_root}/modules/common/modules/helm-terraform-installer")
}

# Installs [`Traefik v3`](https://github.com/traefik/traefik) *CRDs*
# in order to allow the deployment of `IngressRoute` resources before Traefik is deployed.
module "traefik_crds" {
  source = "../../../../../common/modules/helm-terraform-installer" # needed for terraform-docs compatibility
  #source = local.helm_terraform_installer_path

  chart_name    = local.traefikCrds.chartName
  chart_repo    = local.traefikCrds.chartRepo
  chart_version = local.traefikCrds.chartVersion
  namespace     = local.traefikCrds.namespace
  release_name  = local.traefikCrds.releaseName

  chart_values = file("${path.module}/files/traefik-crds.values.yaml")

  chart_timeout = 120 # 2 minutes
}