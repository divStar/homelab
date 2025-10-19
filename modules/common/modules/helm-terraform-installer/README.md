# Common Helm installer module

Handles installing a Helm Chart using `helm_release`,
supports custom resources during pre- and post-install.

> [!NOTE]
> the CRDs *have to be present* when installing custom resources.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - _helm_release_.[this](#helm_releasethis)
  - _kubectl_manifest_.[namespace](#kubectl_manifestnamespace)
  - _kubectl_manifest_.[post_install](#kubectl_manifestpost_install)
  - _kubectl_manifest_.[pre_install](#kubectl_manifestpre_install)
- [Variables](#variables)
  - [chart_name](#chart_name-required) (**Required**)
  - [chart_repo](#chart_repo-required) (**Required**)
  - [chart_version](#chart_version-required) (**Required**)
  - [namespace](#namespace-required) (**Required**)
  - [release_name](#release_name-required) (**Required**)
  - [chart_timeout](#chart_timeout-optional) (*Optional*)
  - [chart_values](#chart_values-optional) (*Optional*)
  - [cleanup_on_fail](#cleanup_on_fail-optional) (*Optional*)
  - [is_atomic](#is_atomic-optional) (*Optional*)
  - [is_privileged_namespace](#is_privileged_namespace-optional) (*Optional*)
  - [post_install_resources](#post_install_resources-optional) (*Optional*)
  - [pre_install_resources](#pre_install_resources-optional) (*Optional*)
</blockquote><!-- contents:end -->

## Requirements
![opentofu](https://img.shields.io/badge/OpenTofu->=1.10.5-d3287d?logo=opentofu)

## Providers
  
![helm](https://img.shields.io/badge/helm--a7fc51)
![kubectl](https://img.shields.io/badge/kubectl--eb4095)

## Resources
  
<blockquote><!-- resource:"helm_release.this":start -->

### _helm_release_.`this`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>helm (hashicorp/helm)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L55"><code>main.tf#L55</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"helm_release.this":end -->
<blockquote><!-- resource:"kubectl_manifest.namespace":start -->

### _kubectl_manifest_.`namespace`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>kubectl (alekc/kubectl)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L10"><code>main.tf#L10</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"kubectl_manifest.namespace":end -->
<blockquote><!-- resource:"kubectl_manifest.post_install":start -->

### _kubectl_manifest_.`post_install`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>kubectl (alekc/kubectl)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L80"><code>main.tf#L80</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"kubectl_manifest.post_install":end -->
<blockquote><!-- resource:"kubectl_manifest.pre_install":start -->

### _kubectl_manifest_.`pre_install`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>kubectl (alekc/kubectl)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L19"><code>main.tf#L19</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"kubectl_manifest.pre_install":end -->

## Variables
  
<blockquote><!-- variable:"chart_name":start -->

### `chart_name` (**Required**)

Helm Chart to install

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L1"><code>variables.tf#L1</code></a>

</details>
</blockquote><!-- variable:"chart_name":end -->
<blockquote><!-- variable:"chart_repo":start -->

### `chart_repo` (**Required**)

Helm Chart repository

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L6"><code>variables.tf#L6</code></a>

</details>
</blockquote><!-- variable:"chart_repo":end -->
<blockquote><!-- variable:"chart_version":start -->

### `chart_version` (**Required**)

Helm Chart version

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L11"><code>variables.tf#L11</code></a>

</details>
</blockquote><!-- variable:"chart_version":end -->
<blockquote><!-- variable:"namespace":start -->

### `namespace` (**Required**)

Kubernetes namespace to install into

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L35"><code>variables.tf#L35</code></a>

</details>
</blockquote><!-- variable:"namespace":end -->
<blockquote><!-- variable:"release_name":start -->

### `release_name` (**Required**)

Name of the Helm release

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L16"><code>variables.tf#L16</code></a>

</details>
</blockquote><!-- variable:"release_name":end -->
<blockquote><!-- variable:"chart_timeout":start -->

### `chart_timeout` (*Optional*)

Time in seconds the Helm Chart installation times out after

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  number
  ```
  **Default**:
  ```json
  120
  ```
  In file: <a href="./variables.tf#L28"><code>variables.tf#L28</code></a>

</details>
</blockquote><!-- variable:"chart_timeout":end -->
<blockquote><!-- variable:"chart_values":start -->

### `chart_values` (*Optional*)

Additional values to pass to the helm chart (in YAML format)

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  ""
  ```
  In file: <a href="./variables.tf#L22"><code>variables.tf#L22</code></a>

</details>
</blockquote><!-- variable:"chart_values":end -->
<blockquote><!-- variable:"cleanup_on_fail":start -->

### `cleanup_on_fail` (*Optional*)

Specifies whether to clean up the `helm_release` if deployment fails; this setting is useful for debugging purposes

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
  In file: <a href="./variables.tf#L105"><code>variables.tf#L105</code></a>

</details>
</blockquote><!-- variable:"cleanup_on_fail":end -->
<blockquote><!-- variable:"is_atomic":start -->

### `is_atomic` (*Optional*)

Specifies whether `helm_release` will deploy in an 'atomic', revertible way

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
  In file: <a href="./variables.tf#L98"><code>variables.tf#L98</code></a>

</details>
</blockquote><!-- variable:"is_atomic":end -->
<blockquote><!-- variable:"is_privileged_namespace":start -->

### `is_privileged_namespace` (*Optional*)

Whether the Kubernetes namespace is a privileged namespace or not

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  bool
  ```
  **Default**:
  ```json
  false
  ```
  In file: <a href="./variables.tf#L41"><code>variables.tf#L41</code></a>

</details>
</blockquote><!-- variable:"is_privileged_namespace":end -->
<blockquote><!-- variable:"post_install_resources":start -->

### `post_install_resources` (*Optional*)

List of resources to deploy before installing the application

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(object({
    yaml = string
    wait_for = optional(object({
      fields = optional(list(object({
        key        = string
        value      = string
        value_type = optional(string, "eq")
      })), [])
      conditions = optional(list(object({
        type   = string
        status = string
      })), [])
    }))
  }))
  ```
  **Default**:
  ```json
  []
  ```
  In file: <a href="./variables.tf#L73"><code>variables.tf#L73</code></a>

</details>
</blockquote><!-- variable:"post_install_resources":end -->
<blockquote><!-- variable:"pre_install_resources":start -->

### `pre_install_resources` (*Optional*)

List of resources to deploy before installing the application

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(object({
    yaml = string
    wait_for = optional(object({
      fields = optional(list(object({
        key        = string
        value      = string
        value_type = optional(string, "eq")
      })), [])
      conditions = optional(list(object({
        type   = string
        status = string
      })), [])
    }))
  }))
  ```
  **Default**:
  ```json
  []
  ```
  In file: <a href="./variables.tf#L48"><code>variables.tf#L48</code></a>

</details>
</blockquote><!-- variable:"pre_install_resources":end -->