# Package Management

Handles the installation and removal of packages on the host

Note: `ssh_resource` and CLI is used, because `apt-get install`
and `apt-get remove` are not yet supported by Proxmox API.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Execution story](#execution-story)
- [Resources](#resources)
  - _ssh_resource_.[package_install](#ssh_resourcepackage_install)
  - _ssh_resource_.[package_remove](#ssh_resourcepackage_remove)
- [Variables](#variables)
  - [ssh](#ssh-required) (**Required**)
  - [packages](#packages-optional) (*Optional*)
- [Outputs](#outputs)
  - [installed_packages](#installed_packages)
</blockquote><!-- contents:end -->

## Requirements
  
![terraform](https://img.shields.io/badge/terraform->=1.8.0-d3287d?logo=terraform)

## Providers
  
![ssh](https://img.shields.io/badge/ssh-2.7.0-4fa4f9)

## Execution story

Order in which Terraform will create resources (and likely destroy them in reverse order):
```
├── ssh_resource.package_install
├── ssh_resource.package_remove
```

## Resources
  
<blockquote><!-- resource:"ssh_resource.package_install":start -->

### _ssh_resource_.`package_install`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L21"><code>main.tf#L21</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"ssh_resource.package_install":end -->
<blockquote><!-- resource:"ssh_resource.package_remove":start -->

### _ssh_resource_.`package_remove`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L32"><code>main.tf#L32</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"ssh_resource.package_remove":end -->

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
<blockquote><!-- variable:"packages":start -->

### `packages` (*Optional*)

List of packages to install via apt-get

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
</blockquote><!-- variable:"packages":end -->

## Outputs
  
<blockquote><!-- output:"installed_packages":start -->

#### `installed_packages`

The packages, that have been installed/removed

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote><!-- output:"installed_packages":end -->