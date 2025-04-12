# Install `cert-manager`

Handles the setup of `cert-manager`.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [cert_manager](#cert_manager-helm_release) (*helm_release*)
- [Variables](#variables)
  - [chart_version](#chart_version-required) (**Required**)
  - [name](#name-optional) (*Optional*)
  - [namespace](#namespace-optional) (*Optional*)
  - [timeout](#timeout-optional) (*Optional*)
  - [values](#values-optional) (*Optional*)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.17.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm.deploying"></a> [helm.deploying](#provider\_helm.deploying) | >= 2.17.0 |


## Resources
<blockquote>

#### `cert_manager` (_helm_release_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>helm (hashicorp/helm)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L7"><code>main.tf#L7</code></a></td>
    </tr>
  </table>
</blockquote>

## Variables
<blockquote>

### `chart_version` (**Required**)
Helm Chart version to install

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

### `name` (*Optional*)
Name of the Helm release

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "cert-manager-release"
  ```
  In file: <a href="./variables.tf#L6"><code>variables.tf#L6</code></a>

</details>
</blockquote>
<blockquote>

### `namespace` (*Optional*)
Kubernetes namespace to install into

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "cert-manager"
  ```
  In file: <a href="./variables.tf#L13"><code>variables.tf#L13</code></a>

</details>
</blockquote>
<blockquote>

### `timeout` (*Optional*)
Time in seconds to wait for the Helm Chart to be installed

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
  In file: <a href="./variables.tf#L20"><code>variables.tf#L20</code></a>

</details>
</blockquote>
<blockquote>

### `values` (*Optional*)
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
  In file: <a href="./variables.tf#L27"><code>variables.tf#L27</code></a>

</details>
</blockquote>
