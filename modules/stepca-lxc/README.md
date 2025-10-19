# Step-CA Setup

This module sets up Step-CA in an Alpine LXC container using the provided information.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules) _(nested and adjacent)_
  - [setup_container](#setup_container)
- [Resources](#resources)
  - _ssh_resource_.[configure_container](#ssh_resourceconfigure_container)
  - _ssh_resource_.[configure_host](#ssh_resourceconfigure_host)
  - _ssh_resource_.[revert_host](#ssh_resourcerevert_host)
- [Variables](#variables)
  - [proxmox](#proxmox-required) (**Required**)
  - [acme_contact](#acme_contact-optional) (*Optional*)
  - [acme_name](#acme_name-optional) (*Optional*)
  - [acme_proxmox_domains](#acme_proxmox_domains-optional) (*Optional*)
  - [description](#description-optional) (*Optional*)
  - [fingerprint_file](#fingerprint_file-optional) (*Optional*)
  - [hostname](#hostname-optional) (*Optional*)
  - [imagestore_id](#imagestore_id-optional) (*Optional*)
  - [mount_points](#mount_points-optional) (*Optional*)
  - [ni_bridge](#ni_bridge-optional) (*Optional*)
  - [ni_gateway](#ni_gateway-optional) (*Optional*)
  - [ni_ip](#ni_ip-optional) (*Optional*)
  - [ni_mac_address](#ni_mac_address-optional) (*Optional*)
  - [ni_name](#ni_name-optional) (*Optional*)
  - [ni_subnet_mask](#ni_subnet_mask-optional) (*Optional*)
  - [skip_host_configuration](#skip_host_configuration-optional) (*Optional*)
  - [startup_order](#startup_order-optional) (*Optional*)
  - [tags](#tags-optional) (*Optional*)
  - [vm_id](#vm_id-optional) (*Optional*)
- [Outputs](#outputs)
  - [root_password](#root_password)
  - [ssh_private_key](#ssh_private_key)
</blockquote><!-- contents:end -->

## Requirements
![opentofu](https://img.shields.io/badge/OpenTofu->=1.10.5-d3287d?logo=opentofu)
![proxmox](https://img.shields.io/badge/proxmox->=0.78.1-1e73c8?logo=proxmox)
![ssh](https://img.shields.io/badge/ssh-~>2.7-4fa4f9?logo=ssh)

## Providers
  
![ssh](https://img.shields.io/badge/ssh-~>2.7-4fa4f9)

## Modules
  
<blockquote><!-- module:"setup_container":start -->

### `setup_container`

Alpine LXC container setup
  <table>
    <tr>
      <td>Module location</td>
      <td><code>../common/modules/alpine</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L14"><code>main.tf#L14</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="../common/modules/alpine/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"setup_container":end -->

## Resources
  
<blockquote><!-- resource:"ssh_resource.configure_container":start -->

### _ssh_resource_.`configure_container`

Configure Step-CA
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L38"><code>main.tf#L38</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"ssh_resource.configure_container":end -->
<blockquote><!-- resource:"ssh_resource.configure_host":start -->

### _ssh_resource_.`configure_host`

Configure ACME domain and order certificates
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L69"><code>main.tf#L69</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"ssh_resource.configure_host":end -->
<blockquote><!-- resource:"ssh_resource.revert_host":start -->

### _ssh_resource_.`revert_host`

ACME Cleanup on destroy
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L109"><code>main.tf#L109</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"ssh_resource.revert_host":end -->

## Variables
  
<blockquote><!-- variable:"proxmox":start -->

### `proxmox` (**Required**)

Proxmox host configuration

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    name          = string
    host          = string
    endpoint      = string
    insecure      = bool
    root_password = string
    ssh_user      = string
    ssh_key       = string
  })
  ```
  In file: <a href="./variables.tf#L2"><code>variables.tf#L2</code></a>

</details>
</blockquote><!-- variable:"proxmox":end -->
<blockquote><!-- variable:"acme_contact":start -->

### `acme_contact` (*Optional*)

E-Mail address of the ACME account in Proxmox

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "admin@my.world"
  ```
  In file: <a href="./variables.tf#L116"><code>variables.tf#L116</code></a>

</details>
</blockquote><!-- variable:"acme_contact":end -->
<blockquote><!-- variable:"acme_name":start -->

### `acme_name` (*Optional*)

ACME account name

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "step-ca-acme"
  ```
  In file: <a href="./variables.tf#L123"><code>variables.tf#L123</code></a>

</details>
</blockquote><!-- variable:"acme_name":end -->
<blockquote><!-- variable:"acme_proxmox_domains":start -->

### `acme_proxmox_domains` (*Optional*)

Proxmox ACME domains to order certificates for

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(string)
  ```
  **Default**:
  ```json
  [
  "sanctum.my.world",
  "sanctum.fritz.box"
]
  ```
  In file: <a href="./variables.tf#L130"><code>variables.tf#L130</code></a>

</details>
</blockquote><!-- variable:"acme_proxmox_domains":end -->
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
  "Alpine Linux based LXC container with Step-CA"
  ```
  In file: <a href="./variables.tf#L29"><code>variables.tf#L29</code></a>

</details>
</blockquote><!-- variable:"description":end -->
<blockquote><!-- variable:"fingerprint_file":start -->

### `fingerprint_file` (*Optional*)

File containing the fingerprint

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  ""
  ```
  In file: <a href="./variables.tf#L138"><code>variables.tf#L138</code></a>

</details>
</blockquote><!-- variable:"fingerprint_file":end -->
<blockquote><!-- variable:"hostname":start -->

### `hostname` (*Optional*)

Step-CA host name

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "step-ca"
  ```
  In file: <a href="./variables.tf#L22"><code>variables.tf#L22</code></a>

</details>
</blockquote><!-- variable:"hostname":end -->
<blockquote><!-- variable:"imagestore_id":start -->

### `imagestore_id` (*Optional*)

Step-CA imagestore ID

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "proxmox-resources"
  ```
  In file: <a href="./variables.tf#L58"><code>variables.tf#L58</code></a>

</details>
</blockquote><!-- variable:"imagestore_id":end -->
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
  [
  {
    "path": "/etc/step-ca",
    "volume": "/mnt/storage/service-configs/step-ca/step-lxc"
  }
]
  ```
  In file: <a href="./variables.tf#L43"><code>variables.tf#L43</code></a>

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
  In file: <a href="./variables.tf#L108"><code>variables.tf#L108</code></a>

</details>
</blockquote><!-- variable:"ni_bridge":end -->
<blockquote><!-- variable:"ni_gateway":start -->

### `ni_gateway` (*Optional*)

Network interface gateway

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "192.168.178.1"
  ```
  In file: <a href="./variables.tf#L80"><code>variables.tf#L80</code></a>

</details>
</blockquote><!-- variable:"ni_gateway":end -->
<blockquote><!-- variable:"ni_ip":start -->

### `ni_ip` (*Optional*)

Network interface IP address

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "192.168.178.155"
  ```
  In file: <a href="./variables.tf#L73"><code>variables.tf#L73</code></a>

</details>
</blockquote><!-- variable:"ni_ip":end -->
<blockquote><!-- variable:"ni_mac_address":start -->

### `ni_mac_address` (*Optional*)

Network interface MAC address

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "E8:31:0E:A5:D8:4C"
  ```
  In file: <a href="./variables.tf#L87"><code>variables.tf#L87</code></a>

</details>
</blockquote><!-- variable:"ni_mac_address":end -->
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
  In file: <a href="./variables.tf#L101"><code>variables.tf#L101</code></a>

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
  In file: <a href="./variables.tf#L94"><code>variables.tf#L94</code></a>

</details>
</blockquote><!-- variable:"ni_subnet_mask":end -->
<blockquote><!-- variable:"skip_host_configuration":start -->

### `skip_host_configuration` (*Optional*)

Controls whether the Proxmox host will be configured with ACME or not

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  bool
  ```
  **Default**:
  ```json
  false
  ```
  In file: <a href="./variables.tf#L145"><code>variables.tf#L145</code></a>

</details>
</blockquote><!-- variable:"skip_host_configuration":end -->
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
  In file: <a href="./variables.tf#L65"><code>variables.tf#L65</code></a>

</details>
</blockquote><!-- variable:"startup_order":end -->
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
  "alpine",
  "lxc"
]
  ```
  In file: <a href="./variables.tf#L36"><code>variables.tf#L36</code></a>

</details>
</blockquote><!-- variable:"tags":end -->
<blockquote><!-- variable:"vm_id":start -->

### `vm_id` (*Optional*)

Step-CA VM ID

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  number
  ```
  **Default**:
  ```json
  701
  ```
  In file: <a href="./variables.tf#L15"><code>variables.tf#L15</code></a>

</details>
</blockquote><!-- variable:"vm_id":end -->

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