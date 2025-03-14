# Script Management

Handles the download, execution and cleanup of (shell-)scripts on the host
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Inputs](#inputs)
  - [ssh](#ssh-required) (**Required**)
  - [scripts](#scripts-optional) (*Optional*)
- [Outputs](#outputs)
  - [resource](#resource)
    - [script_cleanup](#script_cleanup-ssh_resource) (*ssh_resource*)
    - [script_download](#script_download-ssh_resource) (*ssh_resource*)
    - [script_execute](#script_execute-ssh_resource) (*ssh_resource*)
  - [output](#output)
    - [installed_scripts](#installed_scripts)</blockquote>

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
  ````
  Defined in file: `variables.tf#1`

</details>
</blockquote>
<blockquote>

### `scripts` (*Optional*)
Configuration for script management including shared directory and script items

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    object({
    directory = optional(string, "scripts")
    items = list(object({
      name           = string
      url            = string
      apply_params   = optional(string, "")
      destroy_params = optional(string, "")
      run_on_destroy = optional(bool, true)
    }))
  })
  ````
  **Default**:
  ```json
    {
  "directory": "scripts",
  "items": []
}
  ```
  Defined in file: `variables.tf#14`

</details>
</blockquote>

## Outputs
### `resource`
<blockquote>

#### `script_cleanup` (_ssh_resource_)
Defined in file: `main.tf#56`
</blockquote>
<blockquote>

#### `script_download` (_ssh_resource_)
Defined in file: `main.tf#19`
</blockquote>
<blockquote>

#### `script_execute` (_ssh_resource_)
Defined in file: `main.tf#39`
</blockquote>

### `output`
<blockquote>

#### `installed_scripts`
The scripts, that have been installed/removed
Defined in file: `outputs.tf#1`
</blockquote>