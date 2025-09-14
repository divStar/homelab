# Platform Setup

This module sets up k8s applications, that are used as part of the platform.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules) _(nested and adjacent)_
  - [cnpg_operator](#cnpg_operator)
- [Variables](#variables)
  - [cluster](#cluster-required) (**Required**)
  - [root_ca_certificate](#root_ca_certificate-required) (**Required**)
  - [homelab_root](#homelab_root-optional) (*Optional*)
  - [relative_path_to_versions_yaml](#relative_path_to_versions_yaml-optional) (*Optional*)
</blockquote><!-- contents:end -->

## Requirements
  
![terraform](https://img.shields.io/badge/terraform->=1.8.0-d3287d?logo=terraform)

## Modules
  
<blockquote><!-- module:"cnpg_operator":start -->

### `cnpg_operator`

Installs [`CNPG operator`](https://github.com/cloudnative-pg/charts/tree/main/charts/cloudnative-pg) for PostgreSQL/PostGIS databases. **NOTE:** This does **not** set up a database as each service is responsible for managing its own PostgreSQL/PostGIS database.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/cnpg-operator</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L19"><code>main.tf#L19</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/cnpg-operator/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"cnpg_operator":end -->

## Variables
  
<blockquote><!-- variable:"cluster":start -->

### `cluster` (**Required**)

Cluster configuration

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    name    = string
    lb_cidr = string
    domain  = string
  })
  ```
  In file: <a href="./variables.tf#L8"><code>variables.tf#L8</code></a>

</details>
</blockquote><!-- variable:"cluster":end -->
<blockquote><!-- variable:"root_ca_certificate":start -->

### `root_ca_certificate` (**Required**)

Step CA root CA certificate.

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L24"><code>variables.tf#L24</code></a>

</details>
</blockquote><!-- variable:"root_ca_certificate":end -->
<blockquote><!-- variable:"homelab_root":start -->

### `homelab_root` (*Optional*)

Path to the gitops git repository root

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "~/Documents/homelab-tofu/"
  ```
  In file: <a href="./variables.tf#L1"><code>variables.tf#L1</code></a>

</details>
</blockquote><!-- variable:"homelab_root":end -->
<blockquote><!-- variable:"relative_path_to_versions_yaml":start -->

### `relative_path_to_versions_yaml` (*Optional*)

Relative path to the `versions.yaml` file; it's passed to sub-modules

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "../.."
  ```
  In file: <a href="./variables.tf#L17"><code>variables.tf#L17</code></a>

</details>
</blockquote><!-- variable:"relative_path_to_versions_yaml":end -->