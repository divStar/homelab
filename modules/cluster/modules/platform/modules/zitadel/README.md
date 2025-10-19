# Zitadel v3

This module installs Zitadel v3+ onto a given cluster with PostgreSQL backend.

> [!NOTE]
> Traefik handles TLS termination and `IngressRoute` service exposure.
> TLS is *not* used internally or between PostgreSQL database and Zitalde.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules) _(nested and adjacent)_
  - [zitadel](#zitadel)
- [Resources](#resources)
  - _random_password_.[zitadel_master_key](#random_passwordzitadel_master_key)
- [Variables](#variables)
  - [cluster](#cluster-required) (**Required**)
  - [relative_path_to_versions_yaml](#relative_path_to_versions_yaml-required) (**Required**)
  - [zitadel_admin_password](#zitadel_admin_password-required) (**Required**)
  - [zitadel_orga_name](#zitadel_orga_name-required) (**Required**)
  - [postgres_database](#postgres_database-optional) (*Optional*)
  - [postgres_user](#postgres_user-optional) (*Optional*)
  - [versions_yaml](#versions_yaml-optional) (*Optional*)
- [Outputs](#outputs)
  - [machine_user_key](#machine_user_key)
  - [zitadel_master_key](#zitadel_master_key)
</blockquote><!-- contents:end -->

## Requirements
![opentofu](https://img.shields.io/badge/OpenTofu->=1.10.5-d3287d?logo=opentofu)

## Providers
  
![kubernetes](https://img.shields.io/badge/kubernetes--398ee3)
![random](https://img.shields.io/badge/random--82d72c)

## Modules
  
<blockquote><!-- module:"zitadel":start -->

### `zitadel`

Install [Zitadel](https://github.com/zitadel/zitadel-charts) - an identity and access management solution.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>../../../../../common/modules/helm-terraform-installer</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L24"><code>main.tf#L24</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="../../../../../common/modules/helm-terraform-installer/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"zitadel":end -->

## Resources
  
<blockquote><!-- resource:"random_password.zitadel_master_key":start -->

### _random_password_.`zitadel_master_key`

Generate a secure master key for Zitadel symmetrical encryption
  <table>
    <tr>
      <td>Provider</td>
      <td><code>random (hashicorp/random)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L18"><code>main.tf#L18</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"random_password.zitadel_master_key":end -->

## Variables
  
<blockquote><!-- variable:"cluster":start -->

### `cluster` (**Required**)

Cluster configuration

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    name   = string
    domain = string
  })
  ```
  In file: <a href="./variables.tf#L8"><code>variables.tf#L8</code></a>

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
  In file: <a href="./variables.tf#L16"><code>variables.tf#L16</code></a>

</details>
</blockquote><!-- variable:"relative_path_to_versions_yaml":end -->
<blockquote><!-- variable:"zitadel_admin_password":start -->

### `zitadel_admin_password` (**Required**)

Password of the `zitadel-admin` user

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L38"><code>variables.tf#L38</code></a>

</details>
</blockquote><!-- variable:"zitadel_admin_password":end -->
<blockquote><!-- variable:"zitadel_orga_name":start -->

### `zitadel_orga_name` (**Required**)

Name of the organization in Zitadel

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L44"><code>variables.tf#L44</code></a>

</details>
</blockquote><!-- variable:"zitadel_orga_name":end -->
<blockquote><!-- variable:"postgres_database":start -->

### `postgres_database` (*Optional*)

PostgreSQL database name for Zitadel

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "zitadel"
  ```
  In file: <a href="./variables.tf#L23"><code>variables.tf#L23</code></a>

</details>
</blockquote><!-- variable:"postgres_database":end -->
<blockquote><!-- variable:"postgres_user":start -->

### `postgres_user` (*Optional*)

PostgreSQL username for Zitadel

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "zitadel"
  ```
  In file: <a href="./variables.tf#L30"><code>variables.tf#L30</code></a>

</details>
</blockquote><!-- variable:"postgres_user":end -->
<blockquote><!-- variable:"versions_yaml":start -->

### `versions_yaml` (*Optional*)

Absolute path and filename to the `versions.yaml` file, that contains all relevant Helm Chart descriptions and versions

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "../../../../versions.yaml"
  ```
  In file: <a href="./variables.tf#L1"><code>variables.tf#L1</code></a>

</details>
</blockquote><!-- variable:"versions_yaml":end -->

## Outputs
  
<blockquote><!-- output:"machine_user_key":start -->

#### `machine_user_key`

Key of the Zitadel Admin Service Account (FirstInstance)

In file: <a href="./outputs.tf#L7"><code>outputs.tf#L7</code></a>
</blockquote><!-- output:"machine_user_key":end -->
<blockquote><!-- output:"zitadel_master_key":start -->

#### `zitadel_master_key`

Generated master key for Zitadel

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote><!-- output:"zitadel_master_key":end -->