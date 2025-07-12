# pgAdmin

This module installs pgAdmin onto a given cluster for PostgreSQL database administration.

> [!NOTE]
> In order to install this application successfully, the cluster is *required* to be configured properly.
> This module assumes you have a PostgreSQL instance running that pgAdmin can connect to.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Execution story](#execution-story)
- [Modules](#modules) _(nested and adjacent)_
  - [pgadmin](#pgadmin)
- [Variables](#variables)
  - [cluster](#cluster-required) (**Required**)
  - [pgadmin_password](#pgadmin_password-required) (**Required**)
  - [postgres_password](#postgres_password-required) (**Required**)
  - [postgres_username](#postgres_username-required) (**Required**)
  - [pgadmin_email](#pgadmin_email-optional) (*Optional*)
  - [pgadmin_secret_name](#pgadmin_secret_name-optional) (*Optional*)
  - [postgres_database](#postgres_database-optional) (*Optional*)
  - [postgres_port](#postgres_port-optional) (*Optional*)
  - [postgres_service_name](#postgres_service_name-optional) (*Optional*)
  - [versions_yaml](#versions_yaml-optional) (*Optional*)
</blockquote><!-- contents:end -->

## Requirements
  
![terraform](https://img.shields.io/badge/terraform->=1.8.0-d3287d?logo=terraform)
![helm](https://img.shields.io/badge/helm->=3.0.1-a7fc51?logo=helm)
![kubectl](https://img.shields.io/badge/kubectl->=1.19.0-eb4095?logo=kubectl)

## Execution story

Order in which Terraform will create resources (and likely destroy them in reverse order):
```
├── module.pgadmin
│   ├── module.pgadmin.kubectl_manifest.namespace
│   ├── module.pgadmin.kubectl_manifest.pre_install
│   ├── module.pgadmin.helm_release.this
│   ├── module.pgadmin.kubectl_manifest.post_install
```

## Modules
  
<blockquote><!-- module:"pgadmin":start -->

### `pgadmin`

Installs [pgAdmin 4](https://github.com/rowanruseler/helm-charts/tree/main/charts/pgadmin4), a web-based administration tool for PostgreSQL.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>../../../common/modules/helm-terraform-installer</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L17"><code>main.tf#L17</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="../../../common/modules/helm-terraform-installer/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"pgadmin":end -->

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
<blockquote><!-- variable:"pgadmin_password":start -->

### `pgadmin_password` (**Required**)

Password for the pgAdmin admin user

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L31"><code>variables.tf#L31</code></a>

</details>
</blockquote><!-- variable:"pgadmin_password":end -->
<blockquote><!-- variable:"postgres_password":start -->

### `postgres_password` (**Required**)

PostgreSQL password for pgAdmin to connect with

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L62"><code>variables.tf#L62</code></a>

</details>
</blockquote><!-- variable:"postgres_password":end -->
<blockquote><!-- variable:"postgres_username":start -->

### `postgres_username` (**Required**)

PostgreSQL username for pgAdmin to connect with

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L57"><code>variables.tf#L57</code></a>

</details>
</blockquote><!-- variable:"postgres_username":end -->
<blockquote><!-- variable:"pgadmin_email":start -->

### `pgadmin_email` (*Optional*)

Email address for the pgAdmin admin user

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "admin@my.world"
  ```
  In file: <a href="./variables.tf#L24"><code>variables.tf#L24</code></a>

</details>
</blockquote><!-- variable:"pgadmin_email":end -->
<blockquote><!-- variable:"pgadmin_secret_name":start -->

### `pgadmin_secret_name` (*Optional*)

Name of the secret, that will contain the passwords

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "pgadmin-passwords"
  ```
  In file: <a href="./variables.tf#L17"><code>variables.tf#L17</code></a>

</details>
</blockquote><!-- variable:"pgadmin_secret_name":end -->
<blockquote><!-- variable:"postgres_database":start -->

### `postgres_database` (*Optional*)

Default PostgreSQL database name

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
  In file: <a href="./variables.tf#L51"><code>variables.tf#L51</code></a>

</details>
</blockquote><!-- variable:"postgres_database":end -->
<blockquote><!-- variable:"postgres_port":start -->

### `postgres_port` (*Optional*)

PostgreSQL service port

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "5432"
  ```
  In file: <a href="./variables.tf#L45"><code>variables.tf#L45</code></a>

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
  In file: <a href="./variables.tf#L39"><code>variables.tf#L39</code></a>

</details>
</blockquote><!-- variable:"postgres_service_name":end -->
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