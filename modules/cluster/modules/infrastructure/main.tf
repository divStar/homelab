/**
 * # Infrastructure Setup
 *
 * This module sets up the most critical k8s applications.
 */

locals {
  versions               = yamldecode(file("${var.relative_path_to_versions_yaml}/versions.yaml"))
  cilium                 = local.versions.cilium
  external_dns           = local.versions.externalDns
  local_path_provisioner = local.versions.localPathProvisioner
  traefik                = local.versions.traefik
}

# Installs [`Traefik v3`](https://github.com/traefik/traefik) *CRDs*
# in order to allow the deployment of `IngressRoute` resources before Traefik is deployed.
module "traefik_crds" {
  source = "./modules/traefik-crds"

  cluster                        = var.cluster
  relative_path_to_versions_yaml = var.relative_path_to_versions_yaml
}

# Installs [`Cilium`](https://github.com/cilium/cilium) CNI,
# which is a networking, observability, and security solution with an eBPF-based dataplane.
module "cilium" {
  source     = "./modules/cilium"
  depends_on = [module.traefik_crds]

  cluster                        = var.cluster
  relative_path_to_versions_yaml = var.relative_path_to_versions_yaml
}

# Installs [`external-dns`](https://github.com/kubernetes-sigs/external-dns),
# which allows to forward requests about adding or removing `CNAME` and `A`/`AAAA` records to a given DNS (PiHole in this case)
# when a such a service is deployed (add) or destroyed (remove).
module "external_dns" {
  source     = "./modules/external-dns"
  depends_on = [module.cilium]

  cluster                        = var.cluster
  relative_path_to_versions_yaml = var.relative_path_to_versions_yaml
}

# Installs [`local-path-provisioner`](https://github.com/rancher/local-path-provisioner),
# which is used for [PersistentVolumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistent-volumes)
# and [PersistentVolumeClaims](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims).
module "local_path_provisioner" {
  source     = "./modules/local-path-provisioner"
  depends_on = [module.cilium]

  cluster                        = var.cluster
  relative_path_to_versions_yaml = var.relative_path_to_versions_yaml
}

# Installs [`Traefik v3`](https://github.com/traefik/traefik),
# which provides ingress controller with built-in ACME support and OIDC authentication plugin capabilities.
module "traefik" {
  source     = "./modules/traefik"
  depends_on = [module.external_dns, module.local_path_provisioner]

  cluster                        = var.cluster
  relative_path_to_versions_yaml = var.relative_path_to_versions_yaml
  root_ca_certificate            = var.root_ca_certificate
}
