# PiHole Setup

This module sets up PiHole in an Alpine LXC container using the provided information.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules) _(nested and adjacent)_
  - [setup_certificate](#setup_certificate)
  - [setup_container](#setup_container)
- [Resources](#resources)
  - [admin_password](#admin_password-random_password) (*random_password*)
  - [configure](#configure-ssh_resource) (*ssh_resource*)
  - [install](#install-ssh_resource) (*ssh_resource*)
  - [install_cert](#install_cert-ssh_resource) (*ssh_resource*)
- [Variables](#variables)
  - [proxmox](#proxmox-required) (**Required**)
  - [admin_password](#admin_password-optional) (*Optional*)
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
  - [packages](#packages-optional) (*Optional*)
  - [startup_order](#startup_order-optional) (*Optional*)
  - [subject](#subject-optional) (*Optional*)
  - [tags](#tags-optional) (*Optional*)
  - [vm_id](#vm_id-optional) (*Optional*)
- [Outputs](#outputs)
  - [admin_password](#admin_password)
  - [admin_url](#admin_url)
  - [root_password](#root_password)
  - [ssh_private_key](#ssh_private_key)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >= 0.69.0 |
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | ~> 2.7 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.1 |
| <a name="provider_ssh"></a> [ssh](#provider\_ssh) | 2.7.0 |
## Modules
<blockquote>

### `setup_certificate`
Domain certificate setup
  <table>
    <tr>
      <td>Module location</td>
      <td><code>../common/modules/domain-cert-setup</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L36"><code>main.tf#L36</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="../common/modules/domain-cert-setup/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `setup_container`
Alpine LXC container setup
  <table>
    <tr>
      <td>Module location</td>
      <td><code>../common/modules/alpine-setup</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L12"><code>main.tf#L12</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="../common/modules/alpine-setup/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>


## Resources
<blockquote>

#### `admin_password` (_random_password_)
Create a random password for the PiHole admin web UI
  <table>
    <tr>
      <td>Provider</td>
      <td><code>random (hashicorp/random)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L51"><code>main.tf#L51</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `configure` (_ssh_resource_)
Configure PiHole
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L58"><code>main.tf#L58</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `install` (_ssh_resource_)
Install PiHole
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L78"><code>main.tf#L78</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `install_cert` (_ssh_resource_)
Install certificate
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L122"><code>main.tf#L122</code></a></td>
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

### `admin_password` (*Optional*)
PiHole Administrator password

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  null
  ```
  In file: <a href="./variables.tf#L191"><code>variables.tf#L191</code></a>

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
  "Alpine Linux based LXC container with PiHole"
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
  "pihole",
  "pi.hole",
  "pihole.local",
  "pihole.my.world",
  "pihole.fritz.box"
]
  ```
  In file: <a href="./variables.tf#L169"><code>variables.tf#L169</code></a>

</details>
</blockquote>
<blockquote>

### `hostname` (*Optional*)
PiHole host name

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "pihole"
  ```
  In file: <a href="./variables.tf#L22"><code>variables.tf#L22</code></a>

</details>
</blockquote>
<blockquote>

### `imagestore_id` (*Optional*)
PiHole imagestore ID

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
  In file: <a href="./variables.tf#L91"><code>variables.tf#L91</code></a>

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
  In file: <a href="./variables.tf#L149"><code>variables.tf#L149</code></a>

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
  In file: <a href="./variables.tf#L184"><code>variables.tf#L184</code></a>

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
  "192.168.178.150"
]
  ```
  In file: <a href="./variables.tf#L176"><code>variables.tf#L176</code></a>

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
    "path": "/etc/pihole",
    "volume": "/storage-pool/lxc-data/pihole-etc-pihole"
  },
  {
    "path": "/var/log/pihole",
    "volume": "/storage-pool/lxc-data/pihole-var-log-pihole"
  }
]
  ```
  In file: <a href="./variables.tf#L72"><code>variables.tf#L72</code></a>

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
  In file: <a href="./variables.tf#L141"><code>variables.tf#L141</code></a>

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
  In file: <a href="./variables.tf#L113"><code>variables.tf#L113</code></a>

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
  "192.168.178.150"
  ```
  In file: <a href="./variables.tf#L106"><code>variables.tf#L106</code></a>

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
  "3C:77:71:89:24:58"
  ```
  In file: <a href="./variables.tf#L120"><code>variables.tf#L120</code></a>

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
  In file: <a href="./variables.tf#L134"><code>variables.tf#L134</code></a>

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
  In file: <a href="./variables.tf#L127"><code>variables.tf#L127</code></a>

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
  "bind-tools",
  "binutils",
  "coreutils",
  "curl",
  "git",
  "grep",
  "iproute2-ss",
  "jq",
  "libcap",
  "logrotate",
  "ncurses",
  "nmap-ncat",
  "procps-ng",
  "psmisc",
  "shadow",
  "sudo",
  "tzdata",
  "unzip",
  "wget",
  "abuild",
  "build-base"
]
  ```
  In file: <a href="./variables.tf#L43"><code>variables.tf#L43</code></a>

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
  In file: <a href="./variables.tf#L98"><code>variables.tf#L98</code></a>

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
  "common_name": "pihole.my.world",
  "organization": "Home Network"
}
  ```
  In file: <a href="./variables.tf#L156"><code>variables.tf#L156</code></a>

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
PiHole VM ID

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  number
  ```
  **Default**:
  ```json
  700
  ```
  In file: <a href="./variables.tf#L15"><code>variables.tf#L15</code></a>

</details>
</blockquote>


## Outputs
<blockquote>

#### `admin_password`
Password for Pi-hole admin interface

In file: <a href="./outputs.tf#L16"><code>outputs.tf#L16</code></a>
</blockquote>
<blockquote>

#### `admin_url`
PiHole admin web UI URL

In file: <a href="./outputs.tf#L23"><code>outputs.tf#L23</code></a>
</blockquote>
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