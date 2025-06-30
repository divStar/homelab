# Cluster Setup

This module and its sub-modules setup the Talos cluster on the Proxmox host.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules) _(nested and adjacent)_
  - [cert_manager](#cert_manager)
  - [cilium](#cilium)
  - [external_dns](#external_dns)
  - [hubble_ui](#hubble_ui)
  - [k8s_ca](#k8s_ca)
  - [local_path_provisioner](#local_path_provisioner)
  - [sealed_secrets](#sealed_secrets)
  - [talos_cluster_prepare](#talos_cluster_prepare)
  - [talos_cluster_ready](#talos_cluster_ready)
  - [talos_images](#talos_images)
  - [talos_vms](#talos_vms)
- [Resources](#resources)
  - [kube_config](#kube_config-local_file) (*local_file*)
  - [machine_configs](#machine_configs-local_file) (*local_file*)
  - [talos_config](#talos_config-local_file) (*local_file*)
  - [external_dns_secret](#external_dns_secret-sealedsecret_sealedsecret) (*sealedsecret_sealedsecret*)
- [Variables](#variables)
  - [cert_manager_version](#cert_manager_version-required) (**Required**)
  - [cilium_version](#cilium_version-required) (**Required**)
  - [cluster](#cluster-required) (**Required**)
  - [external_dns_version](#external_dns_version-required) (**Required**)
  - [local_path_provisioner_version](#local_path_provisioner_version-required) (**Required**)
  - [nodes](#nodes-required) (**Required**)
  - [proxmox](#proxmox-required) (**Required**)
  - [sealed_secrets_version](#sealed_secrets_version-required) (**Required**)
  - [talos_linux_version](#talos_linux_version-required) (**Required**)
  - [target_kube_version](#target_kube_version-required) (**Required**)
  - [acme_contact](#acme_contact-optional) (*Optional*)
  - [acme_server_directory_url](#acme_server_directory_url-optional) (*Optional*)
  - [cert_manager_namespace](#cert_manager_namespace-optional) (*Optional*)
  - [k8s_sealed_secret_ca_file](#k8s_sealed_secret_ca_file-optional) (*Optional*)
  - [kube_config_file](#kube_config_file-optional) (*Optional*)
  - [sealed_secrets_controller_name](#sealed_secrets_controller_name-optional) (*Optional*)
  - [sealed_secrets_namespace](#sealed_secrets_namespace-optional) (*Optional*)
  - [step_ca_host](#step_ca_host-optional) (*Optional*)
  - [talos_config_file](#talos_config_file-optional) (*Optional*)
  - [talos_machine_config_file](#talos_machine_config_file-optional) (*Optional*)
- [Outputs](#outputs)
  - [kube_config](#kube_config)
  - [talos_config](#talos_config)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 3.0.1 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.19.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >= 0.78.2 |
| <a name="requirement_sealedsecret"></a> [sealedsecret](#requirement\_sealedsecret) | >=1.1.16 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | >= 0.8.1 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | 3.5.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.3 |
| <a name="provider_sealedsecret"></a> [sealedsecret](#provider\_sealedsecret) | 1.1.16 |
## Modules
<blockquote>

### `cert_manager`
Installs [`cert-manager`](https://github.com/cert-manager/cert-manager), which manages TLS certificates for workloads.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>../common/modules/helm-terraform-installer</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L150"><code>main.tf#L150</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="../common/modules/helm-terraform-installer/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `cilium`
Installs [`Cilium`](httpshttps://github.com/cilium/cilium) CNI, which is a networking, observability, and security solution with an eBPF-based dataplane.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>../common/modules/helm-terraform-installer</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L114"><code>main.tf#L114</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="../common/modules/helm-terraform-installer/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `external_dns`
Installs [`external-dns`](https://github.com/kubernetes-sigs/external-dns), which allows to forward requests about adding or removing `CNAME` and `A`/`AAAA` records to a given DNS (PiHole in this case) when a such a service is deployed (add) or destroyed (remove).
  <table>
    <tr>
      <td>Module location</td>
      <td><code>../common/modules/helm-terraform-installer</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L211"><code>main.tf#L211</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="../common/modules/helm-terraform-installer/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `hubble_ui`
Exposes the [Cilium Hubble UI](https://docs.cilium.io/en/stable/observability/hubble/hubble-ui/), which allows to see a Service Map and inspect a variety of network traffic.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/monitoring-expose-hubble-ui</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L256"><code>main.tf#L256</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/monitoring-expose-hubble-ui/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `k8s_ca`
Sets up a `ClusterIssuer` resource based on the provided ACME information.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/core-setup-k8s-ca</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L185"><code>main.tf#L185</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/core-setup-k8s-ca/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `local_path_provisioner`
Installs [`local-path-provisioner`](https://github.com/rancher/local-path-provisioner), which is used for [PersistentVolumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistent-volumes) and [PersistentVolumeClaims](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims).
  <table>
    <tr>
      <td>Module location</td>
      <td><code>../common/modules/helm-terraform-installer</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L236"><code>main.tf#L236</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="../common/modules/helm-terraform-installer/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `sealed_secrets`
Installs [`sealed-secrets`](https://github.com/bitnami-labs/sealed-secrets), which manages `SealedSecret` resources, en- and decrypting them as necessary.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>../common/modules/helm-terraform-installer</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L169"><code>main.tf#L169</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="../common/modules/helm-terraform-installer/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `talos_cluster_prepare`
Prepares the cluster creation by generating the **Talos machine secrets** and creating the **Talos client cluster configuration**.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/talos-prepare-cluster</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L34"><code>main.tf#L34</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/talos-prepare-cluster/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `talos_cluster_ready`
Awaits the Talos cluster to become ready and available. <p>This module returns once all Talos nodes are up, running and healthy.</p>
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/talos-await-cluster</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L85"><code>main.tf#L85</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/talos-await-cluster/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `talos_images`
Downloads the calculated Talos images specified in the `nodes` configurations.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/talos-download-image</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L19"><code>main.tf#L19</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/talos-download-image/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `talos_vms`
Creates the given Talos VMs, uses `for_each` on the list of nodes.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/talos-create-vm</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L48"><code>main.tf#L48</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/talos-create-vm/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>


## Resources
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
<blockquote>

#### `external_dns_secret` (_sealedsecret_sealedsecret_)
Creates an `external-dns` secret, that contains credentials to access a external DNS system (PiHole in this case).
  <table>
    <tr>
      <td>Provider</td>
      <td><code>sealedsecret (jifwin/sealedsecret)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L196"><code>main.tf#L196</code></a></td>
    </tr>
  </table>
</blockquote>

## Variables
<blockquote>

### `cert_manager_version` (**Required**)
Version of the cert-manager Helm Chart to install

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L20"><code>variables.tf#L20</code></a>

</details>
</blockquote>
<blockquote>

### `cilium_version` (**Required**)
Cilium version

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L14"><code>variables.tf#L14</code></a>

</details>
</blockquote>
<blockquote>

### `cluster` (**Required**)
Cluster configuration

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    name              = string
    gateway           = string
    endpoint          = string
    lb_cidr           = string
    talos_factory_url = optional(string, "https://factory.talos.dev/")
  })
  ```
  In file: <a href="./variables.tf#L59"><code>variables.tf#L59</code></a>

</details>
</blockquote>
<blockquote>

### `external_dns_version` (**Required**)
Version of the external-dns Helm Chart to install

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L26"><code>variables.tf#L26</code></a>

</details>
</blockquote>
<blockquote>

### `local_path_provisioner_version` (**Required**)
Version of the local_path_provisioner Helm Chart to install

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L38"><code>variables.tf#L38</code></a>

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
    schematic    = optional(string)
    platform     = optional(string)
    arch         = optional(string)
    name         = string
    description  = optional(string)
    tags         = optional(list(string))
    host         = string
    machine_type = string
    bridge       = optional(string)
    ip           = string
    mac_address  = string
    vm_id        = number
    cpu          = number
    ram          = number
    datastore_id = optional(string)
    vfs_mappings = optional(list(string), [])
  }))
  ```
  In file: <a href="./variables.tf#L70"><code>variables.tf#L70</code></a>

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
  In file: <a href="./variables.tf#L45"><code>variables.tf#L45</code></a>

</details>
</blockquote>
<blockquote>

### `sealed_secrets_version` (**Required**)
Version of the sealed-secrets Helm Chart to install

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L32"><code>variables.tf#L32</code></a>

</details>
</blockquote>
<blockquote>

### `talos_linux_version` (**Required**)
Version of Talos (Linux/Kubernetes) to install

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L2"><code>variables.tf#L2</code></a>

</details>
</blockquote>
<blockquote>

### `target_kube_version` (**Required**)
Target version of Kubernetes the template is built for

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L8"><code>variables.tf#L8</code></a>

</details>
</blockquote>
<blockquote>

### `acme_contact` (*Optional*)
E-Mail address of the ACME account

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "admin@my.world"
  ```
  In file: <a href="./variables.tf#L165"><code>variables.tf#L165</code></a>

</details>
</blockquote>
<blockquote>

### `acme_server_directory_url` (*Optional*)
ACME server directory URL

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "https://192.168.178.155/acme/step-ca-acme/directory"
  ```
  In file: <a href="./variables.tf#L158"><code>variables.tf#L158</code></a>

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
  In file: <a href="./variables.tf#L173"><code>variables.tf#L173</code></a>

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
  In file: <a href="./variables.tf#L143"><code>variables.tf#L143</code></a>

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
  In file: <a href="./variables.tf#L122"><code>variables.tf#L122</code></a>

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
  In file: <a href="./variables.tf#L187"><code>variables.tf#L187</code></a>

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
  In file: <a href="./variables.tf#L180"><code>variables.tf#L180</code></a>

</details>
</blockquote>
<blockquote>

### `step_ca_host` (*Optional*)
Step CA IP or host, _*not*_ including the protocol (`https`).

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "192.168.178.155"
  ```
  In file: <a href="./variables.tf#L151"><code>variables.tf#L151</code></a>

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
  In file: <a href="./variables.tf#L129"><code>variables.tf#L129</code></a>

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
  In file: <a href="./variables.tf#L136"><code>variables.tf#L136</code></a>

</details>
</blockquote>


## Outputs
<blockquote>

#### `kube_config`
String containing the `kube-config.yaml`

In file: <a href="./outputs.tf#L26"><code>outputs.tf#L26</code></a>
</blockquote>
<blockquote>

#### `talos_config`
String containing the `talos-config.yaml`

In file: <a href="./outputs.tf#L20"><code>outputs.tf#L20</code></a>
</blockquote>