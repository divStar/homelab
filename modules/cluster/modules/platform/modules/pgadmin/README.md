# pgAdmin

This module installs pgAdmin onto a given cluster for PostgreSQL database administration.

> [!NOTE]
> In order to install this application successfully, the cluster is *required* to be configured properly.
> This module assumes you have a PostgreSQL instance running that pgAdmin can connect to.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules) _(nested and adjacent)_
  - [pgadmin](#pgadmin)
- [Resources](#resources)
  - _zitadel_application_oidc_.[this](#zitadel_application_oidcthis)
  - _zitadel_project_.[this](#zitadel_projectthis)
- [Variables](#variables)
  - [cluster](#cluster-required) (**Required**)
  - [relative_path_to_versions_yaml](#relative_path_to_versions_yaml-required) (**Required**)
  - [zitadel_orga_name](#zitadel_orga_name-required) (**Required**)
  - [pgadmin_configmap_name](#pgadmin_configmap_name-optional) (*Optional*)
  - [pgadmin_email](#pgadmin_email-optional) (*Optional*)
  - [pgadmin_secret_name](#pgadmin_secret_name-optional) (*Optional*)
  - [versions_yaml](#versions_yaml-optional) (*Optional*)
</blockquote><!-- contents:end -->

## Requirements
  
![terraform](https://img.shields.io/badge/terraform->=1.5.7-d3287d?logo=terraform)

## Providers
  
![zitadel](https://img.shields.io/badge/zitadel--ee4398)

## Modules
  
<blockquote><!-- module:"pgadmin":start -->

### `pgadmin`

Installs [pgAdmin 4](https://github.com/rowanruseler/helm-charts/tree/main/charts/pgadmin4), a web-based administration tool for PostgreSQL.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>../../../../../common/modules/helm-terraform-installer</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L47"><code>main.tf#L47</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="../../../../../common/modules/helm-terraform-installer/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"pgadmin":end -->

## Resources
  
<blockquote><!-- resource:"zitadel_application_oidc.this":start -->

### _zitadel_application_oidc_.`this`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>zitadel (zitadel/zitadel)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L32"><code>main.tf#L32</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"zitadel_application_oidc.this":end -->
<blockquote><!-- resource:"zitadel_project.this":start -->

### _zitadel_project_.`this`

Creates the `pgadmin` project within the given `var.zitadel_orga_name` organization.
  <table>
    <tr>
      <td>Provider</td>
      <td><code>zitadel (zitadel/zitadel)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L25"><code>main.tf#L25</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"zitadel_project.this":end -->

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
    domain  = string
    lb_cidr = string
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
  In file: <a href="./variables.tf#L17"><code>variables.tf#L17</code></a>

</details>
</blockquote><!-- variable:"relative_path_to_versions_yaml":end -->
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
<blockquote><!-- variable:"pgadmin_configmap_name":start -->

### `pgadmin_configmap_name` (*Optional*)

Name of the ConfigMap resource, that will contain the extra configuration

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "pgadmin4-extra-config"
  ```
  In file: <a href="./variables.tf#L30"><code>variables.tf#L30</code></a>

</details>
</blockquote><!-- variable:"pgadmin_configmap_name":end -->
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
  In file: <a href="./variables.tf#L37"><code>variables.tf#L37</code></a>

</details>
</blockquote><!-- variable:"pgadmin_email":end -->
<blockquote><!-- variable:"pgadmin_secret_name":start -->

### `pgadmin_secret_name` (*Optional*)

Name of the Secret resource, that will contain the passwords

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "pgadmin4-extra-secrets"
  ```
  In file: <a href="./variables.tf#L23"><code>variables.tf#L23</code></a>

</details>
</blockquote><!-- variable:"pgadmin_secret_name":end -->
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