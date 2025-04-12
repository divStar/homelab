# Talos create VM

Creates a Talos VM with a given ISO, type and other settings.

**Note:** have a look at the patches and Cilium CNI replacement.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [cilium_patch](#cilium_patch-local_file) (*local_file*)
  - [this](#this-proxmox_virtual_environment_vm) (*proxmox_virtual_environment_vm*)
  - [this](#this-talos_machine_configuration_apply) (*talos_machine_configuration_apply*)
- [Variables](#variables)
  - [cilium_version](#cilium_version-required) (**Required**)
  - [cluster](#cluster-required) (**Required**)
  - [node_cpu](#node_cpu-required) (**Required**)
  - [node_host](#node_host-required) (**Required**)
  - [node_ip](#node_ip-required) (**Required**)
  - [node_iso](#node_iso-required) (**Required**)
  - [node_mac_address](#node_mac_address-required) (**Required**)
  - [node_machine_type](#node_machine_type-required) (**Required**)
  - [node_name](#node_name-required) (**Required**)
  - [node_ram](#node_ram-required) (**Required**)
  - [node_vm_id](#node_vm_id-required) (**Required**)
  - [proxmox](#proxmox-required) (**Required**)
  - [talos_client_configuration](#talos_client_configuration-required) (**Required**)
  - [talos_machine_secrets](#talos_machine_secrets-required) (**Required**)
  - [cilium_chart](#cilium_chart-optional) (*Optional*)
  - [cilium_name](#cilium_name-optional) (*Optional*)
  - [cilium_namespace](#cilium_namespace-optional) (*Optional*)
  - [cilium_repository](#cilium_repository-optional) (*Optional*)
  - [cilium_timeout](#cilium_timeout-optional) (*Optional*)
  - [node_bridge](#node_bridge-optional) (*Optional*)
  - [node_datastore_id](#node_datastore_id-optional) (*Optional*)
  - [node_description](#node_description-optional) (*Optional*)
  - [node_tags](#node_tags-optional) (*Optional*)
  - [target_kube_version](#target_kube_version-optional) (*Optional*)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.17.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >= 0.69.0 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | >= 0.7.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm.templating"></a> [helm.templating](#provider\_helm.templating) | >= 2.17.0 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.68.1 |
| <a name="provider_talos"></a> [talos](#provider\_talos) | 0.6.1 |


## Resources
<blockquote>

#### `cilium_patch` (_local_file_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>local (hashicorp/local)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./cilium.tf#L30"><code>cilium.tf#L30</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `this` (_proxmox_virtual_environment_vm_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>proxmox (bpg/proxmox)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./vms.tf#L1"><code>vms.tf#L1</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `this` (_talos_machine_configuration_apply_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>talos (siderolabs/talos)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L28"><code>main.tf#L28</code></a></td>
    </tr>
  </table>
</blockquote>

## Variables
<blockquote>

### `cilium_version` (**Required**)
Cilium version

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L122"><code>variables.tf#L122</code></a>

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
    name          = string
    gateway       = string
    talos_version = string
    endpoint      = string
    lb_cidr       = string
  })
  ```
  In file: <a href="./variables.tf#L14"><code>variables.tf#L14</code></a>

</details>
</blockquote>
<blockquote>

### `node_cpu` (**Required**)
Number of CPUs for the node

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  number
  ```
  In file: <a href="./variables.tf#L101"><code>variables.tf#L101</code></a>

</details>
</blockquote>
<blockquote>

### `node_host` (**Required**)
Host node for the cluster

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L54"><code>variables.tf#L54</code></a>

</details>
</blockquote>
<blockquote>

### `node_ip` (**Required**)
IP address of the node

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L76"><code>variables.tf#L76</code></a>

</details>
</blockquote>
<blockquote>

### `node_iso` (**Required**)
The path to the Talos node ISO, that is supposed to be used

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  any
  ```
  In file: <a href="./variables.tf#L111"><code>variables.tf#L111</code></a>

</details>
</blockquote>
<blockquote>

### `node_mac_address` (**Required**)
MAC address of the node

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L86"><code>variables.tf#L86</code></a>

</details>
</blockquote>
<blockquote>

### `node_machine_type` (**Required**)
Type of machine (controlplane or worker)

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L59"><code>variables.tf#L59</code></a>

</details>
</blockquote>
<blockquote>

### `node_name` (**Required**)
Name of the cluster node

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L49"><code>variables.tf#L49</code></a>

</details>
</blockquote>
<blockquote>

### `node_ram` (**Required**)
Dedicated RAM for the node

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  number
  ```
  In file: <a href="./variables.tf#L106"><code>variables.tf#L106</code></a>

</details>
</blockquote>
<blockquote>

### `node_vm_id` (**Required**)
VM ID of the node

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  number
  ```
  In file: <a href="./variables.tf#L96"><code>variables.tf#L96</code></a>

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

### `talos_client_configuration` (**Required**)
Talos cluster client configuration

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  any
  ```
  In file: <a href="./variables.tf#L30"><code>variables.tf#L30</code></a>

</details>
</blockquote>
<blockquote>

### `talos_machine_secrets` (**Required**)
Talos cluster machine configuration

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  any
  ```
  In file: <a href="./variables.tf#L25"><code>variables.tf#L25</code></a>

</details>
</blockquote>
<blockquote>

### `cilium_chart` (*Optional*)
Name of the Cilium Helm Chart to use

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "cilium"
  ```
  In file: <a href="./variables.tf#L148"><code>variables.tf#L148</code></a>

</details>
</blockquote>
<blockquote>

### `cilium_name` (*Optional*)
Name of the Cilium Helm release

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "cilium"
  ```
  In file: <a href="./variables.tf#L127"><code>variables.tf#L127</code></a>

</details>
</blockquote>
<blockquote>

### `cilium_namespace` (*Optional*)
Namespace to install Cilium into

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "cilium"
  ```
  In file: <a href="./variables.tf#L134"><code>variables.tf#L134</code></a>

</details>
</blockquote>
<blockquote>

### `cilium_repository` (*Optional*)
URL of the Cilium Helm repository to use

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "https://helm.cilium.io"
  ```
  In file: <a href="./variables.tf#L141"><code>variables.tf#L141</code></a>

</details>
</blockquote>
<blockquote>

### `cilium_timeout` (*Optional*)
Cilium Helm template creation timeout

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  number
  ```
  **Default**:
  ```json
  60
  ```
  In file: <a href="./variables.tf#L155"><code>variables.tf#L155</code></a>

</details>
</blockquote>
<blockquote>

### `node_bridge` (*Optional*)
Network bridge to use for this node

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "vmbr0"
  ```
  In file: <a href="./variables.tf#L69"><code>variables.tf#L69</code></a>

</details>
</blockquote>
<blockquote>

### `node_datastore_id` (*Optional*)
Datastore ID for the node

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "local"
  ```
  In file: <a href="./variables.tf#L115"><code>variables.tf#L115</code></a>

</details>
</blockquote>
<blockquote>

### `node_description` (*Optional*)
Description to set for the given node

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  ""
  ```
  In file: <a href="./variables.tf#L35"><code>variables.tf#L35</code></a>

</details>
</blockquote>
<blockquote>

### `node_tags` (*Optional*)
Tags to set for the given node

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(string)
  ```
  **Default**:
  ```json
  []
  ```
  In file: <a href="./variables.tf#L42"><code>variables.tf#L42</code></a>

</details>
</blockquote>
<blockquote>

### `target_kube_version` (*Optional*)
Target version of Kubernetes the template is built for

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "1.32"
  ```
  In file: <a href="./variables.tf#L162"><code>variables.tf#L162</code></a>

</details>
</blockquote>
