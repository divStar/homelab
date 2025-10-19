# Storage Management

Handles the import and export of ZFS pools as well as directories.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Execution story](#execution-story)
- [Resources](#resources)
  - _ssh_resource_.[export_zfs_pools](#ssh_resourceexport_zfs_pools)
  - _ssh_resource_.[import_zfs_pools](#ssh_resourceimport_zfs_pools)
- [Variables](#variables)
  - [ssh](#ssh-required) (**Required**)
  - [storage_pools](#storage_pools-optional) (*Optional*)
- [Outputs](#outputs)
  - [storage_pools](#storage_pools)
</blockquote><!-- contents:end -->

## Requirements
  
![terraform](https://img.shields.io/badge/terraform->=1.8.0-d3287d?logo=terraform)
![ssh](https://img.shields.io/badge/ssh-~>2.7-4fa4f9?logo=ssh)

## Providers
  
![ssh](https://img.shields.io/badge/ssh-2.7.0-4fa4f9)

## Execution story

Order in which Terraform will create resources (and likely destroy them in reverse order):
```
├── ssh_resource.export_zfs_pools
├── ssh_resource.import_zfs_pools
```

## Resources
  
<blockquote><!-- resource:"ssh_resource.export_zfs_pools":start -->

### _ssh_resource_.`export_zfs_pools`

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
</blockquote><!-- resource:"ssh_resource.export_zfs_pools":end -->
<blockquote><!-- resource:"ssh_resource.import_zfs_pools":start -->

### _ssh_resource_.`import_zfs_pools`

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
</blockquote><!-- resource:"ssh_resource.import_zfs_pools":end -->

## Variables
  
<blockquote><!-- variable:"ssh":start -->

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
</blockquote><!-- variable:"ssh":end -->
<blockquote><!-- variable:"storage_pools":start -->

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
</blockquote><!-- variable:"storage_pools":end -->

## Outputs
  
<blockquote><!-- output:"storage_pools":start -->

#### `storage_pools`

List of storage pools that were imported

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote><!-- output:"storage_pools":end -->