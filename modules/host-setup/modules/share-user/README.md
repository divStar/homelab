# Share user

Handles the creation and deletion of a dedicated `share-user:share-users` (UID:GID),
who will own the media and other data files in the ZFS pool `storage-pool`.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [add_share_user](#add_share_user-ssh_resource) (*ssh_resource*)
  - [remove_share_user](#remove_share_user-ssh_resource) (*ssh_resource*)
- [Variables](#variables)
  - [ssh](#ssh-required) (**Required**)
  - [share_user](#share_user-optional) (*Optional*)
- [Outputs](#outputs)
  - [group](#group)
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

#### `add_share_user` (_ssh_resource_)
Create user and set up repository
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L17"><code>main.tf#L17</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `remove_share_user` (_ssh_resource_)
Cleanup on destroy
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

### `share_user` (*Optional*)
Configuration of GitOps user.

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    user  = string
    group = string
    uid   = number
    gid   = number
  })
  ```
  **Default**:
  ```json
  {
  "gid": 1400,
  "group": "share-users",
  "uid": 1400,
  "user": "share-user"
}
  ```
  In file: <a href="./variables.tf#L10"><code>variables.tf#L10</code></a>

</details>
</blockquote>


## Outputs
<blockquote>

#### `group`
Group of the share user

In file: <a href="./outputs.tf#L6"><code>outputs.tf#L6</code></a>
</blockquote>
<blockquote>

#### `user`
Name of the share user

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote>