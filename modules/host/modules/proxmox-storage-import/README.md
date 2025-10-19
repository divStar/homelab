# Proxmox storage import

Imports existing storage into Proxmox.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - _ssh_resource_.[import_proxmox_storage](#ssh_resourceimport_proxmox_storage)
  - _ssh_resource_.[remove_proxmox_storage](#ssh_resourceremove_proxmox_storage)
- [Variables](#variables)
  - [ssh](#ssh-required) (**Required**)
  - [storage_directories](#storage_directories-required) (**Required**)
- [Outputs](#outputs)
  - [configured_storages](#configured_storages)
  - [storage_details](#storage_details)
</blockquote><!-- contents:end -->

## Requirements
![opentofu](https://img.shields.io/badge/OpenTofu->=1.10.5-d3287d?logo=opentofu)

## Providers
  
![ssh](https://img.shields.io/badge/ssh--4fa4f9)

## Resources
  
<blockquote><!-- resource:"ssh_resource.import_proxmox_storage":start -->

### _ssh_resource_.`import_proxmox_storage`

Imports a directory with given types into Proxmox
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
</blockquote><!-- resource:"ssh_resource.import_proxmox_storage":end -->
<blockquote><!-- resource:"ssh_resource.remove_proxmox_storage":start -->

### _ssh_resource_.`remove_proxmox_storage`

Removes a directory from Proxmox
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L33"><code>main.tf#L33</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"ssh_resource.remove_proxmox_storage":end -->

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
<blockquote><!-- variable:"storage_directories":start -->

### `storage_directories` (**Required**)

Map of storage directories to configure; the key is the name of the directory.

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  map(object({
    path    = string
    content = string
  }))
  ```
  In file: <a href="./variables.tf#L14"><code>variables.tf#L14</code></a>

</details>
</blockquote><!-- variable:"storage_directories":end -->

## Outputs
  
<blockquote><!-- output:"configured_storages":start -->

#### `configured_storages`

List of configured storage names

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote><!-- output:"configured_storages":end -->
<blockquote><!-- output:"storage_details":start -->

#### `storage_details`

Full storage configuration details

In file: <a href="./outputs.tf#L6"><code>outputs.tf#L6</code></a>
</blockquote><!-- output:"storage_details":end -->