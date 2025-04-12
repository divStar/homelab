# Storage Management

Handles the import and export of ZFS pools as well as directories.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [add_directory_storage](#add_directory_storage-restapi_object) (*restapi_object*)
  - [add_pool_storage](#add_pool_storage-restapi_object) (*restapi_object*)
  - [export_zfs_pools](#export_zfs_pools-ssh_resource) (*ssh_resource*)
  - [import_zfs_pools](#import_zfs_pools-ssh_resource) (*ssh_resource*)
- [Variables](#variables)
  - [proxmox](#proxmox-required) (**Required**)
  - [ssh](#ssh-required) (**Required**)
  - [storage](#storage-required) (**Required**)
  - [token](#token-required) (**Required**)
- [Outputs](#outputs)
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


## Resources
<blockquote>

#### `add_directory_storage` (_restapi_object_)
Add directories to Proxmox UI resource will be removed using DELETE RESTAPI call upon being destroyed
  <table>
    <tr>
      <td>Provider</td>
      <td><code>restapi (Mastercard/restapi)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L71"><code>main.tf#L71</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `add_pool_storage` (_restapi_object_)
Add pools to Proxmox UI; resource will be removed using DELETE RESTAPI call upon being destroyed
  <table>
    <tr>
      <td>Provider</td>
      <td><code>restapi (Mastercard/restapi)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L53"><code>main.tf#L53</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `export_zfs_pools` (_ssh_resource_)
Export ZFS pools
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L39"><code>main.tf#L39</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `import_zfs_pools` (_ssh_resource_)
Import ZFS pools
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L26"><code>main.tf#L26</code></a></td>
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
    name = string
    host = string
    port = number
  })
  ```
  In file: <a href="./variables.tf#L14"><code>variables.tf#L14</code></a>

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
  ```
  In file: <a href="./variables.tf#L1"><code>variables.tf#L1</code></a>

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
  ```
  In file: <a href="./variables.tf#L26"><code>variables.tf#L26</code></a>

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
  ```
  In file: <a href="./variables.tf#L66"><code>variables.tf#L66</code></a>

</details>
</blockquote>


## Outputs
<blockquote>

#### `storage_pools`
List of storage pools that were imported and added to Proxmox

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote>
<blockquote>

#### `storage_pools_directories`
List of directories/datasets that were configured in Proxmox

In file: <a href="./outputs.tf#L11"><code>outputs.tf#L11</code></a>
</blockquote>