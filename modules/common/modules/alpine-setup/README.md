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
  - [gateway](#gateway-required) (**Required**)
  - [hostname](#hostname-required) (**Required**)
  - [ip](#ip-required) (**Required**)
  - [mac_address](#mac_address-required) (**Required**)
  - [proxmox](#proxmox-required) (**Required**)
  - [vm_id](#vm_id-required) (**Required**)
  - [alpine_image](#alpine_image-optional) (*Optional*)
  - [bridge](#bridge-optional) (*Optional*)
  - [description](#description-optional) (*Optional*)
  - [imagestore_id](#imagestore_id-optional) (*Optional*)
  - [mount_points](#mount_points-optional) (*Optional*)
  - [ni_name](#ni_name-optional) (*Optional*)
  - [packages](#packages-optional) (*Optional*)
  - [subnet_mask](#subnet_mask-optional) (*Optional*)
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
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | >= 0.75.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_ssh"></a> [ssh](#provider\_ssh) | ~> 2.7 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |


## Resources
<blockquote>

#### `container` (_proxmox_virtual_environment_container_)
In file: `main.tf#33`
</blockquote>
<blockquote>

#### `template` (_proxmox_virtual_environment_download_file_)
In file: `main.tf#10`
</blockquote>
<blockquote>

#### `root_password` (_random_password_)
In file: `main.tf#26`
</blockquote>
<blockquote>

#### `install_openssh` (_ssh_resource_)
In file: `main.tf#117`
</blockquote>
<blockquote>

#### `install_packages` (_ssh_resource_)
In file: `main.tf#153`
</blockquote>
<blockquote>

#### `ssh_key` (_tls_private_key_)
In file: `main.tf#20`
</blockquote>

## Variables
<blockquote>

### `gateway` (**Required**)
Network interface gateway

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: `variables.tf#29`

</details>
</blockquote>
<blockquote>

### `hostname` (**Required**)
Container host name

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: `variables.tf#11`

</details>
</blockquote>
<blockquote>

### `ip` (**Required**)
Network interface IP address

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: `variables.tf#23`

</details>
</blockquote>
<blockquote>

### `mac_address` (**Required**)
Network interface MAC address

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: `variables.tf#35`

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
  In file: `variables.tf#1`

</details>
</blockquote>
<blockquote>

### `vm_id` (**Required**)
VM (Container) ID

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  number
  ```
  In file: `variables.tf#17`

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
  In file: `variables.tf#41`

</details>
</blockquote>
<blockquote>

### `bridge` (*Optional*)
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
  In file: `variables.tf#106`

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
  In file: `variables.tf#73`

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
  In file: `variables.tf#85`

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
  In file: `variables.tf#63`

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
  In file: `variables.tf#99`

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
  "bash"
]
  ```
  In file: `variables.tf#56`

</details>
</blockquote>
<blockquote>

### `subnet_mask` (*Optional*)
Subnet mask in CIDR notation

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
  In file: `variables.tf#92`

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
  In file: `variables.tf#79`

</details>
</blockquote>


## Outputs
<blockquote>

#### `root_password`
Root password

In file: `outputs.tf#2`
</blockquote>
<blockquote>

#### `ssh_private_key`
Private SSH key

In file: `outputs.tf#9`
</blockquote>