/**
 * # external-dns Setup
 *
 * This module installs and configures external-dns.
 */

locals {
  versions     = yamldecode(file("${var.relative_path_to_versions_yaml}/versions.yaml"))
  external_dns = local.versions.externalDns
}

# Installs [`external-dns`](https://github.com/kubernetes-sigs/external-dns),
# which allows to forward requests about adding or removing `CNAME` and `A`/`AAAA` records to a given DNS (PiHole in this case)
# when a such a service is deployed (add) or destroyed (remove).
module "external_dns" {
  source = "../../../../../common/modules/helm-terraform-installer" # needed for terraform-docs compatibility
  #source = local.helm_terraform_installer_path

  chart_name    = local.external_dns.chartName
  chart_repo    = local.external_dns.chartRepo
  chart_version = local.external_dns.chartVersion
  namespace     = local.external_dns.namespace
  release_name  = local.external_dns.releaseName

  chart_values = templatefile("${path.module}/files/external-dns.values.yaml.tftpl", {
    external_dns_namespace   = local.external_dns.namespace
    external_dns_secret_name = var.external_dns_secret_name
    cluster_name             = var.cluster.name
  })

  pre_install_resources = [{
    yaml = templatefile("${path.module}/files/external-dns.secret.yaml.tftpl", {
      external_dns_namespace   = local.external_dns.namespace
      external_dns_secret_name = var.external_dns_secret_name
    })
  }]
}