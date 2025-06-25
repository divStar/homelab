# Download Talos image

Handles the download of Talos images based on the version,
architecture, platform and schematics.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [this](#this-proxmox_virtual_environment_download_file) (*proxmox_virtual_environment_download_file*)
  - [this](#this-talos_image_factory_schematic) (*talos_image_factory_schematic*)
- [Variables](#variables)
  - [proxmox](#proxmox-required) (**Required**)
  - [talos_linux_version](#talos_linux_version-required) (**Required**)
  - [arch](#arch-optional) (*Optional*)
  - [factory_url](#factory_url-optional) (*Optional*)
  - [platform](#platform-optional) (*Optional*)
  - [schematic](#schematic-optional) (*Optional*)
- [Outputs](#outputs)
  - [downloaded_iso_file_name](#downloaded_iso_file_name)
  - [downloaded_iso_id](#downloaded_iso_id)
  - [installer](#installer)
  - [schematic_id](#schematic_id)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.68.1 |
| <a name="provider_talos"></a> [talos](#provider\_talos) | 0.6.1 |


## Resources
<blockquote>

#### `this` (_proxmox_virtual_environment_download_file_)

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
</blockquote>
<blockquote>

#### `this` (_talos_image_factory_schematic_)

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
</blockquote>

## Variables
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
    ssh_user  = string # not used in talos_image
    ssh_key   = string # not used in talos_image
  })
  ```
  In file: <a href="./variables.tf#L1"><code>variables.tf#L1</code></a>

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
  In file: <a href="./variables.tf#L14"><code>variables.tf#L14</code></a>

</details>
</blockquote>
<blockquote>

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
  In file: <a href="./variables.tf#L41"><code>variables.tf#L41</code></a>

</details>
</blockquote>
<blockquote>

### `factory_url` (*Optional*)
URL of the Talos image factory

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "https://factory.talos.dev"
  ```
  In file: <a href="./variables.tf#L27"><code>variables.tf#L27</code></a>

</details>
</blockquote>
<blockquote>

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
  In file: <a href="./variables.tf#L34"><code>variables.tf#L34</code></a>

</details>
</blockquote>
<blockquote>

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
</blockquote>


## Outputs
<blockquote>

#### `downloaded_iso_file_name`
The filename on the local node

In file: <a href="./outputs.tf#L11"><code>outputs.tf#L11</code></a>
</blockquote>
<blockquote>

#### `downloaded_iso_id`
The full ID on the local node

In file: <a href="./outputs.tf#L16"><code>outputs.tf#L16</code></a>
</blockquote>
<blockquote>

#### `installer`
The installer URL without http/https

In file: <a href="./outputs.tf#L6"><code>outputs.tf#L6</code></a>
</blockquote>
<blockquote>

#### `schematic_id`
The calculated ID of the schematic, that's being used

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote>