# Alpine LXC container setup

This module creates an Alpine LXC container on the Proxmox host,
generates a `root_password` and a `ssh_key`, installs `openssh` as well as
other Alpine packages (if specified; `bash` is installed by default).
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [container](#container-proxmox_virtual_environment_container) (*proxmox_virtual_environment_container*)
  - [template](#template-proxmox_virtual_environment_download_file) (*proxmox_virtual_environment_download_file*)
  - [root_password](#root_password-random_password) (*random_password*)
  - [install_openssh](#install_openssh-ssh_resource) (*ssh_resource*)
  - [install_packages](#install_packages-ssh_resource) (*ssh_resource*)
  - [ssh_key](#ssh_key-tls_private_key) (*tls_private_key*)
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
  - [ssh_private_key](#ssh_private_key)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >= 0.75.0 |
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | ~> 2.7 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.75.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.1 |
| <a name="provider_ssh"></a> [ssh](#provider\_ssh) | 2.7.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.6 |


## Resources
<blockquote>

#### `container` (_proxmox_virtual_environment_container_)
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
</blockquote>
<blockquote>

#### `template` (_proxmox_virtual_environment_download_file_)
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
</blockquote>
<blockquote>

#### `root_password` (_random_password_)
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
</blockquote>
<blockquote>

#### `install_openssh` (_ssh_resource_)
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
</blockquote>
<blockquote>

#### `install_packages` (_ssh_resource_)
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
</blockquote>
<blockquote>

#### `ssh_key` (_tls_private_key_)
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
</blockquote>

## Variables
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
  "images-host"
  ```
  In file: <a href="./variables.tf#L90"><code>variables.tf#L90</code></a>

</details>
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>


## Outputs
<blockquote>

#### `root_password`
Root password

In file: <a href="./outputs.tf#L2"><code>outputs.tf#L2</code></a>
</blockquote>
<blockquote>

#### `ssh_private_key`
Private SSH key

In file: <a href="./outputs.tf#L9"><code>outputs.tf#L9</code></a>
</blockquote>