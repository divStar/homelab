# GitOps user

Handles the creation and deletion of a dedicated user with git+ssh access (gitops)
as well as setting and restoring owner / group of the original gitops repository.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Execution story](#execution-story)
- [Resources](#resources)
  - _ssh_resource_.[add_gitops_user](#ssh_resourceadd_gitops_user)
  - _ssh_resource_.[remove_gitops_user](#ssh_resourceremove_gitops_user)
- [Variables](#variables)
  - [ssh](#ssh-required) (**Required**)
  - [group](#group-optional) (*Optional*)
  - [repository](#repository-optional) (*Optional*)
  - [repository_symlink](#repository_symlink-optional) (*Optional*)
  - [user](#user-optional) (*Optional*)
- [Outputs](#outputs)
  - [git_ssh_url](#git_ssh_url)
  - [repo_actual_path](#repo_actual_path)
  - [repo_local_path](#repo_local_path)
  - [repo_name](#repo_name)
  - [user](#user)
  - [user_home](#user_home)
</blockquote><!-- contents:end -->

## Requirements
  
![terraform](https://img.shields.io/badge/terraform->=1.8.0-d3287d?logo=terraform)
![ssh](https://img.shields.io/badge/ssh-~>2.7-4fa4f9?logo=ssh)

## Providers
  
![ssh](https://img.shields.io/badge/ssh-2.7.0-4fa4f9)

## Execution story

Order in which Terraform will create resources (and likely destroy them in reverse order):
```
├── ssh_resource.add_gitops_user
├── ssh_resource.remove_gitops_user
```

## Resources
  
<blockquote><!-- resource:"ssh_resource.add_gitops_user":start -->

### _ssh_resource_.`add_gitops_user`

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
</blockquote><!-- resource:"ssh_resource.add_gitops_user":end -->
<blockquote><!-- resource:"ssh_resource.remove_gitops_user":start -->

### _ssh_resource_.`remove_gitops_user`

Cleanup on destroy
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L43"><code>main.tf#L43</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"ssh_resource.remove_gitops_user":end -->

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
<blockquote><!-- variable:"group":start -->

### `group` (*Optional*)

Group to own the gitops directory

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "gitops"
  ```
  In file: <a href="./variables.tf#L21"><code>variables.tf#L21</code></a>

</details>
</blockquote><!-- variable:"group":end -->
<blockquote><!-- variable:"repository":start -->

### `repository` (*Optional*)

Full path to the git repository; note: this will be owned by `user`:`group` and a symlink in `home_directory` will point to this directory

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "/mnt/storage/gitops"
  ```
  In file: <a href="./variables.tf#L28"><code>variables.tf#L28</code></a>

</details>
</blockquote><!-- variable:"repository":end -->
<blockquote><!-- variable:"repository_symlink":start -->

### `repository_symlink` (*Optional*)

Name of the symlink (directory), which will be created in `home_directory` and will point to `repository`

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "gitops"
  ```
  In file: <a href="./variables.tf#L35"><code>variables.tf#L35</code></a>

</details>
</blockquote><!-- variable:"repository_symlink":end -->
<blockquote><!-- variable:"user":start -->

### `user` (*Optional*)

User to own the gitops directory

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "gitops"
  ```
  In file: <a href="./variables.tf#L14"><code>variables.tf#L14</code></a>

</details>
</blockquote><!-- variable:"user":end -->

## Outputs
  
<blockquote><!-- output:"git_ssh_url":start -->

#### `git_ssh_url`

The git+ssh address / URL

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote><!-- output:"git_ssh_url":end -->
<blockquote><!-- output:"repo_actual_path":start -->

#### `repo_actual_path`

Actual path to the git repository

In file: <a href="./outputs.tf#L26"><code>outputs.tf#L26</code></a>
</blockquote><!-- output:"repo_actual_path":end -->
<blockquote><!-- output:"repo_local_path":start -->

#### `repo_local_path`

Local path to the repository symlink

In file: <a href="./outputs.tf#L21"><code>outputs.tf#L21</code></a>
</blockquote><!-- output:"repo_local_path":end -->
<blockquote><!-- output:"repo_name":start -->

#### `repo_name`

Name of the symbolic link inside the home directory, which points to the actual gitops git repository

In file: <a href="./outputs.tf#L16"><code>outputs.tf#L16</code></a>
</blockquote><!-- output:"repo_name":end -->
<blockquote><!-- output:"user":start -->

#### `user`

Name of the gitops user, that allows access to the gitops git repository via SSH

In file: <a href="./outputs.tf#L6"><code>outputs.tf#L6</code></a>
</blockquote><!-- output:"user":end -->
<blockquote><!-- output:"user_home":start -->

#### `user_home`

Home directory of the git user

In file: <a href="./outputs.tf#L11"><code>outputs.tf#L11</code></a>
</blockquote><!-- output:"user_home":end -->