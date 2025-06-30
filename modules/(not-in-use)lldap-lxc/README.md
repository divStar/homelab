# LLDAP Setup

This module sets up LLDAP in an Alpine LXC container using the provided information.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Execution story](#execution-story)
- [Modules](#modules) _(nested and adjacent)_
  - [setup_container](#setup_container)
- [Resources](#resources)
  - _ssh_resource_.[configure](#ssh_resourceconfigure)
  - _ssh_resource_.[install](#ssh_resourceinstall)
  - _ssh_resource_.[install_cert](#ssh_resourceinstall_cert)
- [Variables](#variables)
  - [proxmox](#proxmox-required) (**Required**)
  - [description](#description-optional) (*Optional*)
  - [dns_names](#dns_names-optional) (*Optional*)
  - [hostname](#hostname-optional) (*Optional*)
  - [imagestore_id](#imagestore_id-optional) (*Optional*)
  - [init_certificate](#init_certificate-optional) (*Optional*)
  - [init_configuration](#init_configuration-optional) (*Optional*)
  - [ip_addresses](#ip_addresses-optional) (*Optional*)
  - [mount_points](#mount_points-optional) (*Optional*)
  - [ni_bridge](#ni_bridge-optional) (*Optional*)
  - [ni_gateway](#ni_gateway-optional) (*Optional*)
  - [ni_ip](#ni_ip-optional) (*Optional*)
  - [ni_mac_address](#ni_mac_address-optional) (*Optional*)
  - [ni_name](#ni_name-optional) (*Optional*)
  - [ni_subnet_mask](#ni_subnet_mask-optional) (*Optional*)
  - [startup_order](#startup_order-optional) (*Optional*)
  - [subject](#subject-optional) (*Optional*)
  - [tags](#tags-optional) (*Optional*)
  - [vm_id](#vm_id-optional) (*Optional*)
- [Outputs](#outputs)
  - [root_password](#root_password)
  - [ssh_private_key](#ssh_private_key)
</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >= 0.75.0 |
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | ~> 2.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ssh"></a> [ssh](#provider\_ssh) | 2.7.0 |

## Execution story

Order in which Terraform will create resources (and likely destroy them in reverse order):
```
├── ssh_resource.configure
├── ssh_resource.install_cert
├── ssh_resource.install
├── module.setup_container
│   ├── module.setup_container.random_password.root_password
│   ├── module.setup_container.tls_private_key.ssh_key
│   ├── module.setup_container.proxmox_virtual_environment_download_file.template
│   ├── module.setup_container.proxmox_virtual_environment_container.container
│   ├── module.setup_container.ssh_resource.install_openssh
│   ├── module.setup_container.ssh_resource.install_packages
```

## Modules
<blockquote>

### `setup_container`
Alpine LXC container setup
  <table>
    <tr>
      <td>Module location</td>
      <td><code>../common/modules/alpine</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L8"><code>main.tf#L8</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="../common/modules/alpine/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>


## Resources
<blockquote>

#### _ssh_resource_.`configure`
Configure LLDAP
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L62"><code>main.tf#L62</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### _ssh_resource_.`install`
Install LLDAP
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L88"><code>main.tf#L88</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### _ssh_resource_.`install_cert`
Install the generated certificate
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L32"><code>main.tf#L32</code></a></td>
    </tr>
  </table>
</blockquote>

## Variables
<blockquote>

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
  "Alpine Linux based LXC container with LLDAP"
  ```
  In file: <a href="./variables.tf#L29"><code>variables.tf#L29</code></a>

</details>
</blockquote>
<blockquote>

### `dns_names` (*Optional*)
DNS names for the certificate

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(string)
  ```
  **Default**:
  ```json
  [
  "localhost",
  "lldap",
  "lldap.local",
  "lldap.my.world",
  "lldap.fritz.box"
]
  ```
  In file: <a href="./variables.tf#L134"><code>variables.tf#L134</code></a>

</details>
</blockquote>
<blockquote>

### `hostname` (*Optional*)
LLDAP host name

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "lldap"
  ```
  In file: <a href="./variables.tf#L22"><code>variables.tf#L22</code></a>

</details>
</blockquote>
<blockquote>

### `imagestore_id` (*Optional*)
LLDAP imagestore ID

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
  In file: <a href="./variables.tf#L56"><code>variables.tf#L56</code></a>

</details>
</blockquote>
<blockquote>

### `init_certificate` (*Optional*)
Initialize certificate as new (also needed for renewal)

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
  In file: <a href="./variables.tf#L114"><code>variables.tf#L114</code></a>

</details>
</blockquote>
<blockquote>

### `init_configuration` (*Optional*)
Initialize a new stock configuration

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
  In file: <a href="./variables.tf#L149"><code>variables.tf#L149</code></a>

</details>
</blockquote>
<blockquote>

### `ip_addresses` (*Optional*)
IP addresses for the certificate

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(string)
  ```
  **Default**:
  ```json
  [
  "127.0.0.1",
  "::1",
  "192.168.178.155"
]
  ```
  In file: <a href="./variables.tf#L141"><code>variables.tf#L141</code></a>

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
  [
  {
    "path": "/data",
    "volume": "/storage-pool/lxc-data/lldap-data"
  }
]
  ```
  In file: <a href="./variables.tf#L43"><code>variables.tf#L43</code></a>

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
  In file: <a href="./variables.tf#L106"><code>variables.tf#L106</code></a>

</details>
</blockquote>
<blockquote>

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
  In file: <a href="./variables.tf#L78"><code>variables.tf#L78</code></a>

</details>
</blockquote>
<blockquote>

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
  In file: <a href="./variables.tf#L71"><code>variables.tf#L71</code></a>

</details>
</blockquote>
<blockquote>

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
  In file: <a href="./variables.tf#L85"><code>variables.tf#L85</code></a>

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
  In file: <a href="./variables.tf#L99"><code>variables.tf#L99</code></a>

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
  In file: <a href="./variables.tf#L92"><code>variables.tf#L92</code></a>

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
  In file: <a href="./variables.tf#L63"><code>variables.tf#L63</code></a>

</details>
</blockquote>
<blockquote>

### `subject` (*Optional*)
Subject information for the certificate

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    common_name  = string
    organization = string
  })
  ```
  **Default**:
  ```json
  {
  "common_name": "lldap.my.world",
  "organization": "Home Network"
}
  ```
  In file: <a href="./variables.tf#L121"><code>variables.tf#L121</code></a>

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
  In file: <a href="./variables.tf#L36"><code>variables.tf#L36</code></a>

</details>
</blockquote>
<blockquote>

### `vm_id` (*Optional*)
LLDAP VM ID

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