/**
 * # Cluster Setup
 *
 * This module and its sub-modules setup the Talos cluster on the Proxmox host.
 */

locals {
  nodes_with_iso = [
    for node in var.nodes : merge(node, {
      iso = module.download_talos_images[node.name].downloaded_iso_id
    })
  ]
}

# Downloads the calculated Talos images specified in the `nodes` configurations.
module "download_talos_images" {
  source = "./modules/talos-download-image"

  proxmox = var.proxmox

  for_each = { for idx, node in var.nodes : node.name => node }

  talos_version = each.value.talos_version
  schematic     = each.value.schematic
  platform      = each.value.platform
  arch          = each.value.arch
}

# Prepares the cluster creation by generating the **Talos machine secrets**
# and creating the **Talos client cluster configuration**.
module "prepare_talos_cluster" {
  source     = "./modules/talos-prepare-cluster"
  depends_on = [module.download_talos_images]

  cluster = {
    name          = var.cluster.name
    talos_version = var.cluster.talos_version
  }

  nodes = [for node in var.nodes : {
    ip           = node.ip
    machine_type = node.machine_type
  }]
}

# Creates the given Talos VMs, uses `for_each` on the list of nodes.
module "create_talos_vms" {
  source     = "./modules/talos-create-vm"
  depends_on = [module.prepare_talos_cluster]

  providers = {
    helm.templating = helm.templating
  }

  proxmox                    = var.proxmox
  cluster                    = var.cluster
  talos_machine_secrets      = module.prepare_talos_cluster.machine_secrets
  talos_client_configuration = module.prepare_talos_cluster.client_configuration
  cilium_version             = var.cilium_version

  for_each = { for idx, node in local.nodes_with_iso : node.name => node }

  node_description  = each.value.description
  node_tags         = each.value.tags
  node_name         = each.value.name
  node_host         = each.value.host
  node_machine_type = each.value.machine_type
  node_bridge       = each.value.bridge
  node_ip           = each.value.ip
  node_mac_address  = each.value.mac_address
  node_vm_id        = each.value.vm_id
  node_cpu          = each.value.cpu
  node_ram          = each.value.ram
  node_iso          = each.value.iso
  node_datastore_id = each.value.datastore_id
}

# Awaits the Talos cluster to become ready and available.
# <p>This module returns once all Talos nodes are up, running and healthy.</p>
module "await_talos_cluster" {
  source     = "./modules/talos-await-cluster"
  depends_on = [module.create_talos_vms]

  cluster = {
    name          = var.cluster.name
    talos_version = var.cluster.talos_version
    endpoint      = var.cluster.endpoint
  }
  talos_machine_secrets      = module.prepare_talos_cluster.machine_secrets
  talos_client_configuration = module.prepare_talos_cluster.client_configuration

  nodes = [for node in var.nodes : {
    name         = node.name
    ip           = node.ip
    machine_type = node.machine_type
  }]
}

# Installs [`cert-manager`](https://github.com/cert-manager/cert-manager),
# which manages TLS certificates for workloads.
module "install_cert_manager" {
  source     = "./modules/core-install-cert-manager"
  depends_on = [module.await_talos_cluster]

  providers = {
    helm.deploying = helm.deploying
  }

  chart_version = var.cert_manager_version
  namespace     = var.cert_manager_namespace
}

# Installs [`sealed-secrets`](https://github.com/bitnami-labs/sealed-secrets),
# which manages `SealedSecret` resources, en- and decrypting them as necessary.
module "install_sealed_secrets" {
  source     = "./modules/core-install-sealed-secrets"
  depends_on = [module.install_cert_manager]

  providers = {
    helm.deploying = helm.deploying
  }

  chart_version = var.sealed_secrets_version
  namespace     = var.sealed_secrets_namespace
}

# Issues an **intermediate Kubernetes __CA__ certificate** using [`cert-manager`](#install_cert_manager)
# and [`sealed-secrets`](#install_sealed_secrets).
# <p>The mandatory `SealedSecret` and `ClusterIssuer` resources for the intermediate CA certificate are created in this module.</p>
module "setup_k8s_ca" {
  source     = "./modules/core-setup-k8s-ca"
  depends_on = [module.install_sealed_secrets]

  proxmox = {
    host     = var.proxmox.host
    ssh_user = var.proxmox.ssh_user
    ssh_key  = var.proxmox.ssh_key
  }

  proxmox_root_ca  = var.proxmox_root_ca
  k8s_ca           = var.k8s_ca
  secret_namespace = var.cert_manager_namespace
}

# Installs [`external-dns`](https://github.com/kubernetes-sigs/external-dns),
# which allows to forward requests about adding or removing `CNAME` and `A`/`AAAA` records to a given DNS (PiHole in this case)
# when a such a service is deployed (add) or destroyed (remove).
module "install_external_dns" {
  source     = "./modules/dns-install-external-dns"
  depends_on = [module.k8s_ca_install]

  providers = {
    helm.deploying = helm.deploying
  }

  chart_version = var.external_dns_version
}

# Installs [`longhorn`](https://longhorn.io/), which allows to manage distributed
# storage of `PersistentVolume` and `PersistentVolumeClaims`.
module "install_longhorn" {
  source     = "./modules/storage-install-longhorn"
  depends_on = [module.external_dns_install]

  providers = {
    helm.deploying = helm.deploying
  }

  chart_version = var.longhorn_version
  nodes_count   = length([for node in var.nodes : true if node.machine_type == "worker"])
  ca_issuer     = module.k8s_ca_install.k8s_ca_issuer
}

# Exposes the [Cilium Hubble UI](https://docs.cilium.io/en/stable/observability/hubble/hubble-ui/),
# which allows to see a Service Map and inspect a variety of network traffic.
module "expose_hubble_ui" {
  source     = "./modules/monitoring-expose-hubble-ui"
  depends_on = [module.external_dns_install]

  ca_issuer = module.k8s_ca_install.k8s_ca_issuer
}
