# Package Management

Handles the installation and removal of packages on the host

Note: `ssh_resource` and CLI is used, because `apt-get install`
and `apt-get remove` are not yet supported by Proxmox API.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Inputs](#inputs)
  - [ssh](#ssh-required) (**Required**)
  - [packages](#packages-optional) (*Optional*)
- [Outputs](#outputs)
  - [resource](#resource)
    - [package_install](#package_install-ssh_resource) (*ssh_resource*)
    - [package_remove](#package_remove-ssh_resource) (*ssh_resource*)
  - [output](#output)
    - [installed_packages](#installed_packages)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | ~> 2.7 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_ssh"></a> [ssh](#provider\_ssh) | ~> 2.7 |

## Inputs
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
  Defined in file: `variables.tf#1`

</details>
</blockquote>
<blockquote>

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
  Defined in file: `variables.tf#14`

</details>
</blockquote>

## Outputs
### `resource`
<blockquote>

#### `package_install` (_ssh_resource_)
Defined in file: `main.tf#21`
</blockquote>
<blockquote>

#### `package_remove` (_ssh_resource_)
Defined in file: `main.tf#32`
</blockquote>

### `output`
<blockquote>

#### `installed_packages`
The packages, that have been installed/removed

Defined in file: `outputs.tf#1`
</blockquote>