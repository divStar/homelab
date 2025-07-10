# Trust Proxmox CA certificate (add to trust store).

This module installs the already existing Proxmox CA to the Proxmox host's
own trust store and updates the certificates.

Note: this is necessary for the `lldap-setup` LXC container to connect
via LDAPS while also verifying the self-signed certificate.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Execution story](#execution-story)
- [Resources](#resources)
  - _ssh_resource_.[install_proxmox_ca](#ssh_resourceinstall_proxmox_ca)
  - _ssh_resource_.[restart_pveproxy](#ssh_resourcerestart_pveproxy)
  - _ssh_resource_.[uninstall_proxmox_ca](#ssh_resourceuninstall_proxmox_ca)
- [Variables](#variables)
  - [ssh](#ssh-required) (**Required**)
  - [pve_root_ca_pem_source](#pve_root_ca_pem_source-optional) (*Optional*)
  - [pve_root_ca_pem_target](#pve_root_ca_pem_target-optional) (*Optional*)
  - [restart_pveproxy](#restart_pveproxy-optional) (*Optional*)
</blockquote><!-- contents:end -->

## Requirements
  
![terraform](https://img.shields.io/badge/terraform->=1.8.0-d3287d?logo=terraform)
![ssh](https://img.shields.io/badge/ssh-~>2.7-4fa4f9?logo=ssh)

## Providers
  
![ssh](https://img.shields.io/badge/ssh-2.7.0-4fa4f9)

## Execution story

Order in which Terraform will create resources (and likely destroy them in reverse order):
```
├── ssh_resource.uninstall_proxmox_ca
├── ssh_resource.restart_pveproxy
├── ssh_resource.install_proxmox_ca
```

## Resources
  
<blockquote><!-- resource:"ssh_resource.install_proxmox_ca":start -->

### _ssh_resource_.`install_proxmox_ca`

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
</blockquote><!-- resource:"ssh_resource.install_proxmox_ca":end -->
<blockquote><!-- resource:"ssh_resource.restart_pveproxy":start -->

### _ssh_resource_.`restart_pveproxy`
      
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
</blockquote><!-- resource:"ssh_resource.restart_pveproxy":end -->
<blockquote><!-- resource:"ssh_resource.uninstall_proxmox_ca":start -->

### _ssh_resource_.`uninstall_proxmox_ca`
      
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
</blockquote><!-- resource:"ssh_resource.uninstall_proxmox_ca":end -->

## Variables
  
<blockquote><!-- variable:"ssh":start -->

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
</blockquote><!-- variable:"ssh":end -->
<blockquote><!-- variable:"pve_root_ca_pem_source":start -->

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
</blockquote><!-- variable:"pve_root_ca_pem_source":end -->
<blockquote><!-- variable:"pve_root_ca_pem_target":start -->

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
</blockquote><!-- variable:"pve_root_ca_pem_target":end -->
<blockquote><!-- variable:"restart_pveproxy":start -->

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
</blockquote><!-- variable:"restart_pveproxy":end -->