
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Inputs](#inputs)
  - [proxmox](#proxmox-required) (**Required**)
  - [alpine_image](#alpine_image-optional) (*Optional*)
  - [packages](#packages-optional) (*Optional*)
  - [pihole_admin_password](#pihole_admin_password-optional) (*Optional*)
  - [pihole_bridge](#pihole_bridge-optional) (*Optional*)
  - [pihole_datastore_id](#pihole_datastore_id-optional) (*Optional*)
  - [pihole_domain_cert](#pihole_domain_cert-optional) (*Optional*)
  - [pihole_gateway](#pihole_gateway-optional) (*Optional*)
  - [pihole_hostname](#pihole_hostname-optional) (*Optional*)
  - [pihole_imagestore_id](#pihole_imagestore_id-optional) (*Optional*)
  - [pihole_ip](#pihole_ip-optional) (*Optional*)
  - [pihole_mac_address](#pihole_mac_address-optional) (*Optional*)
  - [pihole_ni_name](#pihole_ni_name-optional) (*Optional*)
  - [pihole_vm_id](#pihole_vm_id-optional) (*Optional*)
  - [proxmox_root_ca](#proxmox_root_ca-optional) (*Optional*)
- [Outputs](#outputs)
  - [resource](#resource)
    - [alpine_container](#alpine_container-proxmox_virtual_environment_container) (*proxmox_virtual_environment_container*)
    - [alpine_template](#alpine_template-proxmox_virtual_environment_download_file) (*proxmox_virtual_environment_download_file*)
    - [alpine_password](#alpine_password-random_password) (*random_password*)
    - [pihole_admin](#pihole_admin-random_password) (*random_password*)
    - [install_openssh](#install_openssh-ssh_resource) (*ssh_resource*)
    - [install_packages](#install_packages-ssh_resource) (*ssh_resource*)
    - [install_pihole](#install_pihole-ssh_resource) (*ssh_resource*)
    - [install_pihole_cert](#install_pihole_cert-ssh_resource) (*ssh_resource*)
    - [proxmox_ca_cert](#proxmox_ca_cert-ssh_resource) (*ssh_resource*)
    - [proxmox_ca_key](#proxmox_ca_key-ssh_resource) (*ssh_resource*)
    - [pihole_cert_request](#pihole_cert_request-tls_cert_request) (*tls_cert_request*)
    - [pihole_cert](#pihole_cert-tls_locally_signed_cert) (*tls_locally_signed_cert*)
    - [alpine_ssh_key](#alpine_ssh_key-tls_private_key) (*tls_private_key*)
    - [pihole_key](#pihole_key-tls_private_key) (*tls_private_key*)
  - [output](#output)
    - [alpine_container_id](#alpine_container_id)
    - [alpine_container_password](#alpine_container_password)
    - [alpine_container_private_key](#alpine_container_private_key)
    - [alpine_container_public_key](#alpine_container_public_key)
    - [pihole_admin_password](#pihole_admin_password)
    - [pihole_admin_url](#pihole_admin_url)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >= 0.69.0 |
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | ~> 2.7 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.73.1 |
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
  Defined in file: `variables.tf#30`

</details>
</blockquote>
<blockquote>

### `pihole_admin_password` (*Optional*)
PiHole Administrator password

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
  Defined in file: `variables.tf#174`

</details>
</blockquote>
<blockquote>

### `pihole_bridge` (*Optional*)
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
  Defined in file: `variables.tf#167`

</details>
</blockquote>
<blockquote>

### `pihole_datastore_id` (*Optional*)
PiHole datastore ID

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
  Defined in file: `variables.tf#125`

</details>
</blockquote>
<blockquote>

### `pihole_domain_cert` (*Optional*)
PiHole domain certificate details

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    object({
    subject = object({
      common_name         = string
      organization        = string
      organizational_unit = string
      country             = string
      locality            = string
      province            = string
    })
    private_key = object({
      algorithm = string
      rsa_bits  = number
    })
    dns_names             = list(string)
    ip_addresses          = list(string)
    validity_period_hours = number
  })
  ```
  **Default**:
  ```json
    {
  "dns_names": [
    "pihole.my.world",
    "pihole.local",
    "pi.hole"
  ],
  "ip_addresses": [
    "192.168.178.150"
  ],
  "private_key": {
    "algorithm": "RSA",
    "rsa_bits": 4096
  },
  "subject": {
    "common_name": "pihole.my.world",
    "country": "DE",
    "locality": "Home Lab",
    "organization": "Home Network",
    "organizational_unit": "Network Services",
    "province": "Private Network"
  },
  "validity_period_hours": 78840
}
  ```
  Defined in file: `variables.tf#72`

</details>
</blockquote>
<blockquote>

### `pihole_gateway` (*Optional*)
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
  Defined in file: `variables.tf#153`

</details>
</blockquote>
<blockquote>

### `pihole_hostname` (*Optional*)
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
  Defined in file: `variables.tf#111`

</details>
</blockquote>
<blockquote>

### `pihole_imagestore_id` (*Optional*)
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
  Defined in file: `variables.tf#118`

</details>
</blockquote>
<blockquote>

### `pihole_ip` (*Optional*)
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
  Defined in file: `variables.tf#146`

</details>
</blockquote>
<blockquote>

### `pihole_mac_address` (*Optional*)
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
  Defined in file: `variables.tf#160`

</details>
</blockquote>
<blockquote>

### `pihole_ni_name` (*Optional*)
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
  Defined in file: `variables.tf#139`

</details>
</blockquote>
<blockquote>

### `pihole_vm_id` (*Optional*)
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
  Defined in file: `variables.tf#132`

</details>
</blockquote>
<blockquote>

### `proxmox_root_ca` (*Optional*)
Proxmox root CA certificate and key to use for the PiHole admin UI

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
  Defined in file: `variables.tf#59`

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

#### `pihole_admin` (_random_password_)
Defined in file: `setup_pihole.tf#6`
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

#### `install_pihole` (_ssh_resource_)
Defined in file: `setup_pihole.tf#13`
</blockquote>
<blockquote>

#### `install_pihole_cert` (_ssh_resource_)
Defined in file: `setup_pihole_cert.tf#69`
</blockquote>
<blockquote>

#### `proxmox_ca_cert` (_ssh_resource_)
Defined in file: `setup_pihole_cert.tf#2`
</blockquote>
<blockquote>

#### `proxmox_ca_key` (_ssh_resource_)
Defined in file: `setup_pihole_cert.tf#15`
</blockquote>
<blockquote>

#### `pihole_cert_request` (_tls_cert_request_)
Defined in file: `setup_pihole_cert.tf#34`
</blockquote>
<blockquote>

#### `pihole_cert` (_tls_locally_signed_cert_)
Defined in file: `setup_pihole_cert.tf#51`
</blockquote>
<blockquote>

#### `alpine_ssh_key` (_tls_private_key_)
Defined in file: `create_container.tf#12`
</blockquote>
<blockquote>

#### `pihole_key` (_tls_private_key_)
Defined in file: `setup_pihole_cert.tf#28`
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
<blockquote>

#### `pihole_admin_password`
Password for Pi-hole admin interface

Defined in file: `outputs.tf#28`
</blockquote>
<blockquote>

#### `pihole_admin_url`
PiHole admin web UI URL

Defined in file: `outputs.tf#35`
</blockquote>