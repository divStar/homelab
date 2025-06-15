# Trust Proxmox CA certificate (add to trust store).

This module installs the already existing Proxmox CA to the Proxmox host's
own trust store and updates the certificates.

Note: this is necessary for the `lldap-setup` LXC container to connect
via LDAPS while also verifying the self-signed certificate.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [install_proxmox_ca](#install_proxmox_ca-ssh_resource) (*ssh_resource*)
  - [restart_pveproxy](#restart_pveproxy-ssh_resource) (*ssh_resource*)
  - [uninstall_proxmox_ca](#uninstall_proxmox_ca-ssh_resource) (*ssh_resource*)
- [Variables](#variables)
  - [ssh](#ssh-required) (**Required**)
  - [pve_root_ca_pem_source](#pve_root_ca_pem_source-optional) (*Optional*)
  - [pve_root_ca_pem_target](#pve_root_ca_pem_target-optional) (*Optional*)
  - [restart_pveproxy](#restart_pveproxy-optional) (*Optional*)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | ~> 2.7 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_ssh"></a> [ssh](#provider\_ssh) | ~> 2.7 |


## Resources
<blockquote>

#### `install_proxmox_ca` (_ssh_resource_)
Fetch Proxmox CA public certificate
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L11"><code>main.tf#L11</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `restart_pveproxy` (_ssh_resource_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L37"><code>main.tf#L37</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `uninstall_proxmox_ca` (_ssh_resource_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L24"><code>main.tf#L24</code></a></td>
    </tr>
  </table>
</blockquote>

## Variables
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

### `pve_root_ca_pem_source` (*Optional*)
Proxmox public root CA certificate source

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "/etc/pve/pve-root-ca.pem"
  ```
  In file: <a href="./variables.tf#L14"><code>variables.tf#L14</code></a>

</details>
</blockquote>
<blockquote>

### `pve_root_ca_pem_target` (*Optional*)
Proxmox public root CA certificate target

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "/usr/local/share/ca-certificates/pve-root-ca.crt"
  ```
  In file: <a href="./variables.tf#L21"><code>variables.tf#L21</code></a>

</details>
</blockquote>
<blockquote>

### `restart_pveproxy` (*Optional*)
Flag, specifying whether to restart the `pveproxy` service (`default = true`) or not.

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  bool
  ```
  **Default**:
  ```json
  true
  ```
  In file: <a href="./variables.tf#L28"><code>variables.tf#L28</code></a>

</details>
</blockquote>
