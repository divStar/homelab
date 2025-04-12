# Install `longhorn`

Handles the setup of `longhorn` (storage solution for PV/PVCs).
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [longhorn](#longhorn-helm_release) (*helm_release*)
  - [longhorn_namespace](#longhorn_namespace-kubectl_manifest) (*kubectl_manifest*)
- [Variables](#variables)
  - [ca_issuer](#ca_issuer-required) (**Required**)
  - [chart_version](#chart_version-required) (**Required**)
  - [nodes_count](#nodes_count-required) (**Required**)
  - [name](#name-optional) (*Optional*)
  - [namespace](#namespace-optional) (*Optional*)
  - [service_host](#service_host-optional) (*Optional*)
  - [timeout](#timeout-optional) (*Optional*)
  - [values](#values-optional) (*Optional*)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.17.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.19.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm.deploying"></a> [helm.deploying](#provider\_helm.deploying) | >= 2.17.0 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.19.0 |


## Resources
<blockquote>

#### `longhorn` (_helm_release_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>helm (hashicorp/helm)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L15"><code>main.tf#L15</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `longhorn_namespace` (_kubectl_manifest_)

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

## Variables
<blockquote>

### `ca_issuer` (**Required**)
CA certificate issuer (for Certificate resource managed by cert-manager)

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

### `nodes_count` (**Required**)
Amount of nodes (usually worker nodes only); will be used for Longhorn replicaCount properties

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  number
  ```
  In file: <a href="./variables.tf#L6"><code>variables.tf#L6</code></a>

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
  "longhorn-release"
  ```
  In file: <a href="./variables.tf#L16"><code>variables.tf#L16</code></a>

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
  "longhorn-system"
  ```
  In file: <a href="./variables.tf#L23"><code>variables.tf#L23</code></a>

</details>
</blockquote>
<blockquote>

### `service_host` (*Optional*)
Host to expose the longhorn UI on, e.g. longhorn.my.domain

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "longhorn.my.world"
  ```
  In file: <a href="./variables.tf#L44"><code>variables.tf#L44</code></a>

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
  In file: <a href="./variables.tf#L30"><code>variables.tf#L30</code></a>

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
  In file: <a href="./variables.tf#L37"><code>variables.tf#L37</code></a>

</details>
</blockquote>
