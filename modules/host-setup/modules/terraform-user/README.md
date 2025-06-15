# Terraform user

Handles the creation and deletion of a dedicated user with a custom role
and API token for the Terraform provisioner on the host.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [assign_role](#assign_role-ssh_resource) (*ssh_resource*)
  - [create_api_token](#create_api_token-ssh_resource) (*ssh_resource*)
  - [create_role](#create_role-ssh_resource) (*ssh_resource*)
  - [create_user](#create_user-ssh_resource) (*ssh_resource*)
  - [delete_role](#delete_role-ssh_resource) (*ssh_resource*)
  - [delete_user](#delete_user-ssh_resource) (*ssh_resource*)
- [Variables](#variables)
  - [ssh](#ssh-required) (**Required**)
  - [terraform_user](#terraform_user-optional) (*Optional*)
- [Outputs](#outputs)
  - [token](#token)
  - [user](#user)</blockquote>

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

#### `assign_role` (_ssh_resource_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L46"><code>main.tf#L46</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `create_api_token` (_ssh_resource_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L60"><code>main.tf#L60</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `create_role` (_ssh_resource_)

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
<blockquote>

#### `create_user` (_ssh_resource_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L20"><code>main.tf#L20</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `delete_role` (_ssh_resource_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L74"><code>main.tf#L74</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `delete_user` (_ssh_resource_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L87"><code>main.tf#L87</code></a></td>
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

### `terraform_user` (*Optional*)
Configuration for Terraform provisioner user. Individual fields can be overridden.

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    name    = optional(string, "terraform@pve")
    comment = optional(string, "Terraform automation user")
    role = object({
      name = optional(string, "TerraformProv")
      privileges = optional(list(string), [
        "VM.Allocate",
        "VM.Clone",
        "VM.Audit",
        "VM.Config.HWType",
        "VM.Config.Disk",
        "VM.Config.CPU",
        "VM.Config.Memory",
        "VM.Config.Network",
        "VM.Config.Cloudinit",
        "VM.Config.Options",
        "VM.PowerMgmt",
        "VM.Monitor",
        "Datastore.Allocate",
        "Datastore.AllocateSpace",
        "Datastore.AllocateTemplate",
        "Datastore.Audit",
        "SDN.Use",
        "Sys.Audit",
        "Sys.Modify",
        "Mapping.Use",
        "Mapping.Modify"
      ])
    })
    token = object({
      name    = optional(string, "terraform-token")
      comment = optional(string, "Terraform automation user API token")
    })
  })
  ```
  **Default**:
  ```json
  {
  "role": {},
  "token": {}
}
  ```
  In file: <a href="./variables.tf#L14"><code>variables.tf#L14</code></a>

</details>
</blockquote>


## Outputs
<blockquote>

#### `token`
The API token created on the Proxmox host

In file: <a href="./outputs.tf#L11"><code>outputs.tf#L11</code></a>
</blockquote>
<blockquote>

#### `user`
The user and role created on the Proxmox host

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote>