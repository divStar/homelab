# Update `pve-ssl` certificate with additional domain(s).

Handles fetching the Proxmox CA certificate and key,
generating the `pve-ssl` certificate with additional
domain(s) and IP(s) anew and copying of it back onto
the host.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [backup_existing_certs](#backup_existing_certs-ssh_resource) (*ssh_resource*)
  - [install_pve_cert](#install_pve_cert-ssh_resource) (*ssh_resource*)
  - [proxmox_ca_cert](#proxmox_ca_cert-ssh_resource) (*ssh_resource*)
  - [proxmox_ca_key](#proxmox_ca_key-ssh_resource) (*ssh_resource*)
  - [backup_timestamp](#backup_timestamp-time_static) (*time_static*)
  - [pve_ssl_cert_request](#pve_ssl_cert_request-tls_cert_request) (*tls_cert_request*)
  - [pve_ssl_cert](#pve_ssl_cert-tls_locally_signed_cert) (*tls_locally_signed_cert*)
  - [pve_ssl_key](#pve_ssl_key-tls_private_key) (*tls_private_key*)
- [Variables](#variables)
  - [proxmox_host](#proxmox_host-required) (**Required**)
  - [ssh](#ssh-required) (**Required**)
  - [proxmox_domain_cert](#proxmox_domain_cert-optional) (*Optional*)
  - [proxmox_root_ca](#proxmox_root_ca-optional) (*Optional*)
- [Outputs](#outputs)
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


## Resources
<blockquote>

#### `backup_existing_certs` (_ssh_resource_)
Back up existing certificates
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L87"><code>main.tf#L87</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `install_pve_cert` (_ssh_resource_)
Install the new certificate and key on the Proxmox server
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L101"><code>main.tf#L101</code></a></td>
    </tr>
  </table>
</blockquote>
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
      <td><a href="./main.tf#L23"><code>main.tf#L23</code></a></td>
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
      <td><a href="./main.tf#L36"><code>main.tf#L36</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `backup_timestamp` (_time_static_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>time (hashicorp/time)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L20"><code>main.tf#L20</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `pve_ssl_cert_request` (_tls_cert_request_)
Create certificate request
  <table>
    <tr>
      <td>Provider</td>
      <td><code>tls (hashicorp/tls)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L55"><code>main.tf#L55</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `pve_ssl_cert` (_tls_locally_signed_cert_)
Sign the certificate with the CA
  <table>
    <tr>
      <td>Provider</td>
      <td><code>tls (hashicorp/tls)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L72"><code>main.tf#L72</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `pve_ssl_key` (_tls_private_key_)
Generate private key for the SSL certificate
  <table>
    <tr>
      <td>Provider</td>
      <td><code>tls (hashicorp/tls)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L49"><code>main.tf#L49</code></a></td>
    </tr>
  </table>
</blockquote>

## Variables
<blockquote>

### `proxmox_host` (**Required**)
Name of the target Proxmox host

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L14"><code>variables.tf#L14</code></a>

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
  In file: <a href="./variables.tf#L1"><code>variables.tf#L1</code></a>

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
    "sanctum.local",
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
  In file: <a href="./variables.tf#L32"><code>variables.tf#L32</code></a>

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
  In file: <a href="./variables.tf#L19"><code>variables.tf#L19</code></a>

</details>
</blockquote>


## Outputs
<blockquote>

#### `certificate_info`
pve-ssl Certificate information

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote>