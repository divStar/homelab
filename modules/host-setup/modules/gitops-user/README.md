# GitOps user

Handles the creation and deletion of a dedicated user git+ssh access (gitops)
as well as setting and restoring owner / group of the original gitops repository.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [add_gitops_user](#add_gitops_user-ssh_resource) (*ssh_resource*)
  - [remove_gitops_user](#remove_gitops_user-ssh_resource) (*ssh_resource*)
- [Variables](#variables)
  - [ssh](#ssh-required) (**Required**)
  - [gitops_user](#gitops_user-optional) (*Optional*)
  - [org_source_repo_owner](#org_source_repo_owner-optional) (*Optional*)
- [Outputs](#outputs)
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


## Resources
<blockquote>

#### `add_gitops_user` (_ssh_resource_)
Create user and set up repository
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L19"><code>main.tf#L19</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `remove_gitops_user` (_ssh_resource_)
Cleanup on destroy
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L48"><code>main.tf#L48</code></a></td>
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
  In file: <a href="./variables.tf#L14"><code>variables.tf#L14</code></a>

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
  In file: <a href="./variables.tf#L26"><code>variables.tf#L26</code></a>

</details>
</blockquote>


## Outputs
<blockquote>

#### `git_ssh_url`
The git+ssh address / URL

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote>
<blockquote>

#### `repo_actual_path`
Actual path to the git repository

In file: <a href="./outputs.tf#L21"><code>outputs.tf#L21</code></a>
</blockquote>
<blockquote>

#### `repo_local_path`
Local path to the repository symlink

In file: <a href="./outputs.tf#L16"><code>outputs.tf#L16</code></a>
</blockquote>
<blockquote>

#### `user`
Name of the gitops user, that allows access to the gitops git repository via SSH

In file: <a href="./outputs.tf#L6"><code>outputs.tf#L6</code></a>
</blockquote>
<blockquote>

#### `user_home`
Home directory of the git user

In file: <a href="./outputs.tf#L11"><code>outputs.tf#L11</code></a>
</blockquote>