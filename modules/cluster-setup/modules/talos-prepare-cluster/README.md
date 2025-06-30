# Prepare Talos cluster

Creates the Talos machine secrets and the Talos client configuration.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Execution story](#execution-story)
- [Resources](#resources)
  - _talos_machine_secrets_.[this](#talos_machine_secretsthis)
- [Variables](#variables)
  - [cluster_name](#cluster_name-required) (**Required**)
  - [nodes](#nodes-required) (**Required**)
  - [talos_linux_version](#talos_linux_version-required) (**Required**)
- [Outputs](#outputs)
  - [client_configuration](#client_configuration)
  - [machine_secrets](#machine_secrets)
  - [talos_config](#talos_config)
</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_talos"></a> [talos](#provider\_talos) | 0.8.1 |

## Execution story

Order in which Terraform will create resources (and likely destroy them in reverse order):
```
├── talos_machine_secrets.this
```




## Resources
<blockquote>

#### _talos_machine_secrets_.`this`

  <table>
    <tr>
      <td>Provider</td>
      <td><code>talos (siderolabs/talos)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L7"><code>main.tf#L7</code></a></td>
    </tr>
  </table>
</blockquote>

## Variables
<blockquote>

### `cluster_name` (**Required**)
Cluster configuration

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

### `nodes` (**Required**)
Configuration for cluster nodes

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(object({
    machine_type = string
    ip           = string
  }))
  ```
  In file: <a href="./variables.tf#L13"><code>variables.tf#L13</code></a>

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
  In file: <a href="./variables.tf#L7"><code>variables.tf#L7</code></a>

</details>
</blockquote>


## Outputs
<blockquote>

#### `client_configuration`
Client configuration for Talos cluster

In file: <a href="./outputs.tf#L7"><code>outputs.tf#L7</code></a>
</blockquote>
<blockquote>

#### `machine_secrets`
Machine secrets for Talos cluster

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote>
<blockquote>

#### `talos_config`
Talos configuration file

In file: <a href="./outputs.tf#L13"><code>outputs.tf#L13</code></a>
</blockquote>