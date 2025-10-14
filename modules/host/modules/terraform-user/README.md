# Terraform user

Handles the creation and deletion of a dedicated user with a custom role
and API token for the Terraform provisioner on the host.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Execution story](#execution-story)
- [Resources](#resources)
  - _ssh_resource_.[assign_role](#ssh_resourceassign_role)
  - _ssh_resource_.[create_api_token](#ssh_resourcecreate_api_token)
  - _ssh_resource_.[create_role](#ssh_resourcecreate_role)
  - _ssh_resource_.[create_user](#ssh_resourcecreate_user)
  - _ssh_resource_.[delete_role](#ssh_resourcedelete_role)
  - _ssh_resource_.[delete_user](#ssh_resourcedelete_user)
- [Variables](#variables)
  - [ssh](#ssh-required) (**Required**)
  - [terraform_user](#terraform_user-optional) (*Optional*)
- [Outputs](#outputs)
  - [token](#token)
  - [user](#user)
</blockquote><!-- contents:end -->

## Requirements
  
![terraform](https://img.shields.io/badge/terraform->=1.8.0-d3287d?logo=terraform)
![ssh](https://img.shields.io/badge/ssh-~>2.7-4fa4f9?logo=ssh)

## Providers
  
![ssh](https://img.shields.io/badge/ssh-2.7.0-4fa4f9)

## Execution story

Order in which Terraform will create resources (and likely destroy them in reverse order):
```
├── ssh_resource.create_api_token
├── ssh_resource.create_user
├── ssh_resource.delete_user
├── ssh_resource.delete_role
├── ssh_resource.create_role
├── ssh_resource.assign_role
```

## Resources
  
<blockquote><!-- resource:"ssh_resource.assign_role":start -->

### _ssh_resource_.`assign_role`
      
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
</blockquote><!-- resource:"ssh_resource.assign_role":end -->
<blockquote><!-- resource:"ssh_resource.create_api_token":start -->

### _ssh_resource_.`create_api_token`
      
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
</blockquote><!-- resource:"ssh_resource.create_api_token":end -->
<blockquote><!-- resource:"ssh_resource.create_role":start -->

### _ssh_resource_.`create_role`
      
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
</blockquote><!-- resource:"ssh_resource.create_role":end -->
<blockquote><!-- resource:"ssh_resource.create_user":start -->

### _ssh_resource_.`create_user`
      
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
</blockquote><!-- resource:"ssh_resource.create_user":end -->
<blockquote><!-- resource:"ssh_resource.delete_role":start -->

### _ssh_resource_.`delete_role`
      
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
</blockquote><!-- resource:"ssh_resource.delete_role":end -->
<blockquote><!-- resource:"ssh_resource.delete_user":start -->

### _ssh_resource_.`delete_user`
      
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
</blockquote><!-- resource:"ssh_resource.delete_user":end -->

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
<blockquote><!-- variable:"terraform_user":start -->

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
</blockquote><!-- variable:"terraform_user":end -->

## Outputs
  
<blockquote><!-- output:"token":start -->

#### `token`

The API token created on the Proxmox host

In file: <a href="./outputs.tf#L11"><code>outputs.tf#L11</code></a>
</blockquote><!-- output:"token":end -->
<blockquote><!-- output:"user":start -->

#### `user`

The user and role created on the Proxmox host

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote><!-- output:"user":end -->