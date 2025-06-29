# Setup cert-manager ACME issuer

Handles the setup of cert-manager ACME ClusterIssuer for Step CA.
This configures cert-manager to use the Step CA ACME server
for automatic certificate issuance via HTTP-01 challenges.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [install_acme_cluster_issuer](#install_acme_cluster_issuer-kubectl_manifest) (*kubectl_manifest*)
- [Variables](#variables)
  - [acme_contact](#acme_contact-required) (**Required**)
  - [acme_server_directory_url](#acme_server_directory_url-required) (**Required**)
  - [secret_namespace](#secret_namespace-required) (**Required**)
  - [secret_name](#secret_name-optional) (*Optional*)
- [Outputs](#outputs)
  - [k8s_ca_issuer_name](#k8s_ca_issuer_name)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | n/a |


## Resources
<blockquote>

#### `install_acme_cluster_issuer` (_kubectl_manifest_)
Install the ACME ClusterIssuer resource
  <table>
    <tr>
      <td>Provider</td>
      <td><code>kubectl (gavinbunney/kubectl)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L20"><code>main.tf#L20</code></a></td>
    </tr>
  </table>
</blockquote>

## Variables
<blockquote>

### `acme_contact` (**Required**)
E-Mail address of the ACME account

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L7"><code>variables.tf#L7</code></a>

</details>
</blockquote>
<blockquote>

### `acme_server_directory_url` (**Required**)
ACME server directory URL

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

### `secret_namespace` (**Required**)
Namespace to deploy the secret and - by extension - the sealed secret to

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L13"><code>variables.tf#L13</code></a>

</details>
</blockquote>
<blockquote>

### `secret_name` (*Optional*)
Name of the secret and - by extension - the sealed secret

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "k8s-acme-secret"
  ```
  In file: <a href="./variables.tf#L19"><code>variables.tf#L19</code></a>

</details>
</blockquote>


## Outputs
<blockquote>

#### `k8s_ca_issuer_name`
Name of the secret ClusterIssuer resource is referring to

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote>