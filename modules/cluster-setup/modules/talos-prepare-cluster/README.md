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
In file: `main.tf#7`
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
  In file: `variables.tf#1`

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
  In file: `variables.tf#9`

</details>
</blockquote>


## Outputs
<blockquote>

#### `client_configuration`
Client configuration for Talos cluster

In file: `outputs.tf#7`
</blockquote>
<blockquote>

#### `machine_secrets`
Machine secrets for Talos cluster

In file: `outputs.tf#1`
</blockquote>
<blockquote>

#### `talos_config`
Talos configuration file

In file: `outputs.tf#13`
</blockquote>