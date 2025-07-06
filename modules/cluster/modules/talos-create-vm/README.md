# Talos create VM

Creates a Talos VM with a given ISO, type and other settings.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Execution story](#execution-story)
- [Resources](#resources)
  - _local_file_.[step_ca_root_pem_patch](#local_filestep_ca_root_pem_patch)
  - _local_file_.[virtiofs_patch](#local_filevirtiofs_patch)
  - _proxmox_virtual_environment_vm_.[this](#proxmox_virtual_environment_vmthis)
  - _talos_machine_configuration_apply_.[this](#talos_machine_configuration_applythis)
- [Variables](#variables)
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
  - [root_ca_certificate](#root_ca_certificate-required) (**Required**)
  - [talos_client_configuration](#talos_client_configuration-required) (**Required**)
  - [talos_linux_version](#talos_linux_version-required) (**Required**)
  - [talos_machine_secrets](#talos_machine_secrets-required) (**Required**)
  - [target_kube_version](#target_kube_version-required) (**Required**)
  - [node_bridge](#node_bridge-optional) (*Optional*)
  - [node_datastore_id](#node_datastore_id-optional) (*Optional*)
  - [node_description](#node_description-optional) (*Optional*)
  - [node_tags](#node_tags-optional) (*Optional*)
</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.3 |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.78.2 |
| <a name="provider_talos"></a> [talos](#provider\_talos) | 0.8.1 |

## Execution story

Order in which Terraform will create resources (and likely destroy them in reverse order):
```
├── proxmox_virtual_environment_vm.this
├── talos_machine_configuration_apply.this
```




## Resources
<blockquote>

#### _local_file_.`step_ca_root_pem_patch`

  <table>
    <tr>
      <td>Provider</td>
      <td><code>local (hashicorp/local)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./step_ca_root.tf#L7"><code>step_ca_root.tf#L7</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### _local_file_.`virtiofs_patch`

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

#### _proxmox_virtual_environment_vm_.`this`

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

#### _talos_machine_configuration_apply_.`this`

  <table>
    <tr>
      <td>Provider</td>
      <td><code>talos (siderolabs/talos)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L27"><code>main.tf#L27</code></a></td>
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
    name     = string
    gateway  = string
    endpoint = string
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
  In file: <a href="./variables.tf#L99"><code>variables.tf#L99</code></a>

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
  In file: <a href="./variables.tf#L52"><code>variables.tf#L52</code></a>

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
  In file: <a href="./variables.tf#L74"><code>variables.tf#L74</code></a>

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
  In file: <a href="./variables.tf#L109"><code>variables.tf#L109</code></a>

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
  In file: <a href="./variables.tf#L84"><code>variables.tf#L84</code></a>

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
  In file: <a href="./variables.tf#L57"><code>variables.tf#L57</code></a>

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
  In file: <a href="./variables.tf#L47"><code>variables.tf#L47</code></a>

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
  In file: <a href="./variables.tf#L104"><code>variables.tf#L104</code></a>

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
  In file: <a href="./variables.tf#L113"><code>variables.tf#L113</code></a>

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
  In file: <a href="./variables.tf#L94"><code>variables.tf#L94</code></a>

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

### `root_ca_certificate` (**Required**)
Step CA root CA certificate.

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L138"><code>variables.tf#L138</code></a>

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
  In file: <a href="./variables.tf#L28"><code>variables.tf#L28</code></a>

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
  In file: <a href="./variables.tf#L126"><code>variables.tf#L126</code></a>

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
  In file: <a href="./variables.tf#L23"><code>variables.tf#L23</code></a>

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
  In file: <a href="./variables.tf#L132"><code>variables.tf#L132</code></a>

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
  In file: <a href="./variables.tf#L67"><code>variables.tf#L67</code></a>

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
  In file: <a href="./variables.tf#L119"><code>variables.tf#L119</code></a>

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
  In file: <a href="./variables.tf#L33"><code>variables.tf#L33</code></a>

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
  In file: <a href="./variables.tf#L40"><code>variables.tf#L40</code></a>

</details>
</blockquote>
