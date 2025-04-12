# GitOps Management: authorized\_keys appender

Handles appending of SSH keys to the authorized\_keys file of a given user.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [add_key](#add_key-ssh_resource) (*ssh_resource*)
- [Variables](#variables)
  - [repo_name](#repo_name-required) (**Required**)
  - [ssh](#ssh-required) (**Required**)
  - [ssh_key_file](#ssh_key_file-required) (**Required**)
  - [target_user](#target_user-required) (**Required**)
  - [git_access_mode](#git_access_mode-optional) (*Optional*)
- [Outputs](#outputs)
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


## Resources
<blockquote>

#### `add_key` (_ssh_resource_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L27"><code>main.tf#L27</code></a></td>
    </tr>
  </table>
</blockquote>

## Variables
<blockquote>

### `repo_name` (**Required**)
Name of the symbolic link to the actual gitops git repository

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L24"><code>variables.tf#L24</code></a>

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
<blockquote>

### `ssh_key_file` (**Required**)
Path to SSH public key file to add to authorized_keys (e.g. ~/.ssh/id_rsa.pub)

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L14"><code>variables.tf#L14</code></a>

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
  ```
  In file: <a href="./variables.tf#L19"><code>variables.tf#L19</code></a>

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
  ```
  **Default**:
  ```json
  "read-write"
  ```
  In file: <a href="./variables.tf#L29"><code>variables.tf#L29</code></a>

</details>
</blockquote>


## Outputs
<blockquote>

#### `access_mode`
Applied access mode (read-only or read-write) for the SSH key

In file: <a href="./outputs.tf#L6"><code>outputs.tf#L6</code></a>
</blockquote>
<blockquote>

#### `authorized_keys_path`
Path to the authorized_keys file where the key was added

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote>
<blockquote>

#### `key_permissions`
Summary of permissions applied to this key

In file: <a href="./outputs.tf#L22"><code>outputs.tf#L22</code></a>
</blockquote>
<blockquote>

#### `key_with_restrictions`
Complete authorized_keys entry including all restrictions

In file: <a href="./outputs.tf#L16"><code>outputs.tf#L16</code></a>
</blockquote>
<blockquote>

#### `ssh_key_file_used`
Path to the SSH public key file that was used

In file: <a href="./outputs.tf#L11"><code>outputs.tf#L11</code></a>
</blockquote>