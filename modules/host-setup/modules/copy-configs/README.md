# Copy configurations

Handles the copying of configuration files to the host.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [copy_configuration_files](#copy_configuration_files-ssh_resource) (*ssh_resource*)
  - [remove_configuration_files](#remove_configuration_files-ssh_resource) (*ssh_resource*)
- [Variables](#variables)
  - [configuration_files](#configuration_files-required) (**Required**)
  - [ssh](#ssh-required) (**Required**)
- [Outputs](#outputs)
  - [configuration_files](#configuration_files)</blockquote>

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

#### `copy_configuration_files` (_ssh_resource_)
In file: `main.tf#15`
</blockquote>
<blockquote>

#### `remove_configuration_files` (_ssh_resource_)
In file: `main.tf#33`
</blockquote>

## Variables
<blockquote>

### `configuration_files` (**Required**)
Configuration files to copy to the host

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(object({
    source      = string
    destination = string
    permissions = optional(number)
    owner       = optional(string)
    group       = optional(string)
  }))
  ```
  In file: `variables.tf#14`

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
  In file: `variables.tf#1`

</details>
</blockquote>


## Outputs
<blockquote>

#### `configuration_files`
Configuration files copied to host

In file: `outputs.tf#1`
</blockquote>