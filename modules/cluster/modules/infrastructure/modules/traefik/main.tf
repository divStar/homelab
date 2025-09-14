/**
 * # Traefik Setup
 *
 * This module installs and configures Traefik.
 */

locals {
  versions = yamldecode(file("${var.relative_path_to_versions_yaml}/versions.yaml"))
  traefik  = local.versions.traefik
}

# Installs [`Traefik v3`](https://github.com/traefik/traefik),
# which provides ingress controller with built-in ACME support and OIDC authentication plugin capabilities.
module "traefik" {
  source = "../../../../../common/modules/helm-terraform-installer" # needed for terraform-docs compatibility
  #source     = local.helm_terraform_installer_path

  chart_name    = local.traefik.chartName
  chart_repo    = local.traefik.chartRepo
  chart_version = local.traefik.chartVersion
  namespace     = local.traefik.namespace
  release_name  = local.traefik.releaseName

  chart_values = templatefile("${path.module}/files/traefik.values.yaml.tftpl", {
    acme_contact              = var.acme_contact
    acme_server_directory_url = var.acme_server_directory_url
  })

  pre_install_resources = [{
    yaml = templatefile("${path.module}/files/traefik.configmap.step-ca-root-cert.pre-install.yaml.tftpl", {
      traefik_namespace = local.traefik.namespace
      root_ca_content   = var.root_ca_certificate
    })
  }]

  post_install_resources = [
    {
      yaml = templatefile("${path.module}/files/traefik.middleware.redirect-to-dashboard.post-install.yaml.tftpl", {
        traefik_namespace = local.traefik.namespace
      })
    },
    {
      yaml = templatefile("${path.module}/files/traefik.ingress-route.post-install.yaml.tftpl", {
        traefik_namespace   = local.traefik.namespace
        cluster_domain      = var.cluster.domain
        external_dns_target = "${var.cluster.name}.${var.cluster.domain}" # adding a CNAME record
      })
    }
  ]
}