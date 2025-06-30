# Install given Helm chart and additional resources if need be.

Handles installing a generic Helm Chart using `helm_release`,
supports custom resources during pre- and post-install.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [this](#this-helm_release) (*helm_release*)
  - [namespace](#namespace-kubectl_manifest) (*kubectl_manifest*)
  - [post_install](#post_install-kubectl_manifest) (*kubectl_manifest*)
  - [pre_install](#pre_install-kubectl_manifest) (*kubectl_manifest*)
- [Variables](#variables)
  - [chart_name](#chart_name-required) (**Required**)
  - [chart_repo](#chart_repo-required) (**Required**)
  - [chart_version](#chart_version-required) (**Required**)
  - [namespace](#namespace-required) (**Required**)
  - [release_name](#release_name-required) (**Required**)
  - [chart_timeout](#chart_timeout-optional) (*Optional*)
  - [chart_values](#chart_values-optional) (*Optional*)
  - [is_privileged_namespace](#is_privileged_namespace-optional) (*Optional*)
  - [post_install_resources](#post_install_resources-optional) (*Optional*)
  - [pre_install_resources](#pre_install_resources-optional) (*Optional*)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm.deploying"></a> [helm.deploying](#provider\_helm.deploying) | n/a |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | n/a |


## Resources
<blockquote>

#### `this` (_helm_release_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>helm (hashicorp/helm)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L26"><code>main.tf#L26</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `namespace` (_kubectl_manifest_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>kubectl (gavinbunney/kubectl)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L7"><code>main.tf#L7</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `post_install` (_kubectl_manifest_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>kubectl (gavinbunney/kubectl)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L52"><code>main.tf#L52</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `pre_install` (_kubectl_manifest_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>kubectl (gavinbunney/kubectl)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L16"><code>main.tf#L16</code></a></td>
    </tr>
  </table>
</blockquote>

## Variables
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

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
</blockquote>
<blockquote>

### `post_install_resources` (*Optional*)
List of resources to deploy before installing the application

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
  In file: <a href="./variables.tf#L60"><code>variables.tf#L60</code></a>

</details>
</blockquote>
<blockquote>

### `pre_install_resources` (*Optional*)
List of resources to deploy before installing the application

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
  In file: <a href="./variables.tf#L48"><code>variables.tf#L48</code></a>

</details>
</blockquote>
