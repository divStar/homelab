# Expose Hubble UI (Cilium)

Exposes the Hubble UI from Cilium CNI.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [longhorn_namespace](#longhorn_namespace-kubectl_manifest) (*kubectl_manifest*)
- [Variables](#variables)
  - [ca_issuer](#ca_issuer-required) (**Required**)
  - [service_host](#service_host-optional) (*Optional*)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.19.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.19.0 |


## Resources
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
  In file: <a href="./variables.tf#L1"><code>variables.tf#L1</code></a>

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
  ```
  **Default**:
  ```json
  "hubble.my.world"
  ```
  In file: <a href="./variables.tf#L6"><code>variables.tf#L6</code></a>

</details>
</blockquote>
