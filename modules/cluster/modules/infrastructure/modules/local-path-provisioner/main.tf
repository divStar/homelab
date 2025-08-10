/**
 * # local-path-provisioner Setup
 *
 * This module installs and configures local-path-provisioner.
 */

locals {
  versions               = yamldecode(file("${var.relative_path_to_versions_yaml}/versions.yaml"))
  local_path_provisioner = local.versions.localPathProvisioner
}

# Installs [`local-path-provisioner`](https://github.com/rancher/local-path-provisioner),
# which is used for [PersistentVolumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistent-volumes)
# and [PersistentVolumeClaims](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims).
module "local_path_provisioner" {
  source = "../../../../../common/modules/helm-terraform-installer" # needed for terraform-docs compatibility
  #source = local.helm_terraform_installer_path

  chart_name    = local.local_path_provisioner.chartName
  chart_repo    = local.local_path_provisioner.chartRepo
  chart_version = local.local_path_provisioner.chartVersion
  namespace     = local.local_path_provisioner.namespace
  release_name  = local.local_path_provisioner.releaseName

  chart_values            = file("${path.module}/files/local-path-provisioner.values.yaml")
  is_privileged_namespace = true
}