# Share user

Handles the creation and deletion of a dedicated `share-user:share-users` (UID:GID),
who will own the media and other data files in the ZFS pool `storage-pool`.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - _ssh_resource_.[add_share_user](#ssh_resourceadd_share_user)
  - _ssh_resource_.[remove_share_user](#ssh_resourceremove_share_user)
- [Variables](#variables)
  - [ssh](#ssh-required) (**Required**)
  - [share_user](#share_user-optional) (*Optional*)
- [Outputs](#outputs)
  - [group](#group)
  - [user](#user)
</blockquote><!-- contents:end -->

## Requirements
![opentofu](https://img.shields.io/badge/OpenTofu->=1.10.5-d3287d?logo=opentofu)

## Providers
  
![ssh](https://img.shields.io/badge/ssh--4fa4f9)

## Resources
  
<blockquote><!-- resource:"ssh_resource.add_share_user":start -->

### _ssh_resource_.`add_share_user`

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
</blockquote><!-- resource:"ssh_resource.add_share_user":end -->
<blockquote><!-- resource:"ssh_resource.remove_share_user":start -->

### _ssh_resource_.`remove_share_user`

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
</blockquote><!-- resource:"ssh_resource.remove_share_user":end -->

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
<blockquote><!-- variable:"share_user":start -->

### `share_user` (*Optional*)

Configuration of share user.

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
  "gid": 1000,
  "group": "share-users",
  "uid": 1000,
  "user": "share-user"
}
  ```
  In file: <a href="./variables.tf#L10"><code>variables.tf#L10</code></a>

</details>
</blockquote><!-- variable:"share_user":end -->

## Outputs
  
<blockquote><!-- output:"group":start -->

#### `group`

Group of the share user

In file: <a href="./outputs.tf#L6"><code>outputs.tf#L6</code></a>
</blockquote><!-- output:"group":end -->
<blockquote><!-- output:"user":start -->

#### `user`

Name of the share user

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote><!-- output:"user":end -->