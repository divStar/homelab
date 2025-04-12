# Setup k8s intermediate CA

Handles the setup the intermediate Kubernetes CA certificate.
In particular:
* it creates the CA certificate from the Proxmox CA certificate
* seals the CA certificate
* applies it to the running Talos Kubernetes cluster
## Contents

<blockquote>

- [Requirements](#requirements)
- [Providers](#providers)
- [Resources](#resources)
  - [install_cluster_issuer](#install_cluster_issuer-kubectl_manifest) (*kubectl_manifest*)
  - [install_sealed_k8s_ca_tls](#install_sealed_k8s_ca_tls-kubectl_manifest) (*kubectl_manifest*)
  - [k8s_ca](#k8s_ca-sealedsecret_sealedsecret) (*sealedsecret_sealedsecret*)
  - [proxmox_ca_cert](#proxmox_ca_cert-ssh_resource) (*ssh_resource*)
  - [proxmox_ca_key](#proxmox_ca_key-ssh_resource) (*ssh_resource*)
  - [k8s_ca](#k8s_ca-tls_cert_request) (*tls_cert_request*)
  - [k8s_ca](#k8s_ca-tls_locally_signed_cert) (*tls_locally_signed_cert*)
  - [k8s_ca](#k8s_ca-tls_private_key) (*tls_private_key*)
- [Variables](#variables)
  - [proxmox](#proxmox-required) (**Required**)
  - [secret_namespace](#secret_namespace-required) (**Required**)
  - [k8s_ca](#k8s_ca-optional) (*Optional*)
  - [proxmox_root_ca](#proxmox_root_ca-optional) (*Optional*)
  - [secret_name](#secret_name-optional) (*Optional*)
- [Outputs](#outputs)
  - [k8s_ca_issuer](#k8s_ca_issuer)
  - [k8s_ca_secret_name](#k8s_ca_secret_name)
  - [k8s_sealed_secret_yaml](#k8s_sealed_secret_yaml)</blockquote>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.19.0 |
| <a name="requirement_sealedsecret"></a> [sealedsecret](#requirement\_sealedsecret) | >=1.1.16 |
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | ~> 2.7 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.19.0 |
| <a name="provider_sealedsecret"></a> [sealedsecret](#provider\_sealedsecret) | >=1.1.16 |
| <a name="provider_ssh"></a> [ssh](#provider\_ssh) | ~> 2.7 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |


## Resources
<blockquote>

#### `install_cluster_issuer` (_kubectl_manifest_)
Install the ClusterIssuer resource
  <table>
    <tr>
      <td>Provider</td>
      <td><code>kubectl (gavinbunney/kubectl)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L98"><code>main.tf#L98</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `install_sealed_k8s_ca_tls` (_kubectl_manifest_)
Install the sealed-secret
  <table>
    <tr>
      <td>Provider</td>
      <td><code>kubectl (gavinbunney/kubectl)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L91"><code>main.tf#L91</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `k8s_ca` (_sealedsecret_sealedsecret_)
Create sealed-secret of the intermediate Kubernetes CA certificate
  <table>
    <tr>
      <td>Provider</td>
      <td><code>sealedsecret (jifwin/sealedsecret)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L80"><code>main.tf#L80</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `proxmox_ca_cert` (_ssh_resource_)
Fetch public CA certificate
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L22"><code>main.tf#L22</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `proxmox_ca_key` (_ssh_resource_)
Fetch CA key
  <table>
    <tr>
      <td>Provider</td>
      <td><code>ssh (loafoe/ssh)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L33"><code>main.tf#L33</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `k8s_ca` (_tls_cert_request_)
Define the intermediate Kubernetes cluster certificate using the private key
  <table>
    <tr>
      <td>Provider</td>
      <td><code>tls (hashicorp/tls)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L50"><code>main.tf#L50</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `k8s_ca` (_tls_locally_signed_cert_)
Locally sign the intermediate Kubernetes cluster certificate
  <table>
    <tr>
      <td>Provider</td>
      <td><code>tls (hashicorp/tls)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L64"><code>main.tf#L64</code></a></td>
    </tr>
  </table>
</blockquote>
<blockquote>

#### `k8s_ca` (_tls_private_key_)
Define private key for the intermediate Kubernetes cluster certificate
  <table>
    <tr>
      <td>Provider</td>
      <td><code>tls (hashicorp/tls)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L44"><code>main.tf#L44</code></a></td>
    </tr>
  </table>
</blockquote>

## Variables
<blockquote>

### `proxmox` (**Required**)
Proxmox SSH connection details

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    host     = string
    ssh_user = string
    ssh_key  = string
  })
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
  In file: <a href="./variables.tf#L65"><code>variables.tf#L65</code></a>

</details>
</blockquote>
<blockquote>

### `k8s_ca` (*Optional*)
Intermediate Kubernetes CA used as ClusterIssuer

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    subject = object({
      common_name         = string
      organization        = string
      organizational_unit = string
      country             = string
      locality            = string
      province            = string
    })
    private_key = object({
      algorithm = string
      rsa_bits  = number
    })
    validity_period_hours = number
  })
  ```
  **Default**:
  ```json
  {
  "private_key": {
    "algorithm": "RSA",
    "rsa_bits": 4096
  },
  "subject": {
    "common_name": "Proxmox VE Kubernetes Intermediate CA",
    "country": "DE",
    "locality": "Home Lab",
    "organization": "PVE Cluster Manager CA",
    "organizational_unit": "Kubernetes",
    "province": "Private Network"
  },
  "validity_period_hours": 78840
}
  ```
  In file: <a href="./variables.tf#L23"><code>variables.tf#L23</code></a>

</details>
</blockquote>
<blockquote>

### `proxmox_root_ca` (*Optional*)
Proxmox root CA certificate and key to use for the intermediate k8s certificate

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    pve_root_cert = string
    pve_root_key  = string
  })
  ```
  **Default**:
  ```json
  {
  "pve_root_cert": "/etc/pve/pve-root-ca.pem",
  "pve_root_key": "/etc/pve/priv/pve-root-ca.key"
}
  ```
  In file: <a href="./variables.tf#L10"><code>variables.tf#L10</code></a>

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
  "k8s-ca-secret"
  ```
  In file: <a href="./variables.tf#L58"><code>variables.tf#L58</code></a>

</details>
</blockquote>


## Outputs
<blockquote>

#### `k8s_ca_issuer`
Name of the ClusterIssuer resource

In file: <a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a>
</blockquote>
<blockquote>

#### `k8s_ca_secret_name`
Name of the secret ClusterIssuer resource is referring to

In file: <a href="./outputs.tf#L6"><code>outputs.tf#L6</code></a>
</blockquote>
<blockquote>

#### `k8s_sealed_secret_yaml`
YAML string (not file) containing the /sealed/ secret of the intermediate Kubernetes CA certificate

In file: <a href="./outputs.tf#L11"><code>outputs.tf#L11</code></a>
</blockquote>