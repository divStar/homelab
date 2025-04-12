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
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | >= 0.69.0 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | >= 0.7.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_talos"></a> [talos](#provider\_talos) | >= 0.7.0 |


## Resources
<blockquote>

#### `this` (_talos_cluster_kubeconfig_)
Defined in file: `main.tf#44`
</blockquote>
<blockquote>

#### `this` (_talos_machine_bootstrap_)
Defined in file: `main.tf#12`
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
    name          = string
    talos_version = string
    endpoint      = string
  })
  ```
  Defined in file: `variables.tf#1`

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
  Defined in file: `variables.tf#41`

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
  Defined in file: `variables.tf#15`

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
  Defined in file: `variables.tf#10`

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
  Defined in file: `variables.tf#20`

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
  Defined in file: `variables.tf#27`

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
  Defined in file: `variables.tf#34`

</details>
</blockquote>


## Outputs
<blockquote>

#### `kube_config`
Talos cluster kubeconfig

Defined in file: `outputs.tf#6`
</blockquote>
<blockquote>

#### `machine_config`
Talos machine configurations

Defined in file: `outputs.tf#1`
</blockquote>