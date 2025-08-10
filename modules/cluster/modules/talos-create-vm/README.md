# Talos create VM

Creates a Talos VM with a given ISO, type and other settings.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
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
  - [node_bridge](#node_bridge-optional) (*Optional*)
  - [node_datastore_id](#node_datastore_id-optional) (*Optional*)
  - [node_description](#node_description-optional) (*Optional*)
  - [node_iso_store_id](#node_iso_store_id-optional) (*Optional*)
  - [node_tags](#node_tags-optional) (*Optional*)
</blockquote><!-- contents:end -->

## Requirements
  
![terraform](https://img.shields.io/badge/terraform->=1.8.0-d3287d?logo=terraform)

## Providers
  
![local](https://img.shields.io/badge/local-2.5.3-0c61b6)
![proxmox](https://img.shields.io/badge/proxmox-0.78.2-1e73c8)
![talos](https://img.shields.io/badge/talos-0.8.1-2479ce)

## Resources
  
<blockquote><!-- resource:"local_file.step_ca_root_pem_patch":start -->

### _local_file_.`step_ca_root_pem_patch`

Renders the Step CA root certificate patch template
  <table>
    <tr>
      <td>Provider</td>
      <td><code>local (hashicorp/local)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L48"><code>main.tf#L48</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"local_file.step_ca_root_pem_patch":end -->
<blockquote><!-- resource:"local_file.virtiofs_patch":start -->

### _local_file_.`virtiofs_patch`

Renders the virtiofs patch template
  <table>
    <tr>
      <td>Provider</td>
      <td><code>local (hashicorp/local)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L37"><code>main.tf#L37</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"local_file.virtiofs_patch":end -->
<blockquote><!-- resource:"proxmox_virtual_environment_vm.this":start -->

### _proxmox_virtual_environment_vm_.`this`

Handles the creation of the VM
  <table>
    <tr>
      <td>Provider</td>
      <td><code>proxmox (bpg/proxmox)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L73"><code>main.tf#L73</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"proxmox_virtual_environment_vm.this":end -->
<blockquote><!-- resource:"talos_machine_configuration_apply.this":start -->

### _talos_machine_configuration_apply_.`this`

Applies the Talos machine configuration
  <table>
    <tr>
      <td>Provider</td>
      <td><code>talos (siderolabs/talos)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L59"><code>main.tf#L59</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"talos_machine_configuration_apply.this":end -->

## Variables
  
<blockquote><!-- variable:"cluster":start -->

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
</blockquote><!-- variable:"cluster":end -->
<blockquote><!-- variable:"node_cpu":start -->

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
</blockquote><!-- variable:"node_cpu":end -->
<blockquote><!-- variable:"node_host":start -->

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
</blockquote><!-- variable:"node_host":end -->
<blockquote><!-- variable:"node_ip":start -->

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
</blockquote><!-- variable:"node_ip":end -->
<blockquote><!-- variable:"node_iso":start -->

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
</blockquote><!-- variable:"node_iso":end -->
<blockquote><!-- variable:"node_mac_address":start -->

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
</blockquote><!-- variable:"node_mac_address":end -->
<blockquote><!-- variable:"node_machine_type":start -->

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
</blockquote><!-- variable:"node_machine_type":end -->
<blockquote><!-- variable:"node_name":start -->

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
</blockquote><!-- variable:"node_name":end -->
<blockquote><!-- variable:"node_ram":start -->

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
</blockquote><!-- variable:"node_ram":end -->
<blockquote><!-- variable:"node_vfs_mappings":start -->

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
</blockquote><!-- variable:"node_vfs_mappings":end -->
<blockquote><!-- variable:"node_vm_id":start -->

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
</blockquote><!-- variable:"node_vm_id":end -->
<blockquote><!-- variable:"proxmox":start -->

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
</blockquote><!-- variable:"proxmox":end -->
<blockquote><!-- variable:"root_ca_certificate":start -->

### `root_ca_certificate` (**Required**)

Step CA root CA certificate.

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L139"><code>variables.tf#L139</code></a>

</details>
</blockquote><!-- variable:"root_ca_certificate":end -->
<blockquote><!-- variable:"talos_client_configuration":start -->

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
</blockquote><!-- variable:"talos_client_configuration":end -->
<blockquote><!-- variable:"talos_linux_version":start -->

### `talos_linux_version` (**Required**)

Version of Talos (Linux/Kubernetes) to install

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L133"><code>variables.tf#L133</code></a>

</details>
</blockquote><!-- variable:"talos_linux_version":end -->
<blockquote><!-- variable:"talos_machine_secrets":start -->

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
</blockquote><!-- variable:"talos_machine_secrets":end -->
<blockquote><!-- variable:"node_bridge":start -->

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
</blockquote><!-- variable:"node_bridge":end -->
<blockquote><!-- variable:"node_datastore_id":start -->

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
</blockquote><!-- variable:"node_datastore_id":end -->
<blockquote><!-- variable:"node_description":start -->

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
</blockquote><!-- variable:"node_description":end -->
<blockquote><!-- variable:"node_iso_store_id":start -->

### `node_iso_store_id` (*Optional*)

Datastore ID for the ISO file

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
  In file: <a href="./variables.tf#L126"><code>variables.tf#L126</code></a>

</details>
</blockquote><!-- variable:"node_iso_store_id":end -->
<blockquote><!-- variable:"node_tags":start -->

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
</blockquote><!-- variable:"node_tags":end -->