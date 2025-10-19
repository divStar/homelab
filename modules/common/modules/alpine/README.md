# Alpine LXC container setup

This module creates an Alpine LXC container on the Proxmox host,
generates a `root_password` and a `ssh_key`, installs `openssh` as well as
other Alpine packages (if specified; `bash` is installed by default).

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - _proxmox_virtual_environment_container_.[container](#proxmox_virtual_environment_containercontainer)
  - _proxmox_virtual_environment_download_file_.[template](#proxmox_virtual_environment_download_filetemplate)
  - _random_password_.[root_password](#random_passwordroot_password)
  - _ssh_resource_.[install_openssh](#ssh_resourceinstall_openssh)
  - _ssh_resource_.[install_packages](#ssh_resourceinstall_packages)
  - _tls_private_key_.[ssh_key](#tls_private_keyssh_key)
- [Variables](#variables)
  - [hostname](#hostname-required) (**Required**)
  - [ni_gateway](#ni_gateway-required) (**Required**)
  - [ni_ip](#ni_ip-required) (**Required**)
  - [ni_mac_address](#ni_mac_address-required) (**Required**)
  - [proxmox](#proxmox-required) (**Required**)
  - [vm_id](#vm_id-required) (**Required**)
  - [alpine_image](#alpine_image-optional) (*Optional*)
  - [cpu_cores](#cpu_cores-optional) (*Optional*)
  - [cpu_units](#cpu_units-optional) (*Optional*)
  - [description](#description-optional) (*Optional*)
  - [disk_size](#disk_size-optional) (*Optional*)
  - [imagestore_id](#imagestore_id-optional) (*Optional*)
  - [memory_dedicated](#memory_dedicated-optional) (*Optional*)
  - [mount_points](#mount_points-optional) (*Optional*)
  - [ni_bridge](#ni_bridge-optional) (*Optional*)
  - [ni_name](#ni_name-optional) (*Optional*)
  - [ni_subnet_mask](#ni_subnet_mask-optional) (*Optional*)
  - [packages](#packages-optional) (*Optional*)
  - [startup_down_delay](#startup_down_delay-optional) (*Optional*)
  - [startup_order](#startup_order-optional) (*Optional*)
  - [startup_up_delay](#startup_up_delay-optional) (*Optional*)
  - [tags](#tags-optional) (*Optional*)
- [Outputs](#outputs)
  - [root_password](#root_password)
  - [ssh_private_key](#ssh_private_key)
</blockquote><!-- contents:end -->

## Requirements
![opentofu](https://img.shields.io/badge/OpenTofu->=1.10.5-d3287d?logo=opentofu)
![proxmox](https://img.shields.io/badge/proxmox->=0.75.0-1e73c8?logo=proxmox)
![ssh](https://img.shields.io/badge/ssh-~>2.7-4fa4f9?logo=ssh)

## Providers
  
![proxmox](https://img.shields.io/badge/proxmox->=0.75.0-1e73c8)
![random](https://img.shields.io/badge/random--82d72c)
![ssh](https://img.shields.io/badge/ssh-~>2.7-4fa4f9)
![tls](https://img.shields.io/badge/tls--54a9fe)

## Resources
  
<blockquote><!-- resource:"proxmox_virtual_environment_container.container":start -->

### _proxmox_virtual_environment_container_.`container`

Create Alpine LXC container
  <table>
    <tr>
      <td>Provider</td>
      <td><code>proxmox (bpg/proxmox)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L33"><code>main.tf#L33</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"proxmox_virtual_environment_container.container":end -->
<blockquote><!-- resource:"proxmox_virtual_environment_download_file.template":start -->

### _proxmox_virtual_environment_download_file_.`template`

Downloads the `alpine` image.
  <table>
    <tr>
      <td>Provider</td>
      <td><code>proxmox (bpg/proxmox)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L10"><code>main.tf#L10</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"proxmox_virtual_environment_download_file.template":end -->
<blockquote><!-- resource:"random_password.root_password":start -->

### _random_password_.`root_password`

Generate a random password for the container
  <table>
    <tr>
      <td>Provider</td>
      <td><code>random (hashicorp/random)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L26"><code>main.tf#L26</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"random_password.root_password":end -->
<blockquote><!-- resource:"ssh_resource.install_openssh":start -->

### _ssh_resource_.`install_openssh`

Install OpenSSH into the Alpine LXC container
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L117"><code>main.tf#L117</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"ssh_resource.install_openssh":end -->
<blockquote><!-- resource:"ssh_resource.install_packages":start -->

### _ssh_resource_.`install_packages`

Install necessary Alpine packages
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L153"><code>main.tf#L153</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"ssh_resource.install_packages":end -->
<blockquote><!-- resource:"tls_private_key.ssh_key":start -->

### _tls_private_key_.`ssh_key`

Generate SSH key for the container
  <table>
    <tr>
      <td>Provider</td>
      <td><code>tls (hashicorp/tls)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L20"><code>main.tf#L20</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"tls_private_key.ssh_key":end -->

## Variables
  
<blockquote><!-- variable:"hostname":start -->

### `hostname` (**Required**)

Container host name

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L18"><code>variables.tf#L18</code></a>

</details>
</blockquote><!-- variable:"hostname":end -->
<blockquote><!-- variable:"ni_gateway":start -->

### `ni_gateway` (**Required**)

Network interface gateway

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L132"><code>variables.tf#L132</code></a>

</details>
</blockquote><!-- variable:"ni_gateway":end -->
<blockquote><!-- variable:"ni_ip":start -->

### `ni_ip` (**Required**)

Network interface IP address

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L126"><code>variables.tf#L126</code></a>

</details>
</blockquote><!-- variable:"ni_ip":end -->
<blockquote><!-- variable:"ni_mac_address":start -->

### `ni_mac_address` (**Required**)

Network interface MAC address

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L138"><code>variables.tf#L138</code></a>

</details>
</blockquote><!-- variable:"ni_mac_address":end -->
<blockquote><!-- variable:"proxmox":start -->

### `proxmox` (**Required**)

Proxmox host configuration

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    name     = string
    host     = string
    ssh_user = string
    ssh_key  = string
  })
  ```
  In file: <a href="./variables.tf#L2"><code>variables.tf#L2</code></a>

</details>
</blockquote><!-- variable:"proxmox":end -->
<blockquote><!-- variable:"vm_id":start -->

### `vm_id` (**Required**)

Container (VM)ID

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  number
  ```
  In file: <a href="./variables.tf#L12"><code>variables.tf#L12</code></a>

</details>
</blockquote><!-- variable:"vm_id":end -->
<blockquote><!-- variable:"alpine_image":start -->

### `alpine_image` (*Optional*)

Alpine image configuration

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    url                = string
    checksum           = string
    checksum_algorithm = string
  })
  ```
  **Default**:
  ```json
  {
  "checksum": "211ac75f4b66494e78a6e72acc206b8ac490e0d174a778ae5be2970b0a1a57a8dddea8fc5880886a3794b8bb787fe93297a1cad3aee75d07623d8443ea9062e4",
  "checksum_algorithm": "sha512",
  "url": "http://download.proxmox.com/images/system/alpine-3.21-default_20241217_amd64.tar.xz"
}
  ```
  In file: <a href="./variables.tf#L36"><code>variables.tf#L36</code></a>

</details>
</blockquote><!-- variable:"alpine_image":end -->
<blockquote><!-- variable:"cpu_cores":start -->

### `cpu_cores` (*Optional*)

Amount of CPU (v)cores; SMT/HT cores count as cores.

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  number
  ```
  **Default**:
  ```json
  1
  ```
  In file: <a href="./variables.tf#L69"><code>variables.tf#L69</code></a>

</details>
</blockquote><!-- variable:"cpu_cores":end -->
<blockquote><!-- variable:"cpu_units":start -->

### `cpu_units` (*Optional*)

CPU scheduler priority relative to other containers; higher values mean more CPU time when under contention.

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  number
  ```
  **Default**:
  ```json
  100
  ```
  In file: <a href="./variables.tf#L76"><code>variables.tf#L76</code></a>

</details>
</blockquote><!-- variable:"cpu_units":end -->
<blockquote><!-- variable:"description":start -->

### `description` (*Optional*)

Description of the container

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "Alpine Linux based LXC container"
  ```
  In file: <a href="./variables.tf#L24"><code>variables.tf#L24</code></a>

</details>
</blockquote><!-- variable:"description":end -->
<blockquote><!-- variable:"disk_size":start -->

### `disk_size` (*Optional*)

Size of the main container disk (in gigabytes)

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  number
  ```
  **Default**:
  ```json
  1
  ```
  In file: <a href="./variables.tf#L97"><code>variables.tf#L97</code></a>

</details>
</blockquote><!-- variable:"disk_size":end -->
<blockquote><!-- variable:"imagestore_id":start -->

### `imagestore_id` (*Optional*)

DataStore ID for the Alpine template

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "virt-assets"
  ```
  In file: <a href="./variables.tf#L90"><code>variables.tf#L90</code></a>

</details>
</blockquote><!-- variable:"imagestore_id":end -->
<blockquote><!-- variable:"memory_dedicated":start -->

### `memory_dedicated` (*Optional*)

RAM (in megabytes) dedicated to this container.

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  number
  ```
  **Default**:
  ```json
  1024
  ```
  In file: <a href="./variables.tf#L83"><code>variables.tf#L83</code></a>

</details>
</blockquote><!-- variable:"memory_dedicated":end -->
<blockquote><!-- variable:"mount_points":start -->

### `mount_points` (*Optional*)

List of mount points for the container

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(object({
    volume = string
    path   = string
  }))
  ```
  **Default**:
  ```json
  []
  ```
  In file: <a href="./variables.tf#L58"><code>variables.tf#L58</code></a>

</details>
</blockquote><!-- variable:"mount_points":end -->
<blockquote><!-- variable:"ni_bridge":start -->

### `ni_bridge` (*Optional*)

Network interface bridge

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "vmbr0"
  ```
  In file: <a href="./variables.tf#L158"><code>variables.tf#L158</code></a>

</details>
</blockquote><!-- variable:"ni_bridge":end -->
<blockquote><!-- variable:"ni_name":start -->

### `ni_name` (*Optional*)

Network interface name

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "eth0"
  ```
  In file: <a href="./variables.tf#L151"><code>variables.tf#L151</code></a>

</details>
</blockquote><!-- variable:"ni_name":end -->
<blockquote><!-- variable:"ni_subnet_mask":start -->

### `ni_subnet_mask` (*Optional*)

Network interface subnet mask in CIDR notation

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  number
  ```
  **Default**:
  ```json
  24
  ```
  In file: <a href="./variables.tf#L144"><code>variables.tf#L144</code></a>

</details>
</blockquote><!-- variable:"ni_subnet_mask":end -->
<blockquote><!-- variable:"packages":start -->

### `packages` (*Optional*)

List of packages to install on the container

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(string)
  ```
  **Default**:
  ```json
  [
  "bash",
  "curl",
  "ca-certificates"
]
  ```
  In file: <a href="./variables.tf#L51"><code>variables.tf#L51</code></a>

</details>
</blockquote><!-- variable:"packages":end -->
<blockquote><!-- variable:"startup_down_delay":start -->

### `startup_down_delay` (*Optional*)

Delay (in seconds) before next container is shutdown

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  number
  ```
  **Default**:
  ```json
  20
  ```
  In file: <a href="./variables.tf#L118"><code>variables.tf#L118</code></a>

</details>
</blockquote><!-- variable:"startup_down_delay":end -->
<blockquote><!-- variable:"startup_order":start -->

### `startup_order` (*Optional*)

Container startup order; shutdowns happen in reverse order

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  number
  ```
  **Default**:
  ```json
  1
  ```
  In file: <a href="./variables.tf#L104"><code>variables.tf#L104</code></a>

</details>
</blockquote><!-- variable:"startup_order":end -->
<blockquote><!-- variable:"startup_up_delay":start -->

### `startup_up_delay` (*Optional*)

Delay (in seconds) before next container is started

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  number
  ```
  **Default**:
  ```json
  20
  ```
  In file: <a href="./variables.tf#L111"><code>variables.tf#L111</code></a>

</details>
</blockquote><!-- variable:"startup_up_delay":end -->
<blockquote><!-- variable:"tags":start -->

### `tags` (*Optional*)

Tags

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(string)
  ```
  **Default**:
  ```json
  [
  "lxc",
  "alpine"
]
  ```
  In file: <a href="./variables.tf#L30"><code>variables.tf#L30</code></a>

</details>
</blockquote><!-- variable:"tags":end -->

## Outputs
  
<blockquote><!-- output:"root_password":start -->

#### `root_password`

Root password

In file: <a href="./outputs.tf#L2"><code>outputs.tf#L2</code></a>
</blockquote><!-- output:"root_password":end -->
<blockquote><!-- output:"ssh_private_key":start -->

#### `ssh_private_key`

Private SSH key

In file: <a href="./outputs.tf#L9"><code>outputs.tf#L9</code></a>
</blockquote><!-- output:"ssh_private_key":end -->