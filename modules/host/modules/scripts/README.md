# Script Management

Handles the download, execution and cleanup of (shell-)scripts on the host

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - _ssh_resource_.[script_cleanup](#ssh_resourcescript_cleanup)
  - _ssh_resource_.[script_download](#ssh_resourcescript_download)
  - _ssh_resource_.[script_execute](#ssh_resourcescript_execute)
- [Variables](#variables)
  - [ssh](#ssh-required) (**Required**)
  - [scripts](#scripts-optional) (*Optional*)
- [Outputs](#outputs)
  - [installed_scripts](#installed_scripts)
</blockquote><!-- contents:end -->

## Requirements
![opentofu](https://img.shields.io/badge/OpenTofu->=1.10.5-d3287d?logo=opentofu)

## Providers
  
![ssh](https://img.shields.io/badge/ssh--4fa4f9)

## Resources
  
<blockquote><!-- resource:"ssh_resource.script_cleanup":start -->

### _ssh_resource_.`script_cleanup`
      
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
</blockquote><!-- resource:"ssh_resource.script_cleanup":end -->
<blockquote><!-- resource:"ssh_resource.script_download":start -->

### _ssh_resource_.`script_download`
      
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
</blockquote><!-- resource:"ssh_resource.script_download":end -->
<blockquote><!-- resource:"ssh_resource.script_execute":start -->

### _ssh_resource_.`script_execute`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L39"><code>main.tf#L39</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"ssh_resource.script_execute":end -->

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
<blockquote><!-- variable:"scripts":start -->

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
  In file: <a href="./variables.tf#L14"><code>variables.tf#L14</code></a>

</details>
</blockquote><!-- variable:"scripts":end -->

## Outputs
  
<blockquote><!-- output:"installed_scripts":start -->

#### `installed_scripts`

The scripts, that have been installed/removed

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote><!-- output:"installed_scripts":end -->