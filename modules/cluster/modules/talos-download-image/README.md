# Download Talos image

Handles the download of Talos images based on the version,
architecture, platform and schematics.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Execution story](#execution-story)
- [Resources](#resources)
  - _proxmox_virtual_environment_download_file_.[this](#proxmox_virtual_environment_download_filethis)
  - _talos_image_factory_schematic_.[this](#talos_image_factory_schematicthis)
- [Variables](#variables)
  - [proxmox](#proxmox-required) (**Required**)
  - [talos_linux_version](#talos_linux_version-required) (**Required**)
  - [arch](#arch-optional) (*Optional*)
  - [platform](#platform-optional) (*Optional*)
  - [schematic](#schematic-optional) (*Optional*)
- [Outputs](#outputs)
  - [downloaded_iso_file_name](#downloaded_iso_file_name)
  - [downloaded_iso_id](#downloaded_iso_id)
  - [installer](#installer)
  - [schematic_id](#schematic_id)
</blockquote><!-- contents:end -->

## Requirements
  
![terraform](https://img.shields.io/badge/terraform->=1.8.0-d3287d?logo=terraform)

## Providers
  
![proxmox](https://img.shields.io/badge/proxmox-0.68.1-1e73c8)
![talos](https://img.shields.io/badge/talos-0.6.1-2479ce)

## Execution story

Order in which Terraform will create resources (and likely destroy them in reverse order):
```
├── talos_image_factory_schematic.this
├── proxmox_virtual_environment_download_file.this
```

## Resources
  
<blockquote><!-- resource:"proxmox_virtual_environment_download_file.this":start -->

### _proxmox_virtual_environment_download_file_.`this`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>proxmox (bpg/proxmox)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L20"><code>main.tf#L20</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"proxmox_virtual_environment_download_file.this":end -->
<blockquote><!-- resource:"talos_image_factory_schematic.this":start -->

### _talos_image_factory_schematic_.`this`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>talos (siderolabs/talos)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L16"><code>main.tf#L16</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"talos_image_factory_schematic.this":end -->

## Variables
  
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
    ssh_user  = string # not used in talos_image
    ssh_key   = string # not used in talos_image
  })
  ```
  In file: <a href="./variables.tf#L1"><code>variables.tf#L1</code></a>

</details>
</blockquote><!-- variable:"proxmox":end -->
<blockquote><!-- variable:"talos_linux_version":start -->

### `talos_linux_version` (**Required**)

Version of Talos (Linux/Kubernetes) to install

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L14"><code>variables.tf#L14</code></a>

</details>
</blockquote><!-- variable:"talos_linux_version":end -->
<blockquote><!-- variable:"arch":start -->

### `arch` (*Optional*)

Architecture to use (amd64 or arm64)

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "amd64"
  ```
  In file: <a href="./variables.tf#L34"><code>variables.tf#L34</code></a>

</details>
</blockquote><!-- variable:"arch":end -->
<blockquote><!-- variable:"platform":start -->

### `platform` (*Optional*)

Platform to use (e.g. metal, nocloud, aws, etc., see https://registry.terraform.io/providers/siderolabs/talos/latest/docs/data-sources/image_factory_urls#platform-8)

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "nocloud"
  ```
  In file: <a href="./variables.tf#L27"><code>variables.tf#L27</code></a>

</details>
</blockquote><!-- variable:"platform":end -->
<blockquote><!-- variable:"schematic":start -->

### `schematic` (*Optional*)

Schematic configuration as YAML string

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "schematic/default.yaml"
  ```
  In file: <a href="./variables.tf#L20"><code>variables.tf#L20</code></a>

</details>
</blockquote><!-- variable:"schematic":end -->

## Outputs
  
<blockquote><!-- output:"downloaded_iso_file_name":start -->

#### `downloaded_iso_file_name`

The filename on the local node

In file: <a href="./outputs.tf#L11"><code>outputs.tf#L11</code></a>
</blockquote><!-- output:"downloaded_iso_file_name":end -->
<blockquote><!-- output:"downloaded_iso_id":start -->

#### `downloaded_iso_id`

The full ID on the local node

In file: <a href="./outputs.tf#L16"><code>outputs.tf#L16</code></a>
</blockquote><!-- output:"downloaded_iso_id":end -->
<blockquote><!-- output:"installer":start -->

#### `installer`

The installer URL without http/https

In file: <a href="./outputs.tf#L6"><code>outputs.tf#L6</code></a>
</blockquote><!-- output:"installer":end -->
<blockquote><!-- output:"schematic_id":start -->

#### `schematic_id`

The calculated ID of the schematic, that's being used

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote><!-- output:"schematic_id":end -->