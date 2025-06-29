# Talos create VM

Creates a Talos VM with a given ISO, type and other settings.

**Note:** have a look at the patches and Cilium CNI replacement.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [cilium_patch](#cilium_patch-local_file) (*local_file*)
  - [virtiofs_patch](#virtiofs_patch-local_file) (*local_file*)
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
  - [node_vfs_mappings](#node_vfs_mappings-required) (**Required**)
  - [node_vm_id](#node_vm_id-required) (**Required**)
  - [proxmox](#proxmox-required) (**Required**)
  - [talos_client_configuration](#talos_client_configuration-required) (**Required**)
  - [talos_linux_version](#talos_linux_version-required) (**Required**)
  - [talos_machine_secrets](#talos_machine_secrets-required) (**Required**)
  - [target_kube_version](#target_kube_version-required) (**Required**)
  - [cilium_chart](#cilium_chart-optional) (*Optional*)
  - [cilium_name](#cilium_name-optional) (*Optional*)
  - [cilium_namespace](#cilium_namespace-optional) (*Optional*)
  - [cilium_repository](#cilium_repository-optional) (*Optional*)
  - [cilium_timeout](#cilium_timeout-optional) (*Optional*)
  - [node_bridge](#node_bridge-optional) (*Optional*)
  - [node_datastore_id](#node_datastore_id-optional) (*Optional*)
  - [node_description](#node_description-optional) (*Optional*)
  - [node_tags](#node_tags-optional) (*Optional*)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm.templating"></a> [helm.templating](#provider\_helm.templating) | n/a |
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

#### `virtiofs_patch` (_local_file_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>local (hashicorp/local)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./virtiofs_mount.tf#L7"><code>virtiofs_mount.tf#L7</code></a></td>
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
  In file: <a href="./variables.tf#L127"><code>variables.tf#L127</code></a>

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
    name     = string
    gateway  = string
    endpoint = string
    lb_cidr  = string
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
  In file: <a href="./variables.tf#L100"><code>variables.tf#L100</code></a>

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
  In file: <a href="./variables.tf#L53"><code>variables.tf#L53</code></a>

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
  In file: <a href="./variables.tf#L75"><code>variables.tf#L75</code></a>

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
  In file: <a href="./variables.tf#L110"><code>variables.tf#L110</code></a>

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
  In file: <a href="./variables.tf#L85"><code>variables.tf#L85</code></a>

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
  In file: <a href="./variables.tf#L58"><code>variables.tf#L58</code></a>

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
  In file: <a href="./variables.tf#L48"><code>variables.tf#L48</code></a>

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
  In file: <a href="./variables.tf#L105"><code>variables.tf#L105</code></a>

</details>
</blockquote>
<blockquote>

### `node_vfs_mappings` (**Required**)
List of VirtioFS mapping names to attach to all VMs

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(string)
  ```
  In file: <a href="./variables.tf#L114"><code>variables.tf#L114</code></a>

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
  In file: <a href="./variables.tf#L95"><code>variables.tf#L95</code></a>

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
  In file: <a href="./variables.tf#L29"><code>variables.tf#L29</code></a>

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
  In file: <a href="./variables.tf#L167"><code>variables.tf#L167</code></a>

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
  In file: <a href="./variables.tf#L24"><code>variables.tf#L24</code></a>

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
  In file: <a href="./variables.tf#L173"><code>variables.tf#L173</code></a>

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
  In file: <a href="./variables.tf#L153"><code>variables.tf#L153</code></a>

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
  In file: <a href="./variables.tf#L132"><code>variables.tf#L132</code></a>

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
  In file: <a href="./variables.tf#L139"><code>variables.tf#L139</code></a>

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
  In file: <a href="./variables.tf#L146"><code>variables.tf#L146</code></a>

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
  In file: <a href="./variables.tf#L160"><code>variables.tf#L160</code></a>

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
  In file: <a href="./variables.tf#L68"><code>variables.tf#L68</code></a>

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
  In file: <a href="./variables.tf#L120"><code>variables.tf#L120</code></a>

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
  In file: <a href="./variables.tf#L34"><code>variables.tf#L34</code></a>

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
  In file: <a href="./variables.tf#L41"><code>variables.tf#L41</code></a>

</details>
</blockquote>
