# Domain certificate setup

This module generates a domain certificate using the provided information.<br>
Note: it does _not_ output any files.
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
Fetch Proxmox CA public certificate
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L9"><code>main.tf#L9</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `proxmox_ca_key` (_ssh_resource_)
Fetch Proxmox CA key
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L22"><code>main.tf#L22</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `cert_request` (_tls_cert_request_)
Create certificate request
  <table>
    <tr>
      <td>Provider</td>
      <td><code>tls (hashicorp/tls)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L41"><code>main.tf#L41</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `cert` (_tls_locally_signed_cert_)
Sign the certificate with the CA
  <table>
    <tr>
      <td>Provider</td>
      <td><code>tls (hashicorp/tls)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L54"><code>main.tf#L54</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `key` (_tls_private_key_)
Define private key for the intermediate Kubernetes cluster certificate
  <table>
    <tr>
      <td>Provider</td>
      <td><code>tls (hashicorp/tls)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L35"><code>main.tf#L35</code></a></td>
    </tr>
  </table>
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
  In file: <a href="./variables.tf#L38"><code>variables.tf#L38</code></a>

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
  In file: <a href="./variables.tf#L44"><code>variables.tf#L44</code></a>

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
  In file: <a href="./variables.tf#L1"><code>variables.tf#L1</code></a>

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
  In file: <a href="./variables.tf#L27"><code>variables.tf#L27</code></a>

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
  In file: <a href="./variables.tf#L66"><code>variables.tf#L66</code></a>

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
  In file: <a href="./variables.tf#L80"><code>variables.tf#L80</code></a>

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
  In file: <a href="./variables.tf#L50"><code>variables.tf#L50</code></a>

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
  In file: <a href="./variables.tf#L11"><code>variables.tf#L11</code></a>

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
  In file: <a href="./variables.tf#L73"><code>variables.tf#L73</code></a>

</details>
</blockquote>


## Outputs
<blockquote>

#### `ca_cert_pem`
Proxmox public CA certificate in PEM format, trimmed

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote>
<blockquote>

#### `cert_pem`
Generated certificate in PEM format, trimmed

In file: <a href="./outputs.tf#L11"><code>outputs.tf#L11</code></a>
</blockquote>
<blockquote>

#### `key_pem`
Generated key in PEM format, trimmed

In file: <a href="./outputs.tf#L6"><code>outputs.tf#L6</code></a>
</blockquote>