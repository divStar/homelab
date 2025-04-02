# Repository Management

Handles the deactivation of the enterprise repositories and
the creation and activation of the no-subscription repositories.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Inputs](#inputs)
  - [ssh](#ssh-required) (**Required**)
  - [no_subscription](#no_subscription-optional) (*Optional*)
- [Outputs](#outputs)
  - [resource](#resource)
    - [add_no_sub_repository](#add_no_sub_repository-ssh_resource) (*ssh_resource*)
    - [remove_no_sub_repository](#remove_no_sub_repository-ssh_resource) (*ssh_resource*)
    - [update_all_repositories](#update_all_repositories-ssh_resource) (*ssh_resource*)
  - [output](#output)
    - [no_subscription](#no_subscription)</blockquote>

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

### `no_subscription` (*Optional*)
Whether to use no-subscription repository instead of enterprise repository or not

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    object({
    enabled           = bool
    list_file         = optional(string, "pve-no-subscription.list")
    list_file_content = optional(string, "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription")
  })
  ```
  **Default**:
  ```json
    {
  "enabled": true
}
  ```
  Defined in file: `variables.tf#14`

</details>
</blockquote>

## Outputs
### `resource`
<blockquote>

#### `add_no_sub_repository` (_ssh_resource_)
Defined in file: `main.tf#19`
</blockquote>
<blockquote>

#### `remove_no_sub_repository` (_ssh_resource_)
Defined in file: `main.tf#49`
</blockquote>
<blockquote>

#### `update_all_repositories` (_ssh_resource_)
Defined in file: `main.tf#35`
</blockquote>

### `output`
<blockquote>

#### `no_subscription`
States, whether a no-subscription repository was used (and some further details)

Defined in file: `outputs.tf#1`
</blockquote>