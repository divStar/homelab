
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [proxmox_ca_cert](#proxmox_ca_cert-ssh_resource) (*ssh_resource*)
  - [proxmox_ca_key](#proxmox_ca_key-ssh_resource) (*ssh_resource*)
  - [cert_request](#cert_request-tls_cert_request) (*tls_cert_request*)
  - [cert](#cert-tls_locally_signed_cert) (*tls_locally_signed_cert*)
  - [key](#key-tls_private_key) (*tls_private_key*)
- [Variables](#variables)
  - [dns_names](#dns_names-required) (**Required**)
  - [ip_addresses](#ip_addresses-required) (**Required**)
  - [proxmox](#proxmox-required) (**Required**)
  - [subject](#subject-required) (**Required**)
  - [allowed_uses](#allowed_uses-optional) (*Optional*)
  - [early_renewal_hours](#early_renewal_hours-optional) (*Optional*)
  - [private_key](#private_key-optional) (*Optional*)
  - [proxmox_root_ca](#proxmox_root_ca-optional) (*Optional*)
  - [validity_period_hours](#validity_period_hours-optional) (*Optional*)
- [Outputs](#outputs)
  - [ca_cert_pem](#ca_cert_pem)
  - [cert_pem](#cert_pem)
  - [key_pem](#key_pem)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | ~> 2.7 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_ssh"></a> [ssh](#provider\_ssh) | ~> 2.7 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |


## Resources
<blockquote>

#### `proxmox_ca_cert` (_ssh_resource_)
In file: `main.tf#2`
</blockquote>
<blockquote>

#### `proxmox_ca_key` (_ssh_resource_)
In file: `main.tf#15`
</blockquote>
<blockquote>

#### `cert_request` (_tls_cert_request_)
In file: `main.tf#34`
</blockquote>
<blockquote>

#### `cert` (_tls_locally_signed_cert_)
In file: `main.tf#47`
</blockquote>
<blockquote>

#### `key` (_tls_private_key_)
In file: `main.tf#28`
</blockquote>

## Variables
<blockquote>

### `dns_names` (**Required**)
DNS names for the certificate

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(string)
  ```
  In file: `variables.tf#38`

</details>
</blockquote>
<blockquote>

### `ip_addresses` (**Required**)
IP addresses for the certificate

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(string)
  ```
  In file: `variables.tf#44`

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
    host     = string
    ssh_user = string
    ssh_key  = string
  })
  ```
  In file: `variables.tf#1`

</details>
</blockquote>
<blockquote>

### `subject` (**Required**)
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
  In file: `variables.tf#27`

</details>
</blockquote>
<blockquote>

### `allowed_uses` (*Optional*)
Allowed uses of the certificate

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(string)
  ```
  **Default**:
  ```json
  [
  "key_encipherment",
  "digital_signature",
  "server_auth",
  "client_auth"
]
  ```
  In file: `variables.tf#66`

</details>
</blockquote>
<blockquote>

### `early_renewal_hours` (*Optional*)
Early renewal period in hours for the certificate

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  number
  ```
  **Default**:
  ```json
  720
  ```
  In file: `variables.tf#80`

</details>
</blockquote>
<blockquote>

### `private_key` (*Optional*)
Private key configuration for the certificate

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    algorithm = string
    rsa_bits  = number
  })
  ```
  **Default**:
  ```json
  {
  "algorithm": "RSA",
  "rsa_bits": 4096
}
  ```
  In file: `variables.tf#50`

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
  In file: `variables.tf#11`

</details>
</blockquote>
<blockquote>

### `validity_period_hours` (*Optional*)
Validity period in hours for the certificate

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  number
  ```
  **Default**:
  ```json
  8766
  ```
  In file: `variables.tf#73`

</details>
</blockquote>


## Outputs
<blockquote>

#### `ca_cert_pem`
Proxmox public CA certificate in PEM format, trimmed

In file: `outputs.tf#1`
</blockquote>
<blockquote>

#### `cert_pem`
Generated certificate in PEM format, trimmed

In file: `outputs.tf#11`
</blockquote>
<blockquote>

#### `key_pem`
Generated key in PEM format, trimmed

In file: `outputs.tf#6`
</blockquote>