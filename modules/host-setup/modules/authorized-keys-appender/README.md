# GitOps Management: authorized\_keys appender

Handles appending of SSH keys to the authorized\_keys file of a given user.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Inputs](#inputs)
  - [repo_name](#repo_name-required) (**Required**)
  - [ssh](#ssh-required) (**Required**)
  - [ssh_key_file](#ssh_key_file-required) (**Required**)
  - [target_user](#target_user-required) (**Required**)
  - [git_access_mode](#git_access_mode-optional) (*Optional*)
- [Outputs](#outputs)
  - [resource](#resource)
    - [add_key](#add_key-ssh_resource) (*ssh_resource*)
  - [output](#output)
    - [access_mode](#access_mode)
    - [authorized_keys_path](#authorized_keys_path)
    - [key_permissions](#key_permissions)
    - [key_with_restrictions](#key_with_restrictions)
    - [ssh_key_file_used](#ssh_key_file_used)</blockquote>

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

### `repo_name` (**Required**)
Name of the symbolic link to the actual gitops git repository

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    string
  ````
  Defined in file: `variables.tf#24`

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
  ````
  Defined in file: `variables.tf#1`

</details>
</blockquote>
<blockquote>

### `ssh_key_file` (**Required**)
Path to SSH public key file to add to authorized_keys (e.g. ~/.ssh/id_rsa.pub)

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    string
  ````
  Defined in file: `variables.tf#14`

</details>
</blockquote>
<blockquote>

### `target_user` (**Required**)
Username to add SSH key for

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    string
  ````
  Defined in file: `variables.tf#19`

</details>
</blockquote>
<blockquote>

### `git_access_mode` (*Optional*)
Git access mode: 'read-only' or 'read-write'

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    string
  ````
  **Default**:
  ```json
    "read-write"
  ```
  Defined in file: `variables.tf#29`

</details>
</blockquote>

## Outputs
### `resource`
<blockquote>

#### `add_key` (_ssh_resource_)
Defined in file: `main.tf#27`
</blockquote>

### `output`
<blockquote>

#### `access_mode`
Applied access mode (read-only or read-write) for the SSH key
Defined in file: `outputs.tf#6`
</blockquote>
<blockquote>

#### `authorized_keys_path`
Path to the authorized_keys file where the key was added
Defined in file: `outputs.tf#1`
</blockquote>
<blockquote>

#### `key_permissions`
Summary of permissions applied to this key
Defined in file: `outputs.tf#22`
</blockquote>
<blockquote>

#### `key_with_restrictions`
Complete authorized_keys entry including all restrictions
Defined in file: `outputs.tf#16`
</blockquote>
<blockquote>

#### `ssh_key_file_used`
Path to the SSH public key file that was used
Defined in file: `outputs.tf#11`
</blockquote>