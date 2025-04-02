# Terraform user

Handles the creation and deletion of a dedicated user with a custom role
and API token for the Terraform provisioner on the host.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Inputs](#inputs)
  - [ssh](#ssh-required) (**Required**)
  - [terraform_user](#terraform_user-optional) (*Optional*)
- [Outputs](#outputs)
  - [resource](#resource)
    - [assign_role](#assign_role-ssh_resource) (*ssh_resource*)
    - [create_api_token](#create_api_token-ssh_resource) (*ssh_resource*)
    - [create_role](#create_role-ssh_resource) (*ssh_resource*)
    - [create_user](#create_user-ssh_resource) (*ssh_resource*)
    - [delete_role](#delete_role-ssh_resource) (*ssh_resource*)
    - [delete_user](#delete_user-ssh_resource) (*ssh_resource*)
  - [output](#output)
    - [pve-user](#pve-user)
    - [token](#token)</blockquote>

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
        "Sys.Modify"
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
  Defined in file: `variables.tf#14`

</details>
</blockquote>

## Outputs
### `resource`
<blockquote>

#### `assign_role` (_ssh_resource_)
Defined in file: `main.tf#46`
</blockquote>
<blockquote>

#### `create_api_token` (_ssh_resource_)
Defined in file: `main.tf#60`
</blockquote>
<blockquote>

#### `create_role` (_ssh_resource_)
Defined in file: `main.tf#33`
</blockquote>
<blockquote>

#### `create_user` (_ssh_resource_)
Defined in file: `main.tf#20`
</blockquote>
<blockquote>

#### `delete_role` (_ssh_resource_)
Defined in file: `main.tf#74`
</blockquote>
<blockquote>

#### `delete_user` (_ssh_resource_)
Defined in file: `main.tf#87`
</blockquote>

### `output`
<blockquote>

#### `pve-user`
The user and role created on the Proxmox host

Defined in file: `outputs.tf#1`
</blockquote>
<blockquote>

#### `token`
The API token created on the Proxmox host

Defined in file: `outputs.tf#11`
</blockquote>