# Repository Management

Handles the deactivation of the enterprise repositories and
the creation and activation of the no-subscription repositories.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Execution story](#execution-story)
- [Resources](#resources)
  - _ssh_resource_.[add_no_sub_repository](#ssh_resourceadd_no_sub_repository)
  - _ssh_resource_.[remove_no_sub_repository](#ssh_resourceremove_no_sub_repository)
  - _ssh_resource_.[update_all_repositories](#ssh_resourceupdate_all_repositories)
- [Variables](#variables)
  - [ssh](#ssh-required) (**Required**)
  - [no_subscription](#no_subscription-optional) (*Optional*)
- [Outputs](#outputs)
  - [no_subscription](#no_subscription)
</blockquote><!-- contents:end -->

## Requirements
  
![terraform](https://img.shields.io/badge/terraform->=1.8.0-d3287d?logo=terraform)
![ssh](https://img.shields.io/badge/ssh-~>2.7-4fa4f9?logo=ssh)

## Providers
  
![ssh](https://img.shields.io/badge/ssh-2.7.0-4fa4f9)

## Execution story

Order in which Terraform will create resources (and likely destroy them in reverse order):
```
├── ssh_resource.add_no_sub_repository
├── ssh_resource.remove_no_sub_repository
├── ssh_resource.update_all_repositories
```

## Resources
  
<blockquote><!-- resource:"ssh_resource.add_no_sub_repository":start -->

### _ssh_resource_.`add_no_sub_repository`
      
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
</blockquote><!-- resource:"ssh_resource.add_no_sub_repository":end -->
<blockquote><!-- resource:"ssh_resource.remove_no_sub_repository":start -->

### _ssh_resource_.`remove_no_sub_repository`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L49"><code>main.tf#L49</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"ssh_resource.remove_no_sub_repository":end -->
<blockquote><!-- resource:"ssh_resource.update_all_repositories":start -->

### _ssh_resource_.`update_all_repositories`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L35"><code>main.tf#L35</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"ssh_resource.update_all_repositories":end -->

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
<blockquote><!-- variable:"no_subscription":start -->

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
  In file: <a href="./variables.tf#L14"><code>variables.tf#L14</code></a>

</details>
</blockquote><!-- variable:"no_subscription":end -->

## Outputs
  
<blockquote><!-- output:"no_subscription":start -->

#### `no_subscription`

States, whether a no-subscription repository was used (and some further details)

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote><!-- output:"no_subscription":end -->