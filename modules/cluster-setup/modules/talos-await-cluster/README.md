# Talos cluster *await*

Awaits the Talos cluster to become ready and running.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [this](#this-talos_cluster_kubeconfig) (*talos_cluster_kubeconfig*)
  - [this](#this-talos_machine_bootstrap) (*talos_machine_bootstrap*)
- [Variables](#variables)
  - [cluster](#cluster-required) (**Required**)
  - [nodes](#nodes-required) (**Required**)
  - [talos_client_configuration](#talos_client_configuration-required) (**Required**)
  - [talos_linux_version](#talos_linux_version-required) (**Required**)
  - [talos_machine_secrets](#talos_machine_secrets-required) (**Required**)
  - [bootstrap_timeout](#bootstrap_timeout-optional) (*Optional*)
  - [health_check_timeout](#health_check_timeout-optional) (*Optional*)
  - [kubeconfig_timeout](#kubeconfig_timeout-optional) (*Optional*)
- [Outputs](#outputs)
  - [kube_config](#kube_config)
  - [machine_config](#machine_config)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_talos"></a> [talos](#provider\_talos) | n/a |


## Resources
<blockquote>

#### `this` (_talos_cluster_kubeconfig_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>talos (siderolabs/talos)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L44"><code>main.tf#L44</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `this` (_talos_machine_bootstrap_)

  <table>
    <tr>
      <td>Provider</td>
      <td><code>talos (siderolabs/talos)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L12"><code>main.tf#L12</code></a></td>
    </tr>
  </table>
</blockquote>

## Variables
<blockquote>

### `cluster` (**Required**)
Cluster configuration

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    name     = string
    endpoint = string
  })
  ```
  In file: <a href="./variables.tf#L7"><code>variables.tf#L7</code></a>

</details>
</blockquote>
<blockquote>

### `nodes` (**Required**)
Configuration for cluster nodes

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(object({
    name         = string
    machine_type = string
    ip           = string
  }))
  ```
  In file: <a href="./variables.tf#L46"><code>variables.tf#L46</code></a>

</details>
</blockquote>
<blockquote>

### `talos_client_configuration` (**Required**)
Talos cluster client configuration

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  map(any)
  ```
  In file: <a href="./variables.tf#L20"><code>variables.tf#L20</code></a>

</details>
</blockquote>
<blockquote>

### `talos_linux_version` (**Required**)
Version of Talos (Linux/Kubernetes) to install

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

### `talos_machine_secrets` (**Required**)
Talos cluster machine configuration

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  any
  ```
  In file: <a href="./variables.tf#L15"><code>variables.tf#L15</code></a>

</details>
</blockquote>
<blockquote>

### `bootstrap_timeout` (*Optional*)
Cluster bootstrap timeout

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "5m"
  ```
  In file: <a href="./variables.tf#L25"><code>variables.tf#L25</code></a>

</details>
</blockquote>
<blockquote>

### `health_check_timeout` (*Optional*)
Cluster health-check timeout

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "10m"
  ```
  In file: <a href="./variables.tf#L32"><code>variables.tf#L32</code></a>

</details>
</blockquote>
<blockquote>

### `kubeconfig_timeout` (*Optional*)
Cluster kubeconfig creation timeout

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "1m"
  ```
  In file: <a href="./variables.tf#L39"><code>variables.tf#L39</code></a>

</details>
</blockquote>


## Outputs
<blockquote>

#### `kube_config`
Talos cluster kubeconfig

In file: <a href="./outputs.tf#L6"><code>outputs.tf#L6</code></a>
</blockquote>
<blockquote>

#### `machine_config`
Talos machine configurations

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote>