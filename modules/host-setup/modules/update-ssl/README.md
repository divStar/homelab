# Update `pve-ssl` certificate with additional domain(s).

Handles fetching the Proxmox CA certificate and key,
generating the `pve-ssl` certificate with additional
domain(s) and IP(s) anew and copying of it back onto
the host.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Inputs](#inputs)
  - [proxmox_host](#proxmox_host-required) (**Required**)
  - [ssh](#ssh-required) (**Required**)
  - [proxmox_domain_cert](#proxmox_domain_cert-optional) (*Optional*)
  - [proxmox_root_ca](#proxmox_root_ca-optional) (*Optional*)
- [Outputs](#outputs)
  - [resource](#resource)
    - [backup_existing_certs](#backup_existing_certs-ssh_resource) (*ssh_resource*)
    - [install_pve_cert](#install_pve_cert-ssh_resource) (*ssh_resource*)
    - [proxmox_ca_cert](#proxmox_ca_cert-ssh_resource) (*ssh_resource*)
    - [proxmox_ca_key](#proxmox_ca_key-ssh_resource) (*ssh_resource*)
    - [backup_timestamp](#backup_timestamp-time_static) (*time_static*)
    - [pve_ssl_cert_request](#pve_ssl_cert_request-tls_cert_request) (*tls_cert_request*)
    - [pve_ssl_cert](#pve_ssl_cert-tls_locally_signed_cert) (*tls_locally_signed_cert*)
    - [pve_ssl_key](#pve_ssl_key-tls_private_key) (*tls_private_key*)
  - [output](#output)
    - [certificate_info](#certificate_info)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | ~> 2.7 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.13.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0.6 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_ssh"></a> [ssh](#provider\_ssh) | ~> 2.7 |
| <a name="provider_time"></a> [time](#provider\_time) | >= 0.13.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 4.0.6 |

## Inputs
<blockquote>

### `proxmox_host` (**Required**)
Name of the target Proxmox host

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    string
  ```
  Defined in file: `variables.tf#14`

</details>
</blockquote>
<blockquote>

### `ssh` (**Required**)
SSH configuration for remote connection

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    object({
    host    = string
    user    = string
    id_file = optional(string, "~/.ssh/id_rsa")
  })
  ```
  Defined in file: `variables.tf#1`

</details>
</blockquote>
<blockquote>

### `proxmox_domain_cert` (*Optional*)
Proxmox certificate details

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
    "localhost",
    "sanctum",
    "sanctum.my.world",
    "sanctum.fritz.box"
  ],
  "ip_addresses": [
    "127.0.0.1",
    "192.168.178.27"
  ],
  "private_key": {
    "algorithm": "RSA",
    "rsa_bits": 2048
  },
  "subject": {
    "common_name": "sanctum.my.world",
    "country": "DE",
    "locality": "Home Lab",
    "organization": "Proxmox Virtual Environment",
    "organizational_unit": "PVE Cluster Node",
    "province": "Private Network"
  },
  "validity_period_hours": 78840
}
  ```
  Defined in file: `variables.tf#32`

</details>
</blockquote>
<blockquote>

### `proxmox_root_ca` (*Optional*)
Proxmox root CA certificate and key to use

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
  Defined in file: `variables.tf#19`

</details>
</blockquote>

## Outputs
### `resource`
<blockquote>

#### `backup_existing_certs` (_ssh_resource_)
Defined in file: `main.tf#87`
</blockquote>
<blockquote>

#### `install_pve_cert` (_ssh_resource_)
Defined in file: `main.tf#101`
</blockquote>
<blockquote>

#### `proxmox_ca_cert` (_ssh_resource_)
Defined in file: `main.tf#23`
</blockquote>
<blockquote>

#### `proxmox_ca_key` (_ssh_resource_)
Defined in file: `main.tf#36`
</blockquote>
<blockquote>

#### `backup_timestamp` (_time_static_)
Defined in file: `main.tf#20`
</blockquote>
<blockquote>

#### `pve_ssl_cert_request` (_tls_cert_request_)
Defined in file: `main.tf#55`
</blockquote>
<blockquote>

#### `pve_ssl_cert` (_tls_locally_signed_cert_)
Defined in file: `main.tf#72`
</blockquote>
<blockquote>

#### `pve_ssl_key` (_tls_private_key_)
Defined in file: `main.tf#49`
</blockquote>

### `output`
<blockquote>

#### `certificate_info`
Output the certificate details for verification

Defined in file: `outputs.tf#2`
</blockquote>