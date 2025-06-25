# Install `local-path-provisioner`

Handles the setup of `local-path-provisioner` for local storage provisioning.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [local_path_provisioner](#local_path_provisioner-helm_release) (*helm_release*)
  - [local_path_provisioner_namespace](#local_path_provisioner_namespace-kubectl_manifest) (*kubectl_manifest*)
- [Variables](#variables)
  - [chart_version](#chart_version-required) (**Required**)
  - [default_storage_class](#default_storage_class-optional) (*Optional*)
  - [name](#name-optional) (*Optional*)
  - [namespace](#namespace-optional) (*Optional*)
  - [storage_path](#storage_path-optional) (*Optional*)
  - [timeout](#timeout-optional) (*Optional*)
  - [values](#values-optional) (*Optional*)</blockquote>

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

#### `local_path_provisioner` (_helm_release_)

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

#### `local_path_provisioner_namespace` (_kubectl_manifest_)

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

### `default_storage_class` (*Optional*)
Whether to set this as the default StorageClass

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
  In file: <a href="./variables.tf#L34"><code>variables.tf#L34</code></a>

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
  "local-path-provisioner"
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
  "local-path-storage"
  ```
  In file: <a href="./variables.tf#L13"><code>variables.tf#L13</code></a>

</details>
</blockquote>
<blockquote>

### `storage_path` (*Optional*)
Host path for local storage provisioning (Talos uses /var/mnt/local-path-provisioner)

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "/var/mnt/local-path-provisioner"
  ```
  In file: <a href="./variables.tf#L27"><code>variables.tf#L27</code></a>

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
  In file: <a href="./variables.tf#L41"><code>variables.tf#L41</code></a>

</details>
</blockquote>
