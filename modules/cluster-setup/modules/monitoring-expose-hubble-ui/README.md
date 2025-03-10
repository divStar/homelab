# Expose Hubble UI (Cilium)

Exposes the Hubble UI from Cilium CNI.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Inputs](#inputs)
  - [ca_issuer](#ca_issuer-required) (**Required**)
  - [service_host](#service_host-optional) (*Optional*)
- [Outputs](#outputs)
  - [resource](#resource)
    - [longhorn_namespace](#longhorn_namespace-kubectl_manifest) (*kubectl_manifest*)
  - [output](#output)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.19.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.19.0 |

## Inputs
<blockquote>

### `ca_issuer` (**Required**)
CA certificate issuer (for Certificate resource managed by cert-manager)

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    string
  ````
  Defined in file: `variables.tf#1`

</details>
</blockquote>
<blockquote>

### `service_host` (*Optional*)
Host to expose the hubble UI on, e.g. hubble.my.domain

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
    string
  ````
  **Default**:
  ```json
    "hubble.my.world"
  ```
  Defined in file: `variables.tf#6`

</details>
</blockquote>

## Outputs
### `resource`
<blockquote>

#### `longhorn_namespace` (_kubectl_manifest_)
Defined in file: `main.tf#7`
</blockquote>

### `output`