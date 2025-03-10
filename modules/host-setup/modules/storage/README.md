# Storage Management

Handles the import and export of ZFS pools as well as directories.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Inputs](#inputs)
  - [proxmox](#proxmox-required) (**Required**)
  - [ssh](#ssh-required) (**Required**)
  - [storage](#storage-required) (**Required**)
  - [token](#token-required) (**Required**)
- [Outputs](#outputs)
  - [resource](#resource)
    - [add_directory_storage](#add_directory_storage-restapi_object) (*restapi_object*)
    - [add_pool_storage](#add_pool_storage-restapi_object) (*restapi_object*)
    - [export_zfs_pools](#export_zfs_pools-ssh_resource) (*ssh_resource*)
    - [import_zfs_pools](#import_zfs_pools-ssh_resource) (*ssh_resource*)
  - [output](#output)
    - [storage_pools](#storage_pools)
    - [storage_pools_directories](#storage_pools_directories)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_restapi"></a> [restapi](#requirement\_restapi) | >= 1.20.0 |
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | ~> 2.7 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_restapi"></a> [restapi](#provider\_restapi) | >= 1.20.0 |
| <a name="provider_ssh"></a> [ssh](#provider\_ssh) | ~> 2.7 |

## Inputs
<blockquote>

### `proxmox` (**Required**)
Proxmox host configuration

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    object({
    name = string
    host = string
    port = number
  })
  ````
  Defined in file: `variables.tf#14`

</details>
</blockquote>
<blockquote>

### `ssh` (**Required**)
SSH configuration for remote connection

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    object({
    host    = string
    user    = string
    id_file = optional(string, "~/.ssh/id_rsa")
  })
  ````
  Defined in file: `variables.tf#1`

</details>
</blockquote>
<blockquote>

### `storage` (**Required**)
Configuration of the storage (pools and directories) to import

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    list(object({
    name = string
    type = string # "pool" or "directory"
    # For directories only:
    path          = optional(string)
    content_types = optional(list(string))
  }))
  ````
  Defined in file: `variables.tf#26`

</details>
</blockquote>
<blockquote>

### `token` (**Required**)
API token for the terraform user on the Proxmox host

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    string
  ````
  Defined in file: `variables.tf#66`

</details>
</blockquote>

## Outputs
### `resource`
<blockquote>

#### `add_directory_storage` (_restapi_object_)
Defined in file: `main.tf#71`
</blockquote>
<blockquote>

#### `add_pool_storage` (_restapi_object_)
Defined in file: `main.tf#53`
</blockquote>
<blockquote>

#### `export_zfs_pools` (_ssh_resource_)
Defined in file: `main.tf#39`
</blockquote>
<blockquote>

#### `import_zfs_pools` (_ssh_resource_)
Defined in file: `main.tf#26`
</blockquote>

### `output`
<blockquote>

#### `storage_pools`
List of storage pools that were imported and added to Proxmox
Defined in file: `outputs.tf#1`
</blockquote>
<blockquote>

#### `storage_pools_directories`
List of directories/datasets that were configured in Proxmox
Defined in file: `outputs.tf#11`
</blockquote>