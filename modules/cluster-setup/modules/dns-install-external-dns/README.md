# Install `external-dns`

Handles the setup of `external-dns`.
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [external_dns](#external_dns-helm_release) (*helm_release*)
  - [external_dns_namespace](#external_dns_namespace-kubectl_manifest) (*kubectl_manifest*)
  - [install_pihole_secret](#install_pihole_secret-kubectl_manifest) (*kubectl_manifest*)
  - [pihole_secret](#pihole_secret-sealedsecret_sealedsecret) (*sealedsecret_sealedsecret*)
- [Variables](#variables)
  - [chart_version](#chart_version-required) (**Required**)
  - [name](#name-optional) (*Optional*)
  - [namespace](#namespace-optional) (*Optional*)
  - [timeout](#timeout-optional) (*Optional*)
  - [values](#values-optional) (*Optional*)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.17.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.19.0 |
| <a name="requirement_sealedsecret"></a> [sealedsecret](#requirement\_sealedsecret) | >=1.1.16 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm.deploying"></a> [helm.deploying](#provider\_helm.deploying) | >= 2.17.0 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.19.0 |
| <a name="provider_sealedsecret"></a> [sealedsecret](#provider\_sealedsecret) | >=1.1.16 |


## Resources
<blockquote>

#### `external_dns` (_helm_release_)
Defined in file: `main.tf#40`
</blockquote>
<blockquote>

#### `external_dns_namespace` (_kubectl_manifest_)
Defined in file: `main.tf#17`
</blockquote>
<blockquote>

#### `install_pihole_secret` (_kubectl_manifest_)
Defined in file: `main.tf#33`
</blockquote>
<blockquote>

#### `pihole_secret` (_sealedsecret_sealedsecret_)
Defined in file: `main.tf#26`
</blockquote>

## Variables
<blockquote>

### `chart_version` (**Required**)
Helm Chart version to install

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  Defined in file: `variables.tf#1`

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
  "external-dns-release"
  ```
  Defined in file: `variables.tf#6`

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
  "external-dns"
  ```
  Defined in file: `variables.tf#13`

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
  Defined in file: `variables.tf#20`

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
  Defined in file: `variables.tf#27`

</details>
</blockquote>
