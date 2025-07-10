# Talos cluster *await*

Awaits the Talos cluster to start up.

> [!NOTE]
> Since the cluster is starting up without a CNI (Flannel is disabled),
> *Kubernetes checks are skipped* ([`skip_kubernetes_checks = true`](./main.tf#L29)).

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Execution story](#execution-story)
- [Resources](#resources)
  - _talos_cluster_kubeconfig_.[this](#talos_cluster_kubeconfigthis)
  - _talos_machine_bootstrap_.[this](#talos_machine_bootstrapthis)
- [Variables](#variables)
  - [cluster](#cluster-required) (**Required**)
  - [nodes](#nodes-required) (**Required**)
  - [skip_kubernetes_checks](#skip_kubernetes_checks-required) (**Required**)
  - [talos_client_configuration](#talos_client_configuration-required) (**Required**)
  - [talos_linux_version](#talos_linux_version-required) (**Required**)
  - [talos_machine_secrets](#talos_machine_secrets-required) (**Required**)
  - [bootstrap_timeout](#bootstrap_timeout-optional) (*Optional*)
  - [health_check_timeout](#health_check_timeout-optional) (*Optional*)
  - [kubeconfig_timeout](#kubeconfig_timeout-optional) (*Optional*)
- [Outputs](#outputs)
  - [kube_config](#kube_config)
  - [machine_config](#machine_config)
</blockquote><!-- contents:end -->

## Requirements
  
![terraform](https://img.shields.io/badge/terraform->=1.8.0-d3287d?logo=terraform)

## Providers
  
![talos](https://img.shields.io/badge/talos-0.8.1-2479ce)

## Execution story

Order in which Terraform will create resources (and likely destroy them in reverse order):
```
├── talos_machine_bootstrap.this
├── talos_cluster_kubeconfig.this
```

## Resources
  
<blockquote><!-- resource:"talos_cluster_kubeconfig.this":start -->

### _talos_cluster_kubeconfig_.`this`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>talos (siderolabs/talos)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L48"><code>main.tf#L48</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"talos_cluster_kubeconfig.this":end -->
<blockquote><!-- resource:"talos_machine_bootstrap.this":start -->

### _talos_machine_bootstrap_.`this`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>talos (siderolabs/talos)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L16"><code>main.tf#L16</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"talos_machine_bootstrap.this":end -->

## Variables
  
<blockquote><!-- variable:"cluster":start -->

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
</blockquote><!-- variable:"cluster":end -->
<blockquote><!-- variable:"nodes":start -->

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
  In file: <a href="./variables.tf#L52"><code>variables.tf#L52</code></a>

</details>
</blockquote><!-- variable:"nodes":end -->
<blockquote><!-- variable:"skip_kubernetes_checks":start -->

### `skip_kubernetes_checks` (**Required**)

Skip Kubernetes checks when waiting

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  bool
  ```
  In file: <a href="./variables.tf#L25"><code>variables.tf#L25</code></a>

</details>
</blockquote><!-- variable:"skip_kubernetes_checks":end -->
<blockquote><!-- variable:"talos_client_configuration":start -->

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
</blockquote><!-- variable:"talos_client_configuration":end -->
<blockquote><!-- variable:"talos_linux_version":start -->

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
</blockquote><!-- variable:"talos_linux_version":end -->
<blockquote><!-- variable:"talos_machine_secrets":start -->

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
</blockquote><!-- variable:"talos_machine_secrets":end -->
<blockquote><!-- variable:"bootstrap_timeout":start -->

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
  In file: <a href="./variables.tf#L31"><code>variables.tf#L31</code></a>

</details>
</blockquote><!-- variable:"bootstrap_timeout":end -->
<blockquote><!-- variable:"health_check_timeout":start -->

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
  In file: <a href="./variables.tf#L38"><code>variables.tf#L38</code></a>

</details>
</blockquote><!-- variable:"health_check_timeout":end -->
<blockquote><!-- variable:"kubeconfig_timeout":start -->

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
  In file: <a href="./variables.tf#L45"><code>variables.tf#L45</code></a>

</details>
</blockquote><!-- variable:"kubeconfig_timeout":end -->

## Outputs
  
<blockquote><!-- output:"kube_config":start -->

#### `kube_config`

Talos cluster kubeconfig

In file: <a href="./outputs.tf#L6"><code>outputs.tf#L6</code></a>
</blockquote><!-- output:"kube_config":end -->
<blockquote><!-- output:"machine_config":start -->

#### `machine_config`

Talos machine configurations

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote><!-- output:"machine_config":end -->