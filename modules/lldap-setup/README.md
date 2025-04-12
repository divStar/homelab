
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules) _(nested and adjacent)_
  - [setup_certificate](#setup_certificate)
  - [setup_container](#setup_container)
- [Resources](#resources)
  - [install_cert](#install_cert-ssh_resource) (*ssh_resource*)
  - [install_lldap](#install_lldap-ssh_resource) (*ssh_resource*)
  - [preconfigure_lldap](#preconfigure_lldap-ssh_resource) (*ssh_resource*)
- [Variables](#variables)
  - [proxmox](#proxmox-required) (**Required**)
  - [bridge](#bridge-optional) (*Optional*)
  - [datastore_id](#datastore_id-optional) (*Optional*)
  - [description](#description-optional) (*Optional*)
  - [dns_names](#dns_names-optional) (*Optional*)
  - [gateway](#gateway-optional) (*Optional*)
  - [hostname](#hostname-optional) (*Optional*)
  - [imagestore_id](#imagestore_id-optional) (*Optional*)
  - [init_certificate](#init_certificate-optional) (*Optional*)
  - [init_configuration](#init_configuration-optional) (*Optional*)
  - [ip](#ip-optional) (*Optional*)
  - [ip_addresses](#ip_addresses-optional) (*Optional*)
  - [mac_address](#mac_address-optional) (*Optional*)
  - [mount_points](#mount_points-optional) (*Optional*)
  - [ni_name](#ni_name-optional) (*Optional*)
  - [subject](#subject-optional) (*Optional*)
  - [tags](#tags-optional) (*Optional*)
  - [vm_id](#vm_id-optional) (*Optional*)
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
| <a name="provider_ssh"></a> [ssh](#provider\_ssh) | 2.7.0 |
## Modules
<blockquote>

### `setup_certificate`


| | |
|:--- |:--- |
| Module location | `../common/domain-cert-setup`
| Called in file | `main.tf#18`
</blockquote>
<blockquote>

### `setup_container`


| | |
|:--- |:--- |
| Module location | `../common/alpine-setup`
| Called in file | `main.tf#1`
</blockquote>


## Resources
<blockquote>

#### `install_cert` (_ssh_resource_)
Defined in file: `main.tf#32`
</blockquote>
<blockquote>

#### `install_lldap` (_ssh_resource_)
Defined in file: `main.tf#85`
</blockquote>
<blockquote>

#### `preconfigure_lldap` (_ssh_resource_)
Defined in file: `main.tf#59`
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
  Defined in file: `variables.tf#1`

</details>
</blockquote>
<blockquote>

### `bridge` (*Optional*)
LLDAP bridge

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
  Defined in file: `variables.tf#85`

</details>
</blockquote>
<blockquote>

### `datastore_id` (*Optional*)
LLDAP datastore ID

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "/storage-pool/lxc-data"
  ```
  Defined in file: `variables.tf#43`

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
  Defined in file: `variables.tf#15`

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
  Defined in file: `variables.tf#129`

</details>
</blockquote>
<blockquote>

### `gateway` (*Optional*)
LLDAP gateway

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
  Defined in file: `variables.tf#71`

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
  Defined in file: `variables.tf#29`

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
  Defined in file: `variables.tf#36`

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
  Defined in file: `variables.tf#106`

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
  Defined in file: `variables.tf#144`

</details>
</blockquote>
<blockquote>

### `ip` (*Optional*)
LLDAP IP address

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
  Defined in file: `variables.tf#64`

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
  Defined in file: `variables.tf#136`

</details>
</blockquote>
<blockquote>

### `mac_address` (*Optional*)
LLDAP MAC address

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
  Defined in file: `variables.tf#78`

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
  Defined in file: `variables.tf#92`

</details>
</blockquote>
<blockquote>

### `ni_name` (*Optional*)
LLDAP network interface name

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
  Defined in file: `variables.tf#57`

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
  Defined in file: `variables.tf#113`

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
  Defined in file: `variables.tf#22`

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
  700
  ```
  Defined in file: `variables.tf#50`

</details>
</blockquote>


## Outputs
<blockquote>

#### `root_password`
Root password

Defined in file: `outputs.tf#2`
</blockquote>
<blockquote>

#### `ssh_private_key`
Private SSH key

Defined in file: `outputs.tf#9`
</blockquote>