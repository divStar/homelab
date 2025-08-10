/**
 * # Cilium Setup
 *
 * This module installs and configures Cilium.
 */

locals {
  versions = yamldecode(file("${var.relative_path_to_versions_yaml}/versions.yaml"))
  cilium   = local.versions.cilium
}

# Pre-fetch all the Cilium CRDs, that need to be installed beforehand;
# replace their `<VERSION>` placeholder (if it exists) with `local.versions.cilium.chartVersion`.
data "http" "cilium_crds_pre_install" {
  for_each = toset(var.cilium_crds)

  url = replace(each.value, "<VERSION>", local.versions.cilium.chartVersion)
}

# Installs [`Cilium`](https://github.com/cilium/cilium) CNI,
# which is a networking, observability, and security solution with an eBPF-based dataplane.
module "cilium" {
  source = "../../../../../common/modules/helm-terraform-installer" # needed for terraform-docs compatibility
  # Do NOT use absolute file paths as the modules will be copied into the local module / terraform cache!
  # source = local.helm_terraform_installer_path

  chart_name    = local.cilium.chartName
  chart_repo    = local.cilium.chartRepo
  chart_version = local.cilium.chartVersion
  namespace     = local.cilium.namespace
  release_name  = local.cilium.releaseName

  chart_values = templatefile("${path.module}/files/cilium.values.yaml.tftpl", {
    cluster_name             = var.cluster.name
    cilium_loadbalancer_cidr = var.cluster.lb_cidr
  })
  is_privileged_namespace = true

  chart_timeout = 300 # 5 minutes

  pre_install_resources = concat(
    values(data.http.cilium_crds_pre_install)[*].response_body,
    [
      templatefile("${path.module}/files/cilium.cilium-load-balancer-ip-pool.post-install.yaml.tftpl", {
        namespace = local.cilium.namespace
        lb_cidr   = var.cluster.lb_cidr
      }),
      templatefile("${path.module}/files/cilium.cilium-l2-announcement-policy.post-install.yaml.tftpl", {
        namespace = local.cilium.namespace
      })
    ]
  )

  post_install_resources = [
    templatefile("${path.module}/files/cilium.ingress-route.post-install.yaml.tftpl", {
      cilium_namespace    = local.cilium.namespace
      cluster_domain      = var.cluster.domain
      external_dns_target = "${var.cluster.name}.${var.cluster.domain}" # adding a CNAME record
    })
  ]
}