# Repository Management

Handles the deactivation of the enterprise repositories and
the creation and activation of the no-subscription repositories.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - _ssh_resource_.[copy_no_subscription_sources](#ssh_resourcecopy_no_subscription_sources)
  - _ssh_resource_.[disable_enterprise_sources](#ssh_resourcedisable_enterprise_sources)
  - _ssh_resource_.[enable_enterprise_sources](#ssh_resourceenable_enterprise_sources)
  - _ssh_resource_.[update_all_repositories](#ssh_resourceupdate_all_repositories)
  - _ssh_resource_.[update_all_repositories_enterprise](#ssh_resourceupdate_all_repositories_enterprise)
- [Variables](#variables)
  - [ssh](#ssh-required) (**Required**)
  - [no_subscription](#no_subscription-optional) (*Optional*)
- [Outputs](#outputs)
  - [no_subscription](#no_subscription)
</blockquote><!-- contents:end -->

## Requirements
![opentofu](https://img.shields.io/badge/OpenTofu->=1.10.5-d3287d?logo=opentofu)

## Providers
  
![ssh](https://img.shields.io/badge/ssh--4fa4f9)

## Resources
  
<blockquote><!-- resource:"ssh_resource.copy_no_subscription_sources":start -->

### _ssh_resource_.`copy_no_subscription_sources`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L34"><code>main.tf#L34</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"ssh_resource.copy_no_subscription_sources":end -->
<blockquote><!-- resource:"ssh_resource.disable_enterprise_sources":start -->

### _ssh_resource_.`disable_enterprise_sources`
      
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
</blockquote><!-- resource:"ssh_resource.disable_enterprise_sources":end -->
<blockquote><!-- resource:"ssh_resource.enable_enterprise_sources":start -->

### _ssh_resource_.`enable_enterprise_sources`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L84"><code>main.tf#L84</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"ssh_resource.enable_enterprise_sources":end -->
<blockquote><!-- resource:"ssh_resource.update_all_repositories":start -->

### _ssh_resource_.`update_all_repositories`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L56"><code>main.tf#L56</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"ssh_resource.update_all_repositories":end -->
<blockquote><!-- resource:"ssh_resource.update_all_repositories_enterprise":start -->

### _ssh_resource_.`update_all_repositories_enterprise`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L99"><code>main.tf#L99</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"ssh_resource.update_all_repositories_enterprise":end -->

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
  bool
  ```
  **Default**:
  ```json
  true
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