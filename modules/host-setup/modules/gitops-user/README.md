# GitOps user

Handles the creation and deletion of a dedicated user git+ssh access (gitops)
as well as setting and restoring owner / group of the original gitops repository.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Inputs](#inputs)
  - [ssh](#ssh-required) (**Required**)
  - [gitops_user](#gitops_user-optional) (*Optional*)
  - [org_source_repo_owner](#org_source_repo_owner-optional) (*Optional*)
- [Outputs](#outputs)
  - [resource](#resource)
    - [add_gitops_user](#add_gitops_user-ssh_resource) (*ssh_resource*)
    - [remove_gitops_user](#remove_gitops_user-ssh_resource) (*ssh_resource*)
  - [output](#output)
    - [git_ssh_url](#git_ssh_url)
    - [repo_actual_path](#repo_actual_path)
    - [repo_local_path](#repo_local_path)
    - [user](#user)
    - [user_home](#user_home)</blockquote>

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
  ````
  **Default**:
  ```json
    {}
  ```
  Defined in file: `variables.tf#14`

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
  ````
  **Default**:
  ```json
    {}
  ```
  Defined in file: `variables.tf#26`

</details>
</blockquote>

## Outputs
### `resource`
<blockquote>

#### `add_gitops_user` (_ssh_resource_)
Defined in file: `main.tf#19`
</blockquote>
<blockquote>

#### `remove_gitops_user` (_ssh_resource_)
Defined in file: `main.tf#48`
</blockquote>

### `output`
<blockquote>

#### `git_ssh_url`
The git+ssh address / URL
Defined in file: `outputs.tf#1`
</blockquote>
<blockquote>

#### `repo_actual_path`
Actual path to the git repository
Defined in file: `outputs.tf#21`
</blockquote>
<blockquote>

#### `repo_local_path`
Local path to the repository symlink
Defined in file: `outputs.tf#16`
</blockquote>
<blockquote>

#### `user`
Name of the gitops user, that allows access to the gitops git repository via SSH
Defined in file: `outputs.tf#6`
</blockquote>
<blockquote>

#### `user_home`
Home directory of the git user
Defined in file: `outputs.tf#11`
</blockquote>