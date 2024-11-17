module "talos" {
  source = "./talos"

  providers = {
    proxmox = proxmox
  }

  image = {
    version        = try(var.talos.version, "1.8.3")
    update_version = try(var.talos.version, "1.8.3") # renovate: github-releases=siderolabs/talos
    schematic      = file("${path.module}/talos/image/schematic.yaml")
  }

  cilium = {
    values = file("${path.module}/talos/cilium/values.yaml")
    install = templatefile("${path.module}/talos/cilium/inline-install.yaml", {
      version                 = var.cilium.version
      kubernetes_service_port = 6443
    })
  }

  cluster = {
    name            = try(var.talos.cluster_name, "talos")
    endpoint        = try(var.talos.endpoint, "192.168.178.100")
    gateway         = try(var.talos.gateway, "192.168.178.1")
    talos_version   = try(var.talos.version, "1.8.3")
    proxmox_cluster = try(var.proxmox.cluster_name, "homelab")
  }

  nodes = {
    for node in var.talos.nodes : node.name => {
      host_node     = coalesce(node.host_node, var.proxmox.name)
      machine_type  = node.machine_type
      ip            = node.ip
      mac_address   = node.mac_address
      vm_id         = node.vm_id
      cpu           = node.cpu
      ram_dedicated = node.ram_dedicated
    }
  }
}

module "sealed_secrets" {
  depends_on = [module.talos]
  source     = "./sealed-secrets"

  providers = {
    kubernetes = kubernetes
  }

  // openssl req -x509 -days 365 -nodes -newkey rsa:4096 -keyout sealed-secrets.key -out sealed-secrets.cert -subj "/CN=sealed-secret/O=sealed-secret"
  cert = {
    cert = file("${path.module}/sealed-secrets/certificate/sealed-secrets.cert")
    key  = file("${path.module}/sealed-secrets/certificate/sealed-secrets.key")
  }
}

# module "proxmox_csi_plugin" {
#   depends_on = [module.talos]
#   source = "./proxmox-csi-plugin"

#   providers = {
#     proxmox    = proxmox
#     kubernetes = kubernetes
#   }

#   proxmox = var.proxmox
# }
