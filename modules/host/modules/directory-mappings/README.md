# Directory mappings

Handles the directory mappings of particular resources (e.g. file shares).
These mapped directories can then be used e.g. using `virtiofs` "pass-through" to VMs.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Execution story](#execution-story)
- [Resources](#resources)
  - _ssh_resource_.[directory_mappings](#ssh_resourcedirectory_mappings)
  - _ssh_resource_.[remove_directory_mappings](#ssh_resourceremove_directory_mappings)
- [Variables](#variables)
  - [proxmox_node_name](#proxmox_node_name-required) (**Required**)
  - [ssh](#ssh-required) (**Required**)
  - [directory_mappings](#directory_mappings-optional) (*Optional*)
- [Outputs](#outputs)
  - [directory_mappings](#directory_mappings)
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
├── ssh_resource.directory_mappings
├── ssh_resource.remove_directory_mappings
```




## Resources
<blockquote>

#### _ssh_resource_.`directory_mappings`

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
<blockquote>

#### _ssh_resource_.`remove_directory_mappings`

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

### `proxmox_node_name` (**Required**)
Proxmox node name

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L1"><code>variables.tf#L1</code></a>

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
  In file: <a href="./variables.tf#L6"><code>variables.tf#L6</code></a>

</details>
</blockquote>
<blockquote>

### `directory_mappings` (*Optional*)
Directory mappings for the Proxmox node

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(object({
    id      = string
    path    = string
    comment = optional(string, "")
  }))
  ```
  **Default**:
  ```json
  []
  ```
  In file: <a href="./variables.tf#L19"><code>variables.tf#L19</code></a>

</details>
</blockquote>


## Outputs
<blockquote>

#### `directory_mappings`
Directory mappings created

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote>