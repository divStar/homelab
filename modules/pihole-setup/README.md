
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules) _(nested and adjacent)_
  - [setup_certificate](#setup_certificate)
  - [setup_container](#setup_container)
- [Resources](#resources)
  - [admin_password](#admin_password-random_password) (*random_password*)
  - [install_cert](#install_cert-ssh_resource) (*ssh_resource*)
  - [install_pihole](#install_pihole-ssh_resource) (*ssh_resource*)
  - [preconfigure_pihole](#preconfigure_pihole-ssh_resource) (*ssh_resource*)
- [Variables](#variables)
  - [proxmox](#proxmox-required) (**Required**)
  - [admin_password](#admin_password-optional) (*Optional*)
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
  - [packages](#packages-optional) (*Optional*)
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


| | |
|:--- |:--- |
| Module location | `../common/modules/domain-cert-setup`
| In file | `main.tf#23`
<td colspan="2">

[`README.md`](../common/modules/domain-cert-setup/README.md) _(experimental)_
</td>
</blockquote>
<blockquote>

### `setup_container`


| | |
|:--- |:--- |
| Module location | `../common/modules/alpine-setup`
| In file | `main.tf#5`
<td colspan="2">

[`README.md`](../common/modules/alpine-setup/README.md) _(experimental)_
</td>
</blockquote>


## Resources
<blockquote>

#### `admin_password` (_random_password_)
In file: `main.tf#38`
</blockquote>
<blockquote>

#### `install_cert` (_ssh_resource_)
In file: `main.tf#109`
</blockquote>
<blockquote>

#### `install_pihole` (_ssh_resource_)
In file: `main.tf#65`
</blockquote>
<blockquote>

#### `preconfigure_pihole` (_ssh_resource_)
In file: `main.tf#45`
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
  In file: `variables.tf#1`

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
  In file: `variables.tf#186`

</details>
</blockquote>
<blockquote>

### `bridge` (*Optional*)
PiHole bridge

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
  In file: `variables.tf#114`

</details>
</blockquote>
<blockquote>

### `datastore_id` (*Optional*)
PiHole datastore ID

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
  In file: `variables.tf#72`

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
  In file: `variables.tf#15`

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
  In file: `variables.tf#164`

</details>
</blockquote>
<blockquote>

### `gateway` (*Optional*)
PiHole gateway

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
  In file: `variables.tf#100`

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
  In file: `variables.tf#58`

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
  In file: `variables.tf#65`

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
  In file: `variables.tf#141`

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
  In file: `variables.tf#179`

</details>
</blockquote>
<blockquote>

### `ip` (*Optional*)
PiHole IP address

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
  In file: `variables.tf#93`

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
  In file: `variables.tf#171`

</details>
</blockquote>
<blockquote>

### `mac_address` (*Optional*)
PiHole MAC address

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
  In file: `variables.tf#107`

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
  In file: `variables.tf#121`

</details>
</blockquote>
<blockquote>

### `ni_name` (*Optional*)
PiHole network interface name

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
  In file: `variables.tf#86`

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
  In file: `variables.tf#22`

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
  In file: `variables.tf#148`

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
  In file: `variables.tf#51`

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
  701
  ```
  In file: `variables.tf#79`

</details>
</blockquote>


## Outputs
<blockquote>

#### `admin_password`
Password for Pi-hole admin interface

In file: `outputs.tf#16`
</blockquote>
<blockquote>

#### `admin_url`
PiHole admin web UI URL

In file: `outputs.tf#23`
</blockquote>
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