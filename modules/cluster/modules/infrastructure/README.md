# Infrastructure Setup

This module sets up the most critical k8s applications.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules) _(nested and adjacent)_
  - [cilium](#cilium)
  - [external_dns](#external_dns)
  - [local_path_provisioner](#local_path_provisioner)
  - [traefik](#traefik)
  - [traefik_crds](#traefik_crds)
- [Variables](#variables)
  - [cluster](#cluster-required) (**Required**)
  - [root_ca_certificate](#root_ca_certificate-required) (**Required**)
  - [relative_path_to_versions_yaml](#relative_path_to_versions_yaml-optional) (*Optional*)
</blockquote><!-- contents:end -->

## Requirements
  
![terraform](https://img.shields.io/badge/terraform->=1.5.7-d3287d?logo=terraform)

## Modules
  
<blockquote><!-- module:"cilium":start -->

### `cilium`

Installs [`Cilium`](https://github.com/cilium/cilium) CNI, which is a networking, observability, and security solution with an eBPF-based dataplane.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/cilium</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L26"><code>main.tf#L26</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/cilium/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"cilium":end -->
<blockquote><!-- module:"external_dns":start -->

### `external_dns`

Installs [`external-dns`](https://github.com/kubernetes-sigs/external-dns), which allows to forward requests about adding or removing `CNAME` and `A`/`AAAA` records to a given DNS (PiHole in this case) when a such a service is deployed (add) or destroyed (remove).
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/external-dns</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L43"><code>main.tf#L43</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/external-dns/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"external_dns":end -->
<blockquote><!-- module:"local_path_provisioner":start -->

### `local_path_provisioner`

Installs [`local-path-provisioner`](https://github.com/rancher/local-path-provisioner), which is used for [PersistentVolumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistent-volumes) and [PersistentVolumeClaims](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims).
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/local-path-provisioner</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L54"><code>main.tf#L54</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/local-path-provisioner/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"local_path_provisioner":end -->
<blockquote><!-- module:"traefik":start -->

### `traefik`

Installs [`Traefik v3`](https://github.com/traefik/traefik), which provides ingress controller with built-in ACME support and OIDC authentication plugin capabilities.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/traefik</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L64"><code>main.tf#L64</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/traefik/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"traefik":end -->
<blockquote><!-- module:"traefik_crds":start -->

### `traefik_crds`

Installs [`Traefik v3`](https://github.com/traefik/traefik) *CRDs* in order to allow the deployment of `IngressRoute` resources before Traefik is deployed.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/traefik-crds</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L17"><code>main.tf#L17</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/traefik-crds/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"traefik_crds":end -->

## Variables
  
<blockquote><!-- variable:"cluster":start -->

### `cluster` (**Required**)

Cluster configuration

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    name    = string
    lb_cidr = string
    domain  = string
  })
  ```
  In file: <a href="./variables.tf#L1"><code>variables.tf#L1</code></a>

</details>
</blockquote><!-- variable:"cluster":end -->
<blockquote><!-- variable:"root_ca_certificate":start -->

### `root_ca_certificate` (**Required**)

Step CA root CA certificate.

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  In file: <a href="./variables.tf#L17"><code>variables.tf#L17</code></a>

</details>
</blockquote><!-- variable:"root_ca_certificate":end -->
<blockquote><!-- variable:"relative_path_to_versions_yaml":start -->

### `relative_path_to_versions_yaml` (*Optional*)

Relative path to the `versions.yaml` file; it's passed to sub-modules

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "../.."
  ```
  In file: <a href="./variables.tf#L10"><code>variables.tf#L10</code></a>

</details>
</blockquote><!-- variable:"relative_path_to_versions_yaml":end -->