# Host Setup

This module and its sub-modules setup the Proxmox host.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules)
  - [copy_configs](#copy_configs)
  - [gitops_user](#gitops_user)
  - [packages](#packages)
  - [repositories](#repositories)
  - [scripts](#scripts)
  - [storage](#storage)
  - [terraform_user](#terraform_user)
  - [update_ssl](#update_ssl)
- [Inputs](#inputs)
  - [configuration_files](#configuration_files-required) (**Required**)
  - [proxmox](#proxmox-required) (**Required**)
  - [ssh](#ssh-required) (**Required**)
  - [storage](#storage-required) (**Required**)
  - [gitops_user](#gitops_user-optional) (*Optional*)
  - [no_subscription](#no_subscription-optional) (*Optional*)
  - [org_source_repo_owner](#org_source_repo_owner-optional) (*Optional*)
  - [packages](#packages-optional) (*Optional*)
  - [scripts](#scripts-optional) (*Optional*)
  - [terraform_user](#terraform_user-optional) (*Optional*)
- [Outputs](#outputs)
  - [output](#output)
    - [certificate_info](#certificate_info)
    - [configuration_files](#configuration_files)
    - [installed_packages](#installed_packages)
    - [installed_scripts](#installed_scripts)
    - [no_subscription](#no_subscription)
    - [pve-user](#pve-user)
    - [storage_pools](#storage_pools)
    - [storage_pools_directories](#storage_pools_directories)
    - [token](#token)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_restapi"></a> [restapi](#requirement\_restapi) | >= 1.20.0 |
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | ~> 2.7 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.13.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0.6 |
## Providers

No providers.
## Modules
<blockquote>

### `copy_configs`
Handles the copying of configuration files to the host.

| | |
|:--- |:--- |
| Module location | `./modules/copy-configs`
| Called in file | `main.tf#17`
</blockquote>
<blockquote>

### `gitops_user`
Handles the creation and deletion of a dedicated user git+ssh access (gitops) as well as setting and restoring owner / group of the original gitops repository. <blockquote> **Note:** in order to make use of the gitops git repository and user, public SSH keys of users/applications, who need access, have to be introduced into the `/home/<user, e.g. gitops>/.ssh/authorized_keys` file.<br> You can use the `authorized-keys-appender` script for this. </blockquote>

| | |
|:--- |:--- |
| Module location | `./modules/gitops-user`
| Called in file | `main.tf#80`
</blockquote>
<blockquote>

### `packages`
Handles the installation and removal of packages on the host <blockquote> **Note:** `ssh_resource` and CLI is used, because `apt-get install` and `apt-get remove` are not yet supported by Proxmox API. </blockquote>

| | |
|:--- |:--- |
| Module location | `./modules/packages`
| Called in file | `main.tf#38`
</blockquote>
<blockquote>

### `repositories`
Handles the deactivation of the enterprise repositories and the creation and activation of the no-subscription repositories.

| | |
|:--- |:--- |
| Module location | `./modules/repositories`
| Called in file | `main.tf#26`
</blockquote>
<blockquote>

### `scripts`
Handles the download, execution and cleanup of (shell-)scripts on the host

| | |
|:--- |:--- |
| Module location | `./modules/scripts`
| Called in file | `main.tf#48`
</blockquote>
<blockquote>

### `storage`
Handles the import and export of ZFS pools as well as directories.

| | |
|:--- |:--- |
| Module location | `./modules/storage`
| Called in file | `main.tf#58`
</blockquote>
<blockquote>

### `terraform_user`
Handles the creation and deletion of a dedicated user with a custom role and API token for the Terraform provisioner on the host.

| | |
|:--- |:--- |
| Module location | `./modules/terraform-user`
| Called in file | `main.tf#9`
</blockquote>
<blockquote>

### `update_ssl`


| | |
|:--- |:--- |
| Module location | `./modules/update-ssl`
| Called in file | `main.tf#90`
</blockquote>

## Inputs
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
  Defined in file: `variables.tf#26`

</details>
</blockquote>
<blockquote>

### `proxmox` (**Required**)
Proxmox host configuration

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    object({
    name = string
    host = string
    port = number
  })
  ```
  Defined in file: `variables.tf#14`

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
  Defined in file: `variables.tf#1`

</details>
</blockquote>
<blockquote>

### `storage` (**Required**)
Configuration of the storage (pools and directories) to import

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    list(object({
    name = string
    type = string # "pool" or "directory"
    # For directories only:
    path          = optional(string)
    content_types = optional(list(string))
  }))
  ```
  Defined in file: `variables.tf#156`

</details>
</blockquote>
<blockquote>

### `gitops_user` (*Optional*)
Configuration of GitOps user.

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    object({
    user        = optional(string, "gitops")
    group       = optional(string, "gitops")
    repo_name   = optional(string, "repo")
    source_repo = optional(string, "/storage-pool/gitops")
  })
  ```
  **Default**:
  ```json
    {}
  ```
  Defined in file: `variables.tf#134`

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
  Defined in file: `variables.tf#196`

</details>
</blockquote>
<blockquote>

### `org_source_repo_owner` (*Optional*)
Original owner of the source repository (before, e.g. root:root)

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    object({
    owner = optional(string, "root")
    group = optional(string, "root")
  })
  ```
  **Default**:
  ```json
    {}
  ```
  Defined in file: `variables.tf#146`

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
  Defined in file: `variables.tf#42`

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
  ```
  **Default**:
  ```json
    {
  "directory": "scripts",
  "items": []
}
  ```
  Defined in file: `variables.tf#49`

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
  Defined in file: `variables.tf#85`

</details>
</blockquote>

## Outputs

### `output`
<blockquote>

#### `certificate_info`
pve-ssl Certificate information

Defined in file: `outputs.tf#43`
</blockquote>
<blockquote>

#### `configuration_files`
Configuration files copied to host

Defined in file: `outputs.tf#1`
</blockquote>
<blockquote>

#### `installed_packages`
The packages, that have been installed/removed

Defined in file: `outputs.tf#11`
</blockquote>
<blockquote>

#### `installed_scripts`
The scripts, that have been installed/removed

Defined in file: `outputs.tf#16`
</blockquote>
<blockquote>

#### `no_subscription`
States, whether a no-subscription repository was used (and some further details)

Defined in file: `outputs.tf#6`
</blockquote>
<blockquote>

#### `pve-user`
The user and role created on the Proxmox host

Defined in file: `outputs.tf#21`
</blockquote>
<blockquote>

#### `storage_pools`
List of storage pools that were imported and added to Proxmox

Defined in file: `outputs.tf#33`
</blockquote>
<blockquote>

#### `storage_pools_directories`
List of directories/datasets that were configured in Proxmox

Defined in file: `outputs.tf#38`
</blockquote>
<blockquote>

#### `token`
The API token created on the Proxmox host

Defined in file: `outputs.tf#27`
</blockquote>