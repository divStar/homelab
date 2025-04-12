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
In file: `main.tf#15`
</blockquote>
<blockquote>

#### `longhorn_namespace` (_kubectl_manifest_)
In file: `main.tf#7`
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
  In file: `variables.tf#11`

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
  In file: `variables.tf#1`

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
  In file: `variables.tf#6`

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
  In file: `variables.tf#16`

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
  In file: `variables.tf#23`

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
  In file: `variables.tf#44`

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
  In file: `variables.tf#30`

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
  In file: `variables.tf#37`

</details>
</blockquote>
