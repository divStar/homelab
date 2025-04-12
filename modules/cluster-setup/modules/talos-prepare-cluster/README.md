# Prepare Talos cluster

Creates the Talos machine secrets and the Talos client configuration.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [this](#this-talos_machine_secrets) (*talos_machine_secrets*)
- [Variables](#variables)
  - [cluster](#cluster-required) (**Required**)
  - [nodes](#nodes-required) (**Required**)
- [Outputs](#outputs)
  - [client_configuration](#client_configuration)
  - [machine_secrets](#machine_secrets)
  - [talos_config](#talos_config)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | >= 0.7.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_talos"></a> [talos](#provider\_talos) | >= 0.7.0 |


## Resources
<blockquote>

#### `this` (_talos_machine_secrets_)

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

### `cluster` (**Required**)
Cluster configuration

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    name          = string
    talos_version = string
  })
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
  In file: <a href="./variables.tf#L9"><code>variables.tf#L9</code></a>

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