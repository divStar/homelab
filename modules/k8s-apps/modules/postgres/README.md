# PostgreSQL

This module installs PostgreSQL (postgres) onto a given cluster.

> [!NOTE]
> In order to install this application successfully, the cluster is *required* to be configured properly.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Execution story](#execution-story)
- [Modules](#modules) _(nested and adjacent)_
  - [postgres](#postgres)
- [Variables](#variables)
  - [admin_password](#admin_password-required) (**Required**)
  - [user_password](#user_password-required) (**Required**)
  - [postgres_secret_name](#postgres_secret_name-optional) (*Optional*)
  - [user_name](#user_name-optional) (*Optional*)
  - [versions_yaml](#versions_yaml-optional) (*Optional*)
</blockquote><!-- contents:end -->

## Requirements
  
![terraform](https://img.shields.io/badge/terraform->=1.8.0-d3287d?logo=terraform)
![helm](https://img.shields.io/badge/helm->=3.0.1-a7fc51?logo=helm)
![kubectl](https://img.shields.io/badge/kubectl->=1.19.0-eb4095?logo=kubectl)

## Execution story

Order in which Terraform will create resources (and likely destroy them in reverse order):
```
├── module.postgres
│   ├── module.postgres.kubectl_manifest.namespace
│   ├── module.postgres.kubectl_manifest.pre_install
│   ├── module.postgres.helm_release.this
│   ├── module.postgres.kubectl_manifest.post_install
```

## Modules
  
<blockquote><!-- module:"postgres":start -->

### `postgres`

Installs [PostgreSQL (`postgres`)](https://github.com/bitnami/charts/tree/main/bitnami/postgresql), a database for other services to use.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>../../../common/modules/helm-terraform-installer</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L16"><code>main.tf#L16</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="../../../common/modules/helm-terraform-installer/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"postgres":end -->

## Variables
  
<blockquote><!-- variable:"admin_password":start -->

### `admin_password` (**Required**)

Password used as POSTGRES_ADMIN_PASSWORD

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L15"><code>variables.tf#L15</code></a>

</details>
</blockquote><!-- variable:"admin_password":end -->
<blockquote><!-- variable:"user_password":start -->

### `user_password` (**Required**)

Password used as POSTGRES_PASSWORD

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L29"><code>variables.tf#L29</code></a>

</details>
</blockquote><!-- variable:"user_password":end -->
<blockquote><!-- variable:"postgres_secret_name":start -->

### `postgres_secret_name` (*Optional*)

Name of the secret, that will contain the passwords

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "postgres-passwords"
  ```
  In file: <a href="./variables.tf#L8"><code>variables.tf#L8</code></a>

</details>
</blockquote><!-- variable:"postgres_secret_name":end -->
<blockquote><!-- variable:"user_name":start -->

### `user_name` (*Optional*)

Custom user, that will be created upon deployment

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "appuser"
  ```
  In file: <a href="./variables.tf#L22"><code>variables.tf#L22</code></a>

</details>
</blockquote><!-- variable:"user_name":end -->
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