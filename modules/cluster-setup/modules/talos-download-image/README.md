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
  - [talos_version](#talos_version-required) (**Required**)
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
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >= 0.69.0 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | >= 0.7.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.68.1 |
| <a name="provider_talos"></a> [talos](#provider\_talos) | 0.6.1 |


## Resources
<blockquote>

#### `this` (_proxmox_virtual_environment_download_file_)
In file: `main.tf#19`
</blockquote>
<blockquote>

#### `this` (_talos_image_factory_schematic_)
In file: `main.tf#15`
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
  In file: `variables.tf#1`

</details>
</blockquote>
<blockquote>

### `talos_version` (**Required**)
Talos version to use

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: `variables.tf#14`

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
  In file: `variables.tf#40`

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
  In file: `variables.tf#26`

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
  In file: `variables.tf#33`

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
  In file: `variables.tf#19`

</details>
</blockquote>


## Outputs
<blockquote>

#### `downloaded_iso_file_name`
The filename on the local node

In file: `outputs.tf#11`
</blockquote>
<blockquote>

#### `downloaded_iso_id`
The full ID on the local node

In file: `outputs.tf#16`
</blockquote>
<blockquote>

#### `installer`
The installer URL without http/https

In file: `outputs.tf#6`
</blockquote>
<blockquote>

#### `schematic_id`
The calculated ID of the schematic, that's being used

In file: `outputs.tf#1`
</blockquote>