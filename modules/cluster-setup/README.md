# Cluster Setup

This module and its sub-modules setup the Talos cluster on the Proxmox host.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules) _(nested and adjacent)_
  - [await_talos_cluster](#await_talos_cluster)
  - [create_talos_vms](#create_talos_vms)
  - [download_talos_images](#download_talos_images)
  - [expose_hubble_ui](#expose_hubble_ui)
  - [install_cert_manager](#install_cert_manager)
  - [install_external_dns](#install_external_dns)
  - [install_longhorn](#install_longhorn)
  - [install_sealed_secrets](#install_sealed_secrets)
  - [prepare_talos_cluster](#prepare_talos_cluster)
  - [setup_k8s_ca](#setup_k8s_ca)
- [Resources](#resources)
  - [k8s_sealed_secret](#k8s_sealed_secret-local_file) (*local_file*)
  - [kube_config](#kube_config-local_file) (*local_file*)
  - [machine_configs](#machine_configs-local_file) (*local_file*)
  - [talos_config](#talos_config-local_file) (*local_file*)
- [Variables](#variables)
  - [cluster](#cluster-required) (**Required**)
  - [nodes](#nodes-required) (**Required**)
  - [proxmox](#proxmox-required) (**Required**)
  - [cert_manager_namespace](#cert_manager_namespace-optional) (*Optional*)
  - [cert_manager_version](#cert_manager_version-optional) (*Optional*)
  - [cilium_version](#cilium_version-optional) (*Optional*)
  - [external_dns_version](#external_dns_version-optional) (*Optional*)
  - [k8s_ca](#k8s_ca-optional) (*Optional*)
  - [k8s_sealed_secret_ca_file](#k8s_sealed_secret_ca_file-optional) (*Optional*)
  - [kube_config_file](#kube_config_file-optional) (*Optional*)
  - [longhorn_version](#longhorn_version-optional) (*Optional*)
  - [proxmox_root_ca](#proxmox_root_ca-optional) (*Optional*)
  - [sealed_secrets_controller_name](#sealed_secrets_controller_name-optional) (*Optional*)
  - [sealed_secrets_namespace](#sealed_secrets_namespace-optional) (*Optional*)
  - [sealed_secrets_version](#sealed_secrets_version-optional) (*Optional*)
  - [talos_config_file](#talos_config_file-optional) (*Optional*)
  - [talos_machine_config_file](#talos_machine_config_file-optional) (*Optional*)
- [Outputs](#outputs)
  - [kube_config](#kube_config)
  - [talos_config](#talos_config)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.17.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.19.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >= 0.69.0 |
| <a name="requirement_sealedsecret"></a> [sealedsecret](#requirement\_sealedsecret) | >=1.1.16 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | >= 0.7.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.2 |
## Modules
<blockquote>

### `await_talos_cluster`
Awaits the Talos cluster to become ready and available. <p>This module returns once all Talos nodes are up, running and healthy.</p>

| | |
|:--- |:--- |
| Module location | `./modules/talos-await-cluster`
| Called in file | `main.tf#80`
</blockquote>
<blockquote>

### `create_talos_vms`
Creates the given Talos VMs, uses `for_each` on the list of nodes.

| | |
|:--- |:--- |
| Module location | `./modules/talos-create-vm`
| Called in file | `main.tf#47`
</blockquote>
<blockquote>

### `download_talos_images`
Downloads the calculated Talos images specified in the `nodes` configurations.

| | |
|:--- |:--- |
| Module location | `./modules/talos-download-image`
| Called in file | `main.tf#16`
</blockquote>
<blockquote>

### `expose_hubble_ui`
Exposes the [Cilium Hubble UI](https://docs.cilium.io/en/stable/observability/hubble/hubble-ui/), which allows to see a Service Map and inspect a variety of network traffic.

| | |
|:--- |:--- |
| Module location | `./modules/monitoring-expose-hubble-ui`
| Called in file | `main.tf#176`
</blockquote>
<blockquote>

### `install_cert_manager`
Installs [`cert-manager`](https://github.com/cert-manager/cert-manager), which manages TLS certificates for workloads.

| | |
|:--- |:--- |
| Module location | `./modules/core-install-cert-manager`
| Called in file | `main.tf#101`
</blockquote>
<blockquote>

### `install_external_dns`
Installs [`external-dns`](https://github.com/kubernetes-sigs/external-dns), which allows to forward requests about adding or removing `CNAME` and `A`/`AAAA` records to a given DNS (PiHole in this case) when a such a service is deployed (add) or destroyed (remove).

| | |
|:--- |:--- |
| Module location | `./modules/dns-install-external-dns`
| Called in file | `main.tf#148`
</blockquote>
<blockquote>

### `install_longhorn`
Installs [`longhorn`](https://longhorn.io/), which allows to manage distributed storage of `PersistentVolume` and `PersistentVolumeClaims`.

| | |
|:--- |:--- |
| Module location | `./modules/storage-install-longhorn`
| Called in file | `main.tf#161`
</blockquote>
<blockquote>

### `install_sealed_secrets`
Installs [`sealed-secrets`](https://github.com/bitnami-labs/sealed-secrets), which manages `SealedSecret` resources, en- and decrypting them as necessary.

| | |
|:--- |:--- |
| Module location | `./modules/core-install-sealed-secrets`
| Called in file | `main.tf#115`
</blockquote>
<blockquote>

### `prepare_talos_cluster`
Prepares the cluster creation by generating the **Talos machine secrets** and creating the **Talos client cluster configuration**.

| | |
|:--- |:--- |
| Module location | `./modules/talos-prepare-cluster`
| Called in file | `main.tf#31`
</blockquote>
<blockquote>

### `setup_k8s_ca`
Issues an **intermediate Kubernetes __CA__ certificate** using [`cert-manager`](#install_cert_manager) and [`sealed-secrets`](#install_sealed_secrets). <p>The mandatory `SealedSecret` and `ClusterIssuer` resources for the intermediate CA certificate are created in this module.</p>

| | |
|:--- |:--- |
| Module location | `./modules/core-setup-k8s-ca`
| Called in file | `main.tf#130`
</blockquote>


## Resources
<blockquote>

#### `k8s_sealed_secret` (_local_file_)
Defined in file: `outputs.tf#20`
</blockquote>
<blockquote>

#### `kube_config` (_local_file_)
Defined in file: `outputs.tf#14`
</blockquote>
<blockquote>

#### `machine_configs` (_local_file_)
Defined in file: `outputs.tf#7`
</blockquote>
<blockquote>

#### `talos_config` (_local_file_)
Defined in file: `outputs.tf#1`
</blockquote>

## Variables
<blockquote>

### `cluster` (**Required**)
Cluster configuration

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    name              = string
    talos_version     = string
    gateway           = string
    endpoint          = string
    lb_cidr           = string
    talos_factory_url = optional(string, "https://factory.talos.dev/")
  })
  ```
  Defined in file: `variables.tf#15`

</details>
</blockquote>
<blockquote>

### `nodes` (**Required**)
Configuration for cluster nodes

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(object({
    talos_version = string
    schematic     = optional(string)
    platform      = optional(string)
    arch          = optional(string)
    name          = string
    description   = optional(string)
    tags          = optional(list(string))
    host          = string
    machine_type  = string
    bridge        = optional(string)
    ip            = string
    mac_address   = string
    vm_id         = number
    cpu           = number
    ram           = number
    datastore_id  = optional(string)
  }))
  ```
  Defined in file: `variables.tf#103`

</details>
</blockquote>
<blockquote>

### `proxmox` (**Required**)
Proxmox host configuration

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    name      = string
    host      = string
    endpoint  = string
    insecure  = bool
    api_token = string
    iso_store = optional(string, "local")
    ssh_user  = string
    ssh_key   = string
  })
  ```
  Defined in file: `variables.tf#1`

</details>
</blockquote>
<blockquote>

### `cert_manager_namespace` (*Optional*)
Namespace where the cert-manager will be installed to

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "cert-manager"
  ```
  Defined in file: `variables.tf#175`

</details>
</blockquote>
<blockquote>

### `cert_manager_version` (*Optional*)
Version of the cert-manager Helm Chart to install

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "1.17.1"
  ```
  Defined in file: `variables.tf#168`

</details>
</blockquote>
<blockquote>

### `cilium_version` (*Optional*)
Cilium version

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "1.17.1"
  ```
  Defined in file: `variables.tf#154`

</details>
</blockquote>
<blockquote>

### `external_dns_version` (*Optional*)
Version of the external-dns Helm Chart to install

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "8.7.5"
  ```
  Defined in file: `variables.tf#182`

</details>
</blockquote>
<blockquote>

### `k8s_ca` (*Optional*)
Intermediate Kubernetes CA used as ClusterIssuer

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    subject = object({
      common_name         = string
      organization        = string
      organizational_unit = string
      country             = string
      locality            = string
      province            = string
    })
    private_key = object({
      algorithm = string
      rsa_bits  = number
    })
    validity_period_hours = number
  })
  ```
  **Default**:
  ```json
  {
  "private_key": {
    "algorithm": "RSA",
    "rsa_bits": 4096
  },
  "subject": {
    "common_name": "Proxmox VE Kubernetes Intermediate CA",
    "country": "DE",
    "locality": "Home Lab",
    "organization": "PVE Cluster Manager CA",
    "organizational_unit": "Kubernetes",
    "province": "Private Network"
  },
  "validity_period_hours": 78840
}
  ```
  Defined in file: `variables.tf#40`

</details>
</blockquote>
<blockquote>

### `k8s_sealed_secret_ca_file` (*Optional*)
File name and path for the generated sealed secret of the intermediate Kubernetes CA certificate

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "output/k8s_sealed_secret_ca.yaml"
  ```
  Defined in file: `variables.tf#96`

</details>
</blockquote>
<blockquote>

### `kube_config_file` (*Optional*)
File name and path for the generated kube-config

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "output/kube-config.yaml"
  ```
  Defined in file: `variables.tf#75`

</details>
</blockquote>
<blockquote>

### `longhorn_version` (*Optional*)
Version of the Longhorn Helm Chart to install

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "1.8.0"
  ```
  Defined in file: `variables.tf#161`

</details>
</blockquote>
<blockquote>

### `proxmox_root_ca` (*Optional*)
Proxmox root CA certificate and key to use for the intermediate k8s certificate

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    pve_root_cert = string
    pve_root_key  = string
  })
  ```
  **Default**:
  ```json
  {
  "pve_root_cert": "/etc/pve/pve-root-ca.pem",
  "pve_root_key": "/etc/pve/priv/pve-root-ca.key"
}
  ```
  Defined in file: `variables.tf#27`

</details>
</blockquote>
<blockquote>

### `sealed_secrets_controller_name` (*Optional*)
Name of the sealed-secrets controller

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "sealed-secrets-release"
  ```
  Defined in file: `variables.tf#203`

</details>
</blockquote>
<blockquote>

### `sealed_secrets_namespace` (*Optional*)
Namespace where the sealed-secrets operator will be installed to

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "sealed-secrets"
  ```
  Defined in file: `variables.tf#196`

</details>
</blockquote>
<blockquote>

### `sealed_secrets_version` (*Optional*)
Version of the sealed-secrets Helm Chart to install

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "2.17.1"
  ```
  Defined in file: `variables.tf#189`

</details>
</blockquote>
<blockquote>

### `talos_config_file` (*Optional*)
File name and path for the generated talos-config

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "output/talos-config.yaml"
  ```
  Defined in file: `variables.tf#82`

</details>
</blockquote>
<blockquote>

### `talos_machine_config_file` (*Optional*)
File name and path for the generated talos-machine-config; use <node-name> in the file name to replace with node name

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "output/talos-machine-config-<node-name>.yaml"
  ```
  Defined in file: `variables.tf#89`

</details>
</blockquote>


## Outputs
<blockquote>

#### `kube_config`
String containing the `kube-config.yaml`

Defined in file: `outputs.tf#32`
</blockquote>
<blockquote>

#### `talos_config`
String containing the `talos-config.yaml`

Defined in file: `outputs.tf#26`
</blockquote>