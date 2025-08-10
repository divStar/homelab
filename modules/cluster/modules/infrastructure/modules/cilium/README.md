# Cilium Setup

This module installs and configures Cilium.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Modules](#modules) _(nested and adjacent)_
  - [cilium](#cilium)
- [Resources](#resources)
- [Variables](#variables)
  - [cluster](#cluster-required) (**Required**)
  - [cilium_crds](#cilium_crds-optional) (*Optional*)
  - [homelab_root](#homelab_root-optional) (*Optional*)
</blockquote><!-- contents:end -->

## Requirements
  
![terraform](https://img.shields.io/badge/terraform->=1.8.0-d3287d?logo=terraform)

## Providers
  
![http](https://img.shields.io/badge/http-3.5.0-c1166b)

## Modules
  
<blockquote><!-- module:"cilium":start -->

### `cilium`

Installs [`Cilium`](https://github.com/cilium/cilium) CNI, which is a networking, observability, and security solution with an eBPF-based dataplane.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>../../../../../common/modules/helm-terraform-installer</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L24"><code>main.tf#L24</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="../../../../../common/modules/helm-terraform-installer/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"cilium":end -->

## Resources
  

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
  In file: <a href="./variables.tf#L8"><code>variables.tf#L8</code></a>

</details>
</blockquote><!-- variable:"cluster":end -->
<blockquote><!-- variable:"cilium_crds":start -->

### `cilium_crds` (*Optional*)

Cilium CRDs, that have to be present *before* Cilium is installed in order to install the LoadBalancer IP Pool and L2 Announcement resources; use `<VERSION>` placeholder to auto-replace the version in the URL

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(string)
  ```
  **Default**:
  ```json
  [
  "https://raw.githubusercontent.com/cilium/cilium/refs/tags/v<VERSION>/pkg/k8s/apis/cilium.io/client/crds/v2alpha1/ciliuml2announcementpolicies.yaml",
  "https://raw.githubusercontent.com/cilium/cilium/refs/tags/v<VERSION>/pkg/k8s/apis/cilium.io/client/crds/v2alpha1/ciliumloadbalancerippools.yaml"
]
  ```
  In file: <a href="./variables.tf#L17"><code>variables.tf#L17</code></a>

</details>
</blockquote><!-- variable:"cilium_crds":end -->
<blockquote><!-- variable:"homelab_root":start -->

### `homelab_root` (*Optional*)

Path to the gitops git repository root

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "~/Documents/homelab-tofu/"
  ```
  In file: <a href="./variables.tf#L1"><code>variables.tf#L1</code></a>

</details>
</blockquote><!-- variable:"homelab_root":end -->