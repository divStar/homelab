# Host Setup

This module and its sub-modules setup the Proxmox host.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules) _(nested and adjacent)_
  - [copy_configs](#copy_configs)
  - [directory_mappings](#directory_mappings)
  - [packages](#packages)
  - [repositories](#repositories)
  - [scripts](#scripts)
  - [share_user](#share_user)
  - [terraform_user](#terraform_user)
  - [trust_proxmox_ca](#trust_proxmox_ca)
  - [zfs_storage](#zfs_storage)
- [Variables](#variables)
  - [configuration_files](#configuration_files-required) (**Required**)
  - [proxmox_node_name](#proxmox_node_name-required) (**Required**)
  - [ssh](#ssh-required) (**Required**)
  - [directory_mappings](#directory_mappings-optional) (*Optional*)
  - [gitops_user](#gitops_user-optional) (*Optional*)
  - [no_subscription](#no_subscription-optional) (*Optional*)
  - [org_source_repo_owner](#org_source_repo_owner-optional) (*Optional*)
  - [packages](#packages-optional) (*Optional*)
  - [scripts](#scripts-optional) (*Optional*)
  - [share_user](#share_user-optional) (*Optional*)
  - [storage_pools](#storage_pools-optional) (*Optional*)
  - [terraform_user](#terraform_user-optional) (*Optional*)
- [Outputs](#outputs)
  - [configuration_files](#configuration_files)
  - [directory_mappings](#directory_mappings)
  - [installed_packages](#installed_packages)
  - [installed_scripts](#installed_scripts)
  - [no_subscription](#no_subscription)
  - [share_user](#share_user)
  - [storage_pools](#storage_pools)
  - [terraform_user](#terraform_user)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | ~> 2.7 |
| <a name="requirement_time"></a> [time](#requirement\_time) | >= 0.13.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 4.0.6 |
## Providers

No providers.
## Modules
<blockquote>

### `copy_configs`
Handles copying configuration files.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/copy-configs</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L37"><code>main.tf#L37</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/copy-configs/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `directory_mappings`
Handles mapping directories for future use (e.g. file sharing via `virtiofs` into VMs).
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/directory-mappings</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L86"><code>main.tf#L86</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/directory-mappings/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `packages`
Handles the installation of additional `apt` packages.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/packages</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L76"><code>main.tf#L76</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/packages/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `repositories`
Handles the deactivation of the enterprise `apt` repository and the activation of the `pve-no-subscription` `apt` repository.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/repositories</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L45"><code>main.tf#L45</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/repositories/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `scripts`
Handles the execution of various *non-interactive* scripts.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/scripts</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L53"><code>main.tf#L53</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/scripts/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `share_user`
Handles creating a share user.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/share-user</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L29"><code>main.tf#L29</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/share-user/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `terraform_user`
Handles the creation of a Terraform user and API token. This user can be used for various Proxmox interactions.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/terraform-user</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L21"><code>main.tf#L21</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/terraform-user/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `trust_proxmox_ca`
Handles letting Proxmox trust its own CA certificate.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/trust-proxmox-ca</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L69"><code>main.tf#L69</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/trust-proxmox-ca/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>
<blockquote>

### `zfs_storage`
Handles the import of ZFS pools.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/zfs-storage</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L61"><code>main.tf#L61</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/zfs-storage/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote>



## Variables
<blockquote>

### `configuration_files` (**Required**)
Configuration files to copy to the host

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(object({
    source      = string
    destination = string
    permissions = optional(number)
    owner       = optional(string)
    group       = optional(string)
  }))
  ```
  In file: <a href="./variables.tf#L19"><code>variables.tf#L19</code></a>

</details>
</blockquote>
<blockquote>

### `proxmox_node_name` (**Required**)
Proxmox node name

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

### `directory_mappings` (*Optional*)
Directory mappings for the Proxmox node

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(object({
    id      = string
    path    = string
    comment = optional(string, "")
  }))
  ```
  **Default**:
  ```json
  []
  ```
  In file: <a href="./variables.tf#L196"><code>variables.tf#L196</code></a>

</details>
</blockquote>
<blockquote>

### `gitops_user` (*Optional*)
Configuration of GitOps user.

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    user        = optional(string, "gitops")
    group       = optional(string, "gitops")
    repo_name   = optional(string, "repo")
    source_repo = optional(string, "/storage-pool/gitops")
  })
  ```
  **Default**:
  ```json
  {}
  ```
  In file: <a href="./variables.tf#L127"><code>variables.tf#L127</code></a>

</details>
</blockquote>
<blockquote>

### `no_subscription` (*Optional*)
Whether to use no-subscription repository instead of enterprise repository or not

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    enabled           = bool
    list_file         = optional(string, "pve-no-subscription.list")
    list_file_content = optional(string, "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription")
  })
  ```
  **Default**:
  ```json
  {
  "enabled": true
}
  ```
  In file: <a href="./variables.tf#L169"><code>variables.tf#L169</code></a>

</details>
</blockquote>
<blockquote>

### `org_source_repo_owner` (*Optional*)
Original owner of the source repository (before, e.g. root:root)

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    owner = optional(string, "root")
    group = optional(string, "root")
  })
  ```
  **Default**:
  ```json
  {}
  ```
  In file: <a href="./variables.tf#L139"><code>variables.tf#L139</code></a>

</details>
</blockquote>
<blockquote>

### `packages` (*Optional*)
List of packages to install via apt-get

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(string)
  ```
  **Default**:
  ```json
  []
  ```
  In file: <a href="./variables.tf#L35"><code>variables.tf#L35</code></a>

</details>
</blockquote>
<blockquote>

### `scripts` (*Optional*)
Configuration for script management including shared directory and script items

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    directory = optional(string, "scripts")
    items = list(object({
      name           = string
      url            = string
      apply_params   = optional(string, "")
      destroy_params = optional(string, "")
      run_on_destroy = optional(bool, true)
    }))
  })
  ```
  **Default**:
  ```json
  {
  "directory": "scripts",
  "items": []
}
  ```
  In file: <a href="./variables.tf#L42"><code>variables.tf#L42</code></a>

</details>
</blockquote>
<blockquote>

### `share_user` (*Optional*)
Configuration of GitOps user.

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    user  = string
    group = string
    uid   = number
    gid   = number
  })
  ```
  **Default**:
  ```json
  {
  "gid": 1400,
  "group": "share-users",
  "uid": 1400,
  "user": "share-user"
}
  ```
  In file: <a href="./variables.tf#L149"><code>variables.tf#L149</code></a>

</details>
</blockquote>
<blockquote>

### `storage_pools` (*Optional*)
Configuration of the storage (pools and directories) to import

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(string)
  ```
  **Default**:
  ```json
  []
  ```
  In file: <a href="./variables.tf#L190"><code>variables.tf#L190</code></a>

</details>
</blockquote>
<blockquote>

### `terraform_user` (*Optional*)
Configuration for Terraform provisioner user. Individual fields can be overridden.

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    name    = optional(string, "terraform@pve")
    comment = optional(string, "Terraform automation user")
    role = object({
      name = optional(string, "TerraformProv")
      privileges = optional(list(string), [
        "VM.Allocate",
        "VM.Clone",
        "VM.Audit",
        "VM.Config.HWType",
        "VM.Config.Disk",
        "VM.Config.CPU",
        "VM.Config.Memory",
        "VM.Config.Network",
        "VM.Config.Cloudinit",
        "VM.Config.Options",
        "VM.PowerMgmt",
        "VM.Monitor",
        "Datastore.Allocate",
        "Datastore.AllocateSpace",
        "Datastore.AllocateTemplate",
        "Datastore.Audit",
        "SDN.Use",
        "Sys.Audit",
        "Sys.Modify"
      ])
    })
    token = object({
      name    = optional(string, "terraform-token")
      comment = optional(string, "Terraform automation user API token")
    })
  })
  ```
  **Default**:
  ```json
  {
  "role": {},
  "token": {}
}
  ```
  In file: <a href="./variables.tf#L78"><code>variables.tf#L78</code></a>

</details>
</blockquote>


## Outputs
<blockquote>

#### `configuration_files`
Configuration files copied to host

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote>
<blockquote>

#### `directory_mappings`
List of directories mapped for further use in Proxmox

In file: <a href="./outputs.tf#L6"><code>outputs.tf#L6</code></a>
</blockquote>
<blockquote>

#### `installed_packages`
The packages, that have been installed/removed

In file: <a href="./outputs.tf#L11"><code>outputs.tf#L11</code></a>
</blockquote>
<blockquote>

#### `installed_scripts`
The scripts, that have been installed/removed

In file: <a href="./outputs.tf#L16"><code>outputs.tf#L16</code></a>
</blockquote>
<blockquote>

#### `no_subscription`
States, whether a no-subscription repository was used (and some further details)

In file: <a href="./outputs.tf#L21"><code>outputs.tf#L21</code></a>
</blockquote>
<blockquote>

#### `share_user`
The user to manage file shares on the Proxmox host storage

In file: <a href="./outputs.tf#L26"><code>outputs.tf#L26</code></a>
</blockquote>
<blockquote>

#### `storage_pools`
List of storage pools that were imported and added to Proxmox

In file: <a href="./outputs.tf#L35"><code>outputs.tf#L35</code></a>
</blockquote>
<blockquote>

#### `terraform_user`
The user and role created to manage the Proxmox host via Terraform/OpenTofu

In file: <a href="./outputs.tf#L40"><code>outputs.tf#L40</code></a>
</blockquote>