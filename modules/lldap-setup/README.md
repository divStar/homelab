
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Inputs](#inputs)
  - [proxmox](#proxmox-required) (**Required**)
  - [alpine_image](#alpine_image-optional) (*Optional*)
  - [lldap_bridge](#lldap_bridge-optional) (*Optional*)
  - [lldap_datastore_id](#lldap_datastore_id-optional) (*Optional*)
  - [lldap_description](#lldap_description-optional) (*Optional*)
  - [lldap_domain_cert](#lldap_domain_cert-optional) (*Optional*)
  - [lldap_gateway](#lldap_gateway-optional) (*Optional*)
  - [lldap_hostname](#lldap_hostname-optional) (*Optional*)
  - [lldap_imagestore_id](#lldap_imagestore_id-optional) (*Optional*)
  - [lldap_ip](#lldap_ip-optional) (*Optional*)
  - [lldap_mac_address](#lldap_mac_address-optional) (*Optional*)
  - [lldap_ni_name](#lldap_ni_name-optional) (*Optional*)
  - [lldap_tags](#lldap_tags-optional) (*Optional*)
  - [lldap_vm_id](#lldap_vm_id-optional) (*Optional*)
  - [packages](#packages-optional) (*Optional*)
  - [proxmox_root_ca](#proxmox_root_ca-optional) (*Optional*)
- [Outputs](#outputs)
  - [resource](#resource)
    - [alpine_container](#alpine_container-proxmox_virtual_environment_container) (*proxmox_virtual_environment_container*)
    - [alpine_template](#alpine_template-proxmox_virtual_environment_download_file) (*proxmox_virtual_environment_download_file*)
    - [alpine_password](#alpine_password-random_password) (*random_password*)
    - [install_lldap](#install_lldap-ssh_resource) (*ssh_resource*)
    - [install_lldap_cert](#install_lldap_cert-ssh_resource) (*ssh_resource*)
    - [install_openssh](#install_openssh-ssh_resource) (*ssh_resource*)
    - [install_packages](#install_packages-ssh_resource) (*ssh_resource*)
    - [proxmox_ca_cert](#proxmox_ca_cert-ssh_resource) (*ssh_resource*)
    - [proxmox_ca_key](#proxmox_ca_key-ssh_resource) (*ssh_resource*)
    - [lldap_cert_request](#lldap_cert_request-tls_cert_request) (*tls_cert_request*)
    - [lldap_cert](#lldap_cert-tls_locally_signed_cert) (*tls_locally_signed_cert*)
    - [alpine_ssh_key](#alpine_ssh_key-tls_private_key) (*tls_private_key*)
    - [lldap_key](#lldap_key-tls_private_key) (*tls_private_key*)
  - [output](#output)
    - [alpine_container_id](#alpine_container_id)
    - [alpine_container_password](#alpine_container_password)
    - [alpine_container_private_key](#alpine_container_private_key)
    - [alpine_container_public_key](#alpine_container_public_key)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >= 0.69.0 |
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | ~> 2.7 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.75.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.1 |
| <a name="provider_ssh"></a> [ssh](#provider\_ssh) | 2.7.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.6 |

## Inputs
<blockquote>

### `proxmox` (**Required**)
Proxmox host configuration

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    object({
    name      = string
    host      = string
    port      = number
    endpoint  = string
    insecure  = bool
    api_token = string
    ssh_user  = string
    ssh_key   = string
  })
  ```
  Defined in file: `variables.tf#1`

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
  Defined in file: `variables.tf#15`

</details>
</blockquote>
<blockquote>

### `lldap_bridge` (*Optional*)
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
  Defined in file: `variables.tf#141`

</details>
</blockquote>
<blockquote>

### `lldap_datastore_id` (*Optional*)
LLDAP datastore ID

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    string
  ```
  **Default**:
  ```json
    "storage-pool"
  ```
  Defined in file: `variables.tf#99`

</details>
</blockquote>
<blockquote>

### `lldap_description` (*Optional*)
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
  Defined in file: `variables.tf#71`

</details>
</blockquote>
<blockquote>

### `lldap_domain_cert` (*Optional*)


<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    map
  ```
  **Default**:
  ```json
    {
  "dns_names": [
    "localhost",
    "lldap",
    "lldap.local",
    "lldap.my.world",
    "lldap.fritz.box"
  ],
  "ip_addresses": [
    "127.0.0.1",
    "::1",
    "192.168.178.155"
  ],
  "private_key": {
    "algorithm": "RSA",
    "rsa_bits": 4096
  },
  "subject": {
    "common_name": "lldap.my.world",
    "country": "DE",
    "locality": "Home Lab",
    "organization": "Home Network",
    "organizational_unit": "Authentication Services",
    "province": "Private Network"
  },
  "validity_period_hours": 78840
}
  ```
  Defined in file: `variables.tf#51`

</details>
</blockquote>
<blockquote>

### `lldap_gateway` (*Optional*)
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
  Defined in file: `variables.tf#127`

</details>
</blockquote>
<blockquote>

### `lldap_hostname` (*Optional*)
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
  Defined in file: `variables.tf#85`

</details>
</blockquote>
<blockquote>

### `lldap_imagestore_id` (*Optional*)
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
  Defined in file: `variables.tf#92`

</details>
</blockquote>
<blockquote>

### `lldap_ip` (*Optional*)
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
  Defined in file: `variables.tf#120`

</details>
</blockquote>
<blockquote>

### `lldap_mac_address` (*Optional*)
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
  Defined in file: `variables.tf#134`

</details>
</blockquote>
<blockquote>

### `lldap_ni_name` (*Optional*)
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
  Defined in file: `variables.tf#113`

</details>
</blockquote>
<blockquote>

### `lldap_tags` (*Optional*)
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
  Defined in file: `variables.tf#78`

</details>
</blockquote>
<blockquote>

### `lldap_vm_id` (*Optional*)
LLDAP VM ID

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    number
  ```
  **Default**:
  ```json
    695
  ```
  Defined in file: `variables.tf#106`

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
  Defined in file: `variables.tf#30`

</details>
</blockquote>
<blockquote>

### `proxmox_root_ca` (*Optional*)
Proxmox root CA certificate and key to use for the LLDAP admin UI

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    object({
    pve_root_cert = string
    pve_root_key  = string
  })
  ```
  **Default**:
  ```json
    {
  "pve_root_cert": "/etc/pve/pve-root-ca.pem",
  "pve_root_key": "/etc/pve/priv/pve-root-ca.key"
}
  ```
  Defined in file: `variables.tf#38`

</details>
</blockquote>

## Outputs
### `resource`
<blockquote>

#### `alpine_container` (_proxmox_virtual_environment_container_)
Defined in file: `create_container.tf#25`
</blockquote>
<blockquote>

#### `alpine_template` (_proxmox_virtual_environment_download_file_)
Defined in file: `create_container.tf#2`
</blockquote>
<blockquote>

#### `alpine_password` (_random_password_)
Defined in file: `create_container.tf#18`
</blockquote>
<blockquote>

#### `install_lldap` (_ssh_resource_)
Defined in file: `setup_lldap.tf#2`
</blockquote>
<blockquote>

#### `install_lldap_cert` (_ssh_resource_)
Defined in file: `setup_lldap_cert.tf#69`
</blockquote>
<blockquote>

#### `install_openssh` (_ssh_resource_)
Defined in file: `setup_container.tf#2`
</blockquote>
<blockquote>

#### `install_packages` (_ssh_resource_)
Defined in file: `setup_container.tf#37`
</blockquote>
<blockquote>

#### `proxmox_ca_cert` (_ssh_resource_)
Defined in file: `setup_lldap_cert.tf#2`
</blockquote>
<blockquote>

#### `proxmox_ca_key` (_ssh_resource_)
Defined in file: `setup_lldap_cert.tf#15`
</blockquote>
<blockquote>

#### `lldap_cert_request` (_tls_cert_request_)
Defined in file: `setup_lldap_cert.tf#34`
</blockquote>
<blockquote>

#### `lldap_cert` (_tls_locally_signed_cert_)
Defined in file: `setup_lldap_cert.tf#51`
</blockquote>
<blockquote>

#### `alpine_ssh_key` (_tls_private_key_)
Defined in file: `create_container.tf#12`
</blockquote>
<blockquote>

#### `lldap_key` (_tls_private_key_)
Defined in file: `setup_lldap_cert.tf#28`
</blockquote>

### `output`
<blockquote>

#### `alpine_container_id`
Alpine container ID

Defined in file: `outputs.tf#2`
</blockquote>
<blockquote>

#### `alpine_container_password`
Alpine SSH password

Defined in file: `outputs.tf#8`
</blockquote>
<blockquote>

#### `alpine_container_private_key`
Alpine SSH private key

Defined in file: `outputs.tf#15`
</blockquote>
<blockquote>

#### `alpine_container_public_key`
Alpine SSH public key

Defined in file: `outputs.tf#22`
</blockquote>