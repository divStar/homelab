# Storage Management

Handles the import and export of ZFS pools as well as directories.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [export_zfs_pools](#export_zfs_pools-ssh_resource) (*ssh_resource*)
  - [import_zfs_pools](#import_zfs_pools-ssh_resource) (*ssh_resource*)
- [Variables](#variables)
  - [ssh](#ssh-required) (**Required**)
  - [storage_pools](#storage_pools-optional) (*Optional*)
- [Outputs](#outputs)
  - [storage_pools](#storage_pools)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | ~> 2.7 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_ssh"></a> [ssh](#provider\_ssh) | ~> 2.7 |


## Resources
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
      <td><a href="./main.tf#L29"><code>main.tf#L29</code></a></td>
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
      <td><a href="./main.tf#L16"><code>main.tf#L16</code></a></td>
    </tr>
  </table>
</blockquote>

## Variables
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

### `storage_pools` (*Optional*)
Configuration of the storage (pools and directories) to import

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
  In file: <a href="./variables.tf#L14"><code>variables.tf#L14</code></a>

</details>
</blockquote>


## Outputs
<blockquote>

#### `storage_pools`
List of storage pools that were imported

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote>