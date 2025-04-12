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
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/talos-await-cluster</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L80"><code>main.tf#L80</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/talos-await-cluster/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `create_talos_vms`
Creates the given Talos VMs, uses `for_each` on the list of nodes.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/talos-create-vm</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L47"><code>main.tf#L47</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/talos-create-vm/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `download_talos_images`
Downloads the calculated Talos images specified in the `nodes` configurations.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/talos-download-image</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L16"><code>main.tf#L16</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/talos-download-image/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `expose_hubble_ui`
Exposes the [Cilium Hubble UI](https://docs.cilium.io/en/stable/observability/hubble/hubble-ui/), which allows to see a Service Map and inspect a variety of network traffic.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/monitoring-expose-hubble-ui</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L176"><code>main.tf#L176</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/monitoring-expose-hubble-ui/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `install_cert_manager`
Installs [`cert-manager`](https://github.com/cert-manager/cert-manager), which manages TLS certificates for workloads.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/core-install-cert-manager</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L101"><code>main.tf#L101</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/core-install-cert-manager/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `install_external_dns`
Installs [`external-dns`](https://github.com/kubernetes-sigs/external-dns), which allows to forward requests about adding or removing `CNAME` and `A`/`AAAA` records to a given DNS (PiHole in this case) when a such a service is deployed (add) or destroyed (remove).
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/dns-install-external-dns</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L148"><code>main.tf#L148</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/dns-install-external-dns/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `install_longhorn`
Installs [`longhorn`](https://longhorn.io/), which allows to manage distributed storage of `PersistentVolume` and `PersistentVolumeClaims`.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/storage-install-longhorn</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L161"><code>main.tf#L161</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/storage-install-longhorn/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `install_sealed_secrets`
Installs [`sealed-secrets`](https://github.com/bitnami-labs/sealed-secrets), which manages `SealedSecret` resources, en- and decrypting them as necessary.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/core-install-sealed-secrets</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L115"><code>main.tf#L115</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/core-install-sealed-secrets/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `prepare_talos_cluster`
Prepares the cluster creation by generating the **Talos machine secrets** and creating the **Talos client cluster configuration**.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/talos-prepare-cluster</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L31"><code>main.tf#L31</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/talos-prepare-cluster/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `setup_k8s_ca`
Issues an **intermediate Kubernetes __CA__ certificate** using [`cert-manager`](#install_cert_manager) and [`sealed-secrets`](#install_sealed_secrets). <p>The mandatory `SealedSecret` and `ClusterIssuer` resources for the intermediate CA certificate are created in this module.</p>
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/core-setup-k8s-ca</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L130"><code>main.tf#L130</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/core-setup-k8s-ca/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>


## Resources
<blockquote>

#### `k8s_sealed_secret` (_local_file_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>local (hashicorp/local)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./outputs.tf#L20"><code>outputs.tf#L20</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `kube_config` (_local_file_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>local (hashicorp/local)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./outputs.tf#L14"><code>outputs.tf#L14</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `machine_configs` (_local_file_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>local (hashicorp/local)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./outputs.tf#L7"><code>outputs.tf#L7</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `talos_config` (_local_file_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>local (hashicorp/local)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a></td>
    </tr>
  </table>
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
  In file: <a href="./variables.tf#L15"><code>variables.tf#L15</code></a>

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
  In file: <a href="./variables.tf#L103"><code>variables.tf#L103</code></a>

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
  In file: <a href="./variables.tf#L1"><code>variables.tf#L1</code></a>

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
  In file: <a href="./variables.tf#L175"><code>variables.tf#L175</code></a>

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
  In file: <a href="./variables.tf#L168"><code>variables.tf#L168</code></a>

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
  In file: <a href="./variables.tf#L154"><code>variables.tf#L154</code></a>

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
  In file: <a href="./variables.tf#L182"><code>variables.tf#L182</code></a>

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
  In file: <a href="./variables.tf#L40"><code>variables.tf#L40</code></a>

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
  In file: <a href="./variables.tf#L96"><code>variables.tf#L96</code></a>

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
  In file: <a href="./variables.tf#L75"><code>variables.tf#L75</code></a>

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
  In file: <a href="./variables.tf#L161"><code>variables.tf#L161</code></a>

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
  In file: <a href="./variables.tf#L27"><code>variables.tf#L27</code></a>

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
  In file: <a href="./variables.tf#L203"><code>variables.tf#L203</code></a>

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
  In file: <a href="./variables.tf#L196"><code>variables.tf#L196</code></a>

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
  In file: <a href="./variables.tf#L189"><code>variables.tf#L189</code></a>

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
  In file: <a href="./variables.tf#L82"><code>variables.tf#L82</code></a>

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
  In file: <a href="./variables.tf#L89"><code>variables.tf#L89</code></a>

</details>
</blockquote>


## Outputs
<blockquote>

#### `kube_config`
String containing the `kube-config.yaml`

In file: <a href="./outputs.tf#L32"><code>outputs.tf#L32</code></a>
</blockquote>
<blockquote>

#### `talos_config`
String containing the `talos-config.yaml`

In file: <a href="./outputs.tf#L26"><code>outputs.tf#L26</code></a>
</blockquote>