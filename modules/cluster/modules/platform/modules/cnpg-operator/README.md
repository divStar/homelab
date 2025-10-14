# CloudNative PostgreSQL

This module installs PostgreSQL (postgres) onto a given cluster.

> [!NOTE]
> In order to install this application successfully, the cluster is *required* to be configured properly.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules) _(nested and adjacent)_
  - [cnpg_operator](#cnpg_operator)
- [Variables](#variables)
  - [cluster](#cluster-required) (**Required**)
  - [relative_path_to_versions_yaml](#relative_path_to_versions_yaml-required) (**Required**)
</blockquote><!-- contents:end -->

## Requirements
  
![terraform](https://img.shields.io/badge/terraform->=1.5.7-d3287d?logo=terraform)

## Modules
  
<blockquote><!-- module:"cnpg_operator":start -->

### `cnpg_operator`

Installs [PostgreSQL (`postgres`)](https://github.com/bitnami/charts/tree/main/bitnami/postgresql), a database for other services to use.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>../../../../../common/modules/helm-terraform-installer</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L17"><code>main.tf#L17</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="../../../../../common/modules/helm-terraform-installer/README.md">README.md</a> <em>(experimental)</em></td>
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
  In file: <a href="./variables.tf#L1"><code>variables.tf#L1</code></a>

</details>
</blockquote><!-- variable:"cluster":end -->
<blockquote><!-- variable:"relative_path_to_versions_yaml":start -->

### `relative_path_to_versions_yaml` (**Required**)

Relative path to the `versions.yaml` file

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L10"><code>variables.tf#L10</code></a>

</details>
</blockquote><!-- variable:"relative_path_to_versions_yaml":end -->