# Copy configurations

Handles the copying of configuration files to the host.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Execution story](#execution-story)
- [Resources](#resources)
  - _ssh_resource_.[copy_configuration_files](#ssh_resourcecopy_configuration_files)
  - _ssh_resource_.[remove_configuration_files](#ssh_resourceremove_configuration_files)
- [Variables](#variables)
  - [configuration_files](#configuration_files-required) (**Required**)
  - [ssh](#ssh-required) (**Required**)
- [Outputs](#outputs)
  - [configuration_files](#configuration_files)
</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | ~> 2.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ssh"></a> [ssh](#provider\_ssh) | 2.7.0 |

## Execution story

Order in which Terraform will create resources (and likely destroy them in reverse order):
```
├── ssh_resource.copy_configuration_files
├── ssh_resource.remove_configuration_files
```




## Resources
<blockquote>

#### _ssh_resource_.`copy_configuration_files`

  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L15"><code>main.tf#L15</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### _ssh_resource_.`remove_configuration_files`

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


## Outputs
<blockquote>

#### `configuration_files`
Configuration files copied to host

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote>