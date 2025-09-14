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
  - [postgres_admin_password](#postgres_admin_password-required) (**Required**)
  - [postgres_password](#postgres_password-required) (**Required**)
  - [postgres_admin_user](#postgres_admin_user-optional) (*Optional*)
  - [postgres_database](#postgres_database-optional) (*Optional*)
  - [postgres_port](#postgres_port-optional) (*Optional*)
  - [postgres_service_name](#postgres_service_name-optional) (*Optional*)
  - [postgres_user](#postgres_user-optional) (*Optional*)
  - [versions_yaml](#versions_yaml-optional) (*Optional*)
- [Outputs](#outputs)
  - [zitadel_master_key](#zitadel_master_key)
</blockquote><!-- contents:end -->

## Requirements
  
![terraform](https://img.shields.io/badge/terraform->=1.8.0-d3287d?logo=terraform)
![helm](https://img.shields.io/badge/helm->=3.0.1-a7fc51?logo=helm)
![kubectl](https://img.shields.io/badge/kubectl->=1.19.0-eb4095?logo=kubectl)
![random](https://img.shields.io/badge/random->=3.7.2-82d72c?logo=random)

## Providers
  
![random](https://img.shields.io/badge/random-3.7.2-82d72c)

## Modules
  
<blockquote><!-- module:"zitadel":start -->

### `zitadel`

Install [Zitadel](https://github.com/zitadel/zitadel-charts) - an identity and access management solution.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>../../../common/modules/helm-terraform-installer</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L22"><code>main.tf#L22</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="../../../common/modules/helm-terraform-installer/README.md">README.md</a> <em>(experimental)</em></td>
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
      <td><a href="./main.tf#L16"><code>main.tf#L16</code></a></td>
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
<blockquote><!-- variable:"postgres_admin_password":start -->

### `postgres_admin_password` (**Required**)

PostgreSQL admin password

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L53"><code>variables.tf#L53</code></a>

</details>
</blockquote><!-- variable:"postgres_admin_password":end -->
<blockquote><!-- variable:"postgres_password":start -->

### `postgres_password` (**Required**)

PostgreSQL password for Zitadel user

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L41"><code>variables.tf#L41</code></a>

</details>
</blockquote><!-- variable:"postgres_password":end -->
<blockquote><!-- variable:"postgres_admin_user":start -->

### `postgres_admin_user` (*Optional*)

PostgreSQL admin username

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "postgres"
  ```
  In file: <a href="./variables.tf#L47"><code>variables.tf#L47</code></a>

</details>
</blockquote><!-- variable:"postgres_admin_user":end -->
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
  In file: <a href="./variables.tf#L29"><code>variables.tf#L29</code></a>

</details>
</blockquote><!-- variable:"postgres_database":end -->
<blockquote><!-- variable:"postgres_port":start -->

### `postgres_port` (*Optional*)

PostgreSQL port

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  number
  ```
  **Default**:
  ```json
  5432
  ```
  In file: <a href="./variables.tf#L23"><code>variables.tf#L23</code></a>

</details>
</blockquote><!-- variable:"postgres_port":end -->
<blockquote><!-- variable:"postgres_service_name":start -->

### `postgres_service_name` (*Optional*)

PostgreSQL service name (FQDN or service.namespace format)

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "postgres-release-postgresql.postgres.svc.cluster.local"
  ```
  In file: <a href="./variables.tf#L17"><code>variables.tf#L17</code></a>

</details>
</blockquote><!-- variable:"postgres_service_name":end -->
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
  In file: <a href="./variables.tf#L35"><code>variables.tf#L35</code></a>

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
  
<blockquote><!-- output:"zitadel_master_key":start -->

#### `zitadel_master_key`

Generated master key for Zitadel

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote><!-- output:"zitadel_master_key":end -->