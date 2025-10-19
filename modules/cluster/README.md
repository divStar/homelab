# Cluster Setup

This module and its sub-modules setup the Talos cluster on the Proxmox host.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules) _(nested and adjacent)_
  - [infrastructure](#infrastructure)
  - [platform](#platform)
  - [talos_cluster_prepare](#talos_cluster_prepare)
  - [talos_cluster_ready](#talos_cluster_ready)
  - [talos_images](#talos_images)
  - [talos_vms](#talos_vms)
- [Resources](#resources)
  - _local_file_.[kube_config](#local_filekube_config)
  - _local_file_.[machine_configs](#local_filemachine_configs)
  - _local_file_.[talos_config](#local_filetalos_config)
- [Variables](#variables)
  - [cluster](#cluster-required) (**Required**)
  - [nodes](#nodes-required) (**Required**)
  - [proxmox](#proxmox-required) (**Required**)
  - [kube_config_file](#kube_config_file-optional) (*Optional*)
  - [step_ca_host](#step_ca_host-optional) (*Optional*)
  - [talos_config_file](#talos_config_file-optional) (*Optional*)
  - [talos_machine_config_file](#talos_machine_config_file-optional) (*Optional*)
  - [versions_yaml](#versions_yaml-optional) (*Optional*)
- [Outputs](#outputs)
  - [kube_config](#kube_config)
  - [talos_config](#talos_config)
  - [zitadel_pat](#zitadel_pat)
</blockquote><!-- contents:end -->

## Requirements
![opentofu](https://img.shields.io/badge/OpenTofu->=1.10.5-d3287d?logo=opentofu)
![helm](https://img.shields.io/badge/helm-3.0.2-a7fc51?logo=helm)
![kubectl](https://img.shields.io/badge/kubectl-2.1.3-eb4095?logo=kubectl)
![kubernetes](https://img.shields.io/badge/kubernetes-2.38.0-398ee3?logo=kubernetes)
![proxmox](https://img.shields.io/badge/proxmox-0.83.2-1e73c8?logo=proxmox)
![talos](https://img.shields.io/badge/talos-0.9.0-2479ce?logo=talos)
![zitactl](https://img.shields.io/badge/zitactl-1.0.0-fc51a6?logo=zitactl)

## Providers
  
![http](https://img.shields.io/badge/http-3.5.0-c1166b)
![local](https://img.shields.io/badge/local-2.5.3-0c61b6)

## Modules
  
<blockquote><!-- module:"infrastructure":start -->

### `infrastructure`

Handles the set up of the most basic infrastructure (CNI, ingress, certificates, etc.).
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/infrastructure</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L112"><code>main.tf#L112</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/infrastructure/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"infrastructure":end -->
<blockquote><!-- module:"platform":start -->

### `platform`

Handles the set up of platform services and functionality (CNPG operator, pgAdmin, Zitadel, etc.).
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/platform</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L125"><code>main.tf#L125</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/platform/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"platform":end -->
<blockquote><!-- module:"talos_cluster_prepare":start -->

### `talos_cluster_prepare`

Prepares the cluster creation by generating the **Talos machine secrets** and creating the **Talos client cluster configuration**.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/talos-prepare-cluster</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L44"><code>main.tf#L44</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/talos-prepare-cluster/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"talos_cluster_prepare":end -->
<blockquote><!-- module:"talos_cluster_ready":start -->

### `talos_cluster_ready`

Awaits the Talos cluster to become ready and available. <p>This module returns once all Talos [`nodes`](#nodes-required) are up and running.</p> <p><strong>Note:</strong> since the cluster is starting up without a CNI (Flannel is disabled), <strong>Kubernetes checks are skipped</strong>.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/talos-await-cluster</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L91"><code>main.tf#L91</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/talos-await-cluster/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"talos_cluster_ready":end -->
<blockquote><!-- module:"talos_images":start -->

### `talos_images`

Downloads the calculated Talos images specified in the [`nodes`](#nodes-required) configurations.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/talos-download-image</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L29"><code>main.tf#L29</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/talos-download-image/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"talos_images":end -->
<blockquote><!-- module:"talos_vms":start -->

### `talos_vms`

Creates the given Talos VMs, uses `for_each` on the list of [`nodes`](#nodes-required).
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/talos-create-vm</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L58"><code>main.tf#L58</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/talos-create-vm/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"talos_vms":end -->

## Resources
  
<blockquote><!-- resource:"local_file.kube_config":start -->

### _local_file_.`kube_config`
      
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
</blockquote><!-- resource:"local_file.kube_config":end -->
<blockquote><!-- resource:"local_file.machine_configs":start -->

### _local_file_.`machine_configs`
      
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
</blockquote><!-- resource:"local_file.machine_configs":end -->
<blockquote><!-- resource:"local_file.talos_config":start -->

### _local_file_.`talos_config`
      
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
</blockquote><!-- resource:"local_file.talos_config":end -->

## Variables
  
<blockquote><!-- variable:"cluster":start -->

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
    domain            = string
    talos_factory_url = optional(string, "https://factory.talos.dev/")
  })
  ```
  In file: <a href="./variables.tf#L23"><code>variables.tf#L23</code></a>

</details>
</blockquote><!-- variable:"cluster":end -->
<blockquote><!-- variable:"nodes":start -->

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
    iso_store_id = optional(string)
    vfs_mappings = optional(list(string), [])
  }))
  ```
  In file: <a href="./variables.tf#L35"><code>variables.tf#L35</code></a>

</details>
</blockquote><!-- variable:"nodes":end -->
<blockquote><!-- variable:"proxmox":start -->

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
  In file: <a href="./variables.tf#L9"><code>variables.tf#L9</code></a>

</details>
</blockquote><!-- variable:"proxmox":end -->
<blockquote><!-- variable:"kube_config_file":start -->

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
  In file: <a href="./variables.tf#L88"><code>variables.tf#L88</code></a>

</details>
</blockquote><!-- variable:"kube_config_file":end -->
<blockquote><!-- variable:"step_ca_host":start -->

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
  In file: <a href="./variables.tf#L109"><code>variables.tf#L109</code></a>

</details>
</blockquote><!-- variable:"step_ca_host":end -->
<blockquote><!-- variable:"talos_config_file":start -->

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
  In file: <a href="./variables.tf#L95"><code>variables.tf#L95</code></a>

</details>
</blockquote><!-- variable:"talos_config_file":end -->
<blockquote><!-- variable:"talos_machine_config_file":start -->

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
  In file: <a href="./variables.tf#L102"><code>variables.tf#L102</code></a>

</details>
</blockquote><!-- variable:"talos_machine_config_file":end -->
<blockquote><!-- variable:"versions_yaml":start -->

### `versions_yaml` (*Optional*)

Absolute path and filename to the `versions.yaml` file, that contains all relevant Helm Chart descriptions and versions

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "../../versions.yaml"
  ```
  In file: <a href="./variables.tf#L1"><code>variables.tf#L1</code></a>

</details>
</blockquote><!-- variable:"versions_yaml":end -->

## Outputs
  
<blockquote><!-- output:"kube_config":start -->

#### `kube_config`

String containing the `kube-config.yaml`

In file: <a href="./outputs.tf#L26"><code>outputs.tf#L26</code></a>
</blockquote><!-- output:"kube_config":end -->
<blockquote><!-- output:"talos_config":start -->

#### `talos_config`

String containing the `talos-config.yaml`

In file: <a href="./outputs.tf#L20"><code>outputs.tf#L20</code></a>
</blockquote><!-- output:"talos_config":end -->
<blockquote><!-- output:"zitadel_pat":start -->

#### `zitadel_pat`

Key of the Zitadel Admin Service Account

In file: <a href="./outputs.tf#L32"><code>outputs.tf#L32</code></a>
</blockquote><!-- output:"zitadel_pat":end -->