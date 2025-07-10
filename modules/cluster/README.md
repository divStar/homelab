# Cluster Setup

This module and its sub-modules setup the Talos cluster on the Proxmox host.

## Contents

<blockquote><!-- contents:start -->

- [Requirements](#requirements)
- [Providers](#providers)
- [Execution story](#execution-story)
- [Modules](#modules) _(nested and adjacent)_
  - [cilium](#cilium)
  - [external_dns](#external_dns)
  - [local_path_provisioner](#local_path_provisioner)
  - [sealed_secrets](#sealed_secrets)
  - [talos_cluster_prepare](#talos_cluster_prepare)
  - [talos_cluster_ready](#talos_cluster_ready)
  - [talos_images](#talos_images)
  - [talos_vms](#talos_vms)
  - [traefik](#traefik)
- [Resources](#resources)
  - _local_file_.[kube_config](#local_filekube_config)
  - _local_file_.[machine_configs](#local_filemachine_configs)
  - _local_file_.[talos_config](#local_filetalos_config)
  - _sealedsecret_sealedsecret_.[external_dns_secret](#sealedsecret_sealedsecretexternal_dns_secret)
- [Variables](#variables)
  - [cluster](#cluster-required) (**Required**)
  - [nodes](#nodes-required) (**Required**)
  - [proxmox](#proxmox-required) (**Required**)
  - [acme_contact](#acme_contact-optional) (*Optional*)
  - [acme_server_directory_url](#acme_server_directory_url-optional) (*Optional*)
  - [cert_manager_namespace](#cert_manager_namespace-optional) (*Optional*)
  - [cilium_crds](#cilium_crds-optional) (*Optional*)
  - [cilium_namespace](#cilium_namespace-optional) (*Optional*)
  - [external_dns_namespace](#external_dns_namespace-optional) (*Optional*)
  - [external_dns_secret_name](#external_dns_secret_name-optional) (*Optional*)
  - [k8s_sealed_secret_ca_file](#k8s_sealed_secret_ca_file-optional) (*Optional*)
  - [kube_config_file](#kube_config_file-optional) (*Optional*)
  - [local_path_provisioner_namespace](#local_path_provisioner_namespace-optional) (*Optional*)
  - [sealed_secrets_controller_name](#sealed_secrets_controller_name-optional) (*Optional*)
  - [sealed_secrets_namespace](#sealed_secrets_namespace-optional) (*Optional*)
  - [step_ca_host](#step_ca_host-optional) (*Optional*)
  - [talos_config_file](#talos_config_file-optional) (*Optional*)
  - [talos_machine_config_file](#talos_machine_config_file-optional) (*Optional*)
  - [traefik_namespace](#traefik_namespace-optional) (*Optional*)
  - [versions_yaml](#versions_yaml-optional) (*Optional*)
- [Outputs](#outputs)
  - [kube_config](#kube_config)
  - [talos_config](#talos_config)
</blockquote><!-- contents:end -->

## Requirements
  
![terraform](https://img.shields.io/badge/terraform->=1.8.0-d3287d?logo=terraform)
![helm](https://img.shields.io/badge/helm->=3.0.1-a7fc51?logo=helm)
![kubectl](https://img.shields.io/badge/kubectl->=1.19.0-eb4095?logo=kubectl)
![proxmox](https://img.shields.io/badge/proxmox->=0.78.2-1e73c8?logo=proxmox)
![sealedsecret](https://img.shields.io/badge/sealedsecret->=1.1.16-f54a9f?logo=sealedsecret)
![talos](https://img.shields.io/badge/talos->=0.8.1-2479ce?logo=talos)

## Providers
  
![http](https://img.shields.io/badge/http-3.5.0-c1166b)
![local](https://img.shields.io/badge/local-2.5.3-0c61b6)
![sealedsecret](https://img.shields.io/badge/sealedsecret-1.1.16-f54a9f)

## Execution story

Order in which Terraform will create resources (and likely destroy them in reverse order):
```
├── sealedsecret.external_dns_secret
├── module.talos_images
│   ├── module.talos_images.proxmox_virtual_environment_download_file.this
│   ├── module.talos_images.talos_image_factory_schematic.this
├── module.talos_vms
│   ├── module.talos_vms.proxmox_virtual_environment_vm.this
│   ├── module.talos_vms.talos_machine_configuration_apply.this
├── module.talos_cluster_prepare
│   ├── module.talos_cluster_prepare.talos_machine_secrets.this
├── module.cilium
│   ├── module.cilium.kubectl_manifest.namespace
│   ├── module.cilium.kubectl_manifest.pre_install
│   ├── module.cilium.helm_release.this
│   ├── module.cilium.kubectl_manifest.post_install
├── module.talos_cluster_ready
│   ├── module.talos_cluster_ready.talos_machine_bootstrap.this
│   ├── module.talos_cluster_ready.talos_cluster_kubeconfig.this
├── module.external_dns
│   ├── module.external_dns.kubectl_manifest.namespace
│   ├── module.external_dns.kubectl_manifest.pre_install
│   ├── module.external_dns.helm_release.this
│   ├── module.external_dns.kubectl_manifest.post_install
├── module.local_path_provisioner
│   ├── module.local_path_provisioner.kubectl_manifest.namespace
│   ├── module.local_path_provisioner.kubectl_manifest.pre_install
│   ├── module.local_path_provisioner.helm_release.this
│   ├── module.local_path_provisioner.kubectl_manifest.post_install
├── module.sealed_secrets
│   ├── module.sealed_secrets.kubectl_manifest.namespace
│   ├── module.sealed_secrets.kubectl_manifest.pre_install
│   ├── module.sealed_secrets.helm_release.this
│   ├── module.sealed_secrets.kubectl_manifest.post_install
├── module.traefik
│   ├── module.traefik.kubectl_manifest.namespace
│   ├── module.traefik.kubectl_manifest.pre_install
│   ├── module.traefik.helm_release.this
│   ├── module.traefik.kubectl_manifest.post_install
```

## Modules
  
<blockquote><!-- module:"cilium":start -->

### `cilium`

Installs [`Cilium`](httpshttps://github.com/cilium/cilium) CNI, which is a networking, observability, and security solution with an eBPF-based dataplane.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>../common/modules/helm-terraform-installer</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L125"><code>main.tf#L125</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="../common/modules/helm-terraform-installer/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"cilium":end -->
<blockquote><!-- module:"external_dns":start -->

### `external_dns`

Installs [`external-dns`](https://github.com/kubernetes-sigs/external-dns), which allows to forward requests about adding or removing `CNAME` and `A`/`AAAA` records to a given DNS (PiHole in this case) when a such a service is deployed (add) or destroyed (remove).
  <table>
    <tr>
      <td>Module location</td>
      <td><code>../common/modules/helm-terraform-installer</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L186"><code>main.tf#L186</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="../common/modules/helm-terraform-installer/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"external_dns":end -->
<blockquote><!-- module:"local_path_provisioner":start -->

### `local_path_provisioner`

Installs [`local-path-provisioner`](https://github.com/rancher/local-path-provisioner), which is used for [PersistentVolumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistent-volumes) and [PersistentVolumeClaims](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims).
  <table>
    <tr>
      <td>Module location</td>
      <td><code>../common/modules/helm-terraform-installer</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L208"><code>main.tf#L208</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="../common/modules/helm-terraform-installer/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"local_path_provisioner":end -->
<blockquote><!-- module:"sealed_secrets":start -->

### `sealed_secrets`

Installs [`sealed-secrets`](https://github.com/bitnami-labs/sealed-secrets), which manages `SealedSecret` resources, en- and decrypting them as necessary.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>../common/modules/helm-terraform-installer</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L159"><code>main.tf#L159</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="../common/modules/helm-terraform-installer/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"sealed_secrets":end -->
<blockquote><!-- module:"talos_cluster_prepare":start -->

### `talos_cluster_prepare`

Prepares the cluster creation by generating the **Talos machine secrets** and creating the **Talos client cluster configuration**.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/talos-prepare-cluster</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L57"><code>main.tf#L57</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/talos-prepare-cluster/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"talos_cluster_prepare":end -->
<blockquote><!-- module:"talos_cluster_ready":start -->

### `talos_cluster_ready`

Awaits the Talos cluster to become ready and available. <p>This module returns once all Talos [`nodes`](#nodes-required) are up and running.</p> <p><strong>Note:</strong> since the cluster is starting up without a CNI (Flannel is disabled), <strong>Kubernetes checks are skipped</strong>.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/talos-await-cluster</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L103"><code>main.tf#L103</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/talos-await-cluster/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"talos_cluster_ready":end -->
<blockquote><!-- module:"talos_images":start -->

### `talos_images`

Downloads the calculated Talos images specified in the [`nodes`](#nodes-required) configurations.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/talos-download-image</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L42"><code>main.tf#L42</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/talos-download-image/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"talos_images":end -->
<blockquote><!-- module:"talos_vms":start -->

### `talos_vms`

Creates the given Talos VMs, uses `for_each` on the list of [`nodes`](#nodes-required).
  <table>
    <tr>
      <td>Module location</td>
      <td><code>./modules/talos-create-vm</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L71"><code>main.tf#L71</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="./modules/talos-create-vm/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"talos_vms":end -->
<blockquote><!-- module:"traefik":start -->

### `traefik`

Installs [`Traefik v3`](https://github.com/traefik/traefik), which provides ingress controller with built-in ACME support and OIDC authentication plugin capabilities.
  <table>
    <tr>
      <td>Module location</td>
      <td><code>../common/modules/helm-terraform-installer</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L224"><code>main.tf#L224</code></a></td>
    </tr>
    <tr>
      <td colspan="2"><a href="../common/modules/helm-terraform-installer/README.md">README.md</a> <em>(experimental)</em></td>
    </tr>
  </table>
</blockquote><!-- module:"traefik":end -->

## Resources
  
<blockquote><!-- resource:"local_file.kube_config":start -->

### _local_file_.`kube_config`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>local (hashicorp/local)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./outputs.tf#L14"><code>outputs.tf#L14</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"local_file.kube_config":end -->
<blockquote><!-- resource:"local_file.machine_configs":start -->

### _local_file_.`machine_configs`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>local (hashicorp/local)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./outputs.tf#L7"><code>outputs.tf#L7</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"local_file.machine_configs":end -->
<blockquote><!-- resource:"local_file.talos_config":start -->

### _local_file_.`talos_config`
      
  <table>
    <tr>
      <td>Provider</td>
      <td><code>local (hashicorp/local)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./outputs.tf#L1"><code>outputs.tf#L1</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"local_file.talos_config":end -->
<blockquote><!-- resource:"sealedsecret_sealedsecret.external_dns_secret":start -->

### _sealedsecret_sealedsecret_.`external_dns_secret`

Creates an `external-dns` secret, that contains credentials to access a external DNS system (PiHole in this case).
  <table>
    <tr>
      <td>Provider</td>
      <td><code>sealedsecret (jifwin/sealedsecret)</code></td>
    </tr>
    <tr>
      <td>In file</td>
      <td><a href="./main.tf#L171"><code>main.tf#L171</code></a></td>
    </tr>
  </table>
</blockquote><!-- resource:"sealedsecret_sealedsecret.external_dns_secret":end -->

## Variables
  
<blockquote><!-- variable:"cluster":start -->

### `cluster` (**Required**)

Cluster configuration

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    name              = string
    gateway           = string
    endpoint          = string
    lb_cidr           = string
    domain            = string
    talos_factory_url = optional(string, "https://factory.talos.dev/")
  })
  ```
  In file: <a href="./variables.tf#L66"><code>variables.tf#L66</code></a>

</details>
</blockquote><!-- variable:"cluster":end -->
<blockquote><!-- variable:"nodes":start -->

### `nodes` (**Required**)

Configuration for cluster nodes

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  list(object({
    schematic    = optional(string)
    platform     = optional(string)
    arch         = optional(string)
    name         = string
    description  = optional(string)
    tags         = optional(list(string))
    host         = string
    machine_type = string
    bridge       = optional(string)
    ip           = string
    mac_address  = string
    vm_id        = number
    cpu          = number
    ram          = number
    datastore_id = optional(string)
    vfs_mappings = optional(list(string), [])
  }))
  ```
  In file: <a href="./variables.tf#L78"><code>variables.tf#L78</code></a>

</details>
</blockquote><!-- variable:"nodes":end -->
<blockquote><!-- variable:"proxmox":start -->

### `proxmox` (**Required**)

Proxmox host configuration

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  object({
    name      = string
    host      = string
    endpoint  = string
    insecure  = bool
    api_token = string
    iso_store = optional(string, "local")
    ssh_user  = string
    ssh_key   = string
  })
  ```
  In file: <a href="./variables.tf#L52"><code>variables.tf#L52</code></a>

</details>
</blockquote><!-- variable:"proxmox":end -->
<blockquote><!-- variable:"acme_contact":start -->

### `acme_contact` (*Optional*)

E-Mail address of the ACME account

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "admin@my.world"
  ```
  In file: <a href="./variables.tf#L173"><code>variables.tf#L173</code></a>

</details>
</blockquote><!-- variable:"acme_contact":end -->
<blockquote><!-- variable:"acme_server_directory_url":start -->

### `acme_server_directory_url` (*Optional*)

ACME server directory URL

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "https://step-ca.my.world/acme/step-ca-acme/directory"
  ```
  In file: <a href="./variables.tf#L166"><code>variables.tf#L166</code></a>

</details>
</blockquote><!-- variable:"acme_server_directory_url":end -->
<blockquote><!-- variable:"cert_manager_namespace":start -->

### `cert_manager_namespace` (*Optional*)

Namespace where the cert-manager will be installed to

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "cert-manager"
  ```
  In file: <a href="./variables.tf#L16"><code>variables.tf#L16</code></a>

</details>
</blockquote><!-- variable:"cert_manager_namespace":end -->
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
  In file: <a href="./variables.tf#L195"><code>variables.tf#L195</code></a>

</details>
</blockquote><!-- variable:"cilium_crds":end -->
<blockquote><!-- variable:"cilium_namespace":start -->

### `cilium_namespace` (*Optional*)

Namespace where the cilium operator will be installed to

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "cilium"
  ```
  In file: <a href="./variables.tf#L9"><code>variables.tf#L9</code></a>

</details>
</blockquote><!-- variable:"cilium_namespace":end -->
<blockquote><!-- variable:"external_dns_namespace":start -->

### `external_dns_namespace` (*Optional*)

Namespace where the external-dns operator will be installed to

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
  In file: <a href="./variables.tf#L23"><code>variables.tf#L23</code></a>

</details>
</blockquote><!-- variable:"external_dns_namespace":end -->
<blockquote><!-- variable:"external_dns_secret_name":start -->

### `external_dns_secret_name` (*Optional*)

Name of the external-dns secret

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "sealed-secrets-release"
  ```
  In file: <a href="./variables.tf#L188"><code>variables.tf#L188</code></a>

</details>
</blockquote><!-- variable:"external_dns_secret_name":end -->
<blockquote><!-- variable:"k8s_sealed_secret_ca_file":start -->

### `k8s_sealed_secret_ca_file` (*Optional*)

File name and path for the generated sealed secret of the intermediate Kubernetes CA certificate

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "output/k8s_sealed_secret_ca.yaml"
  ```
  In file: <a href="./variables.tf#L151"><code>variables.tf#L151</code></a>

</details>
</blockquote><!-- variable:"k8s_sealed_secret_ca_file":end -->
<blockquote><!-- variable:"kube_config_file":start -->

### `kube_config_file` (*Optional*)

File name and path for the generated kube-config

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "output/kube-config.yaml"
  ```
  In file: <a href="./variables.tf#L130"><code>variables.tf#L130</code></a>

</details>
</blockquote><!-- variable:"kube_config_file":end -->
<blockquote><!-- variable:"local_path_provisioner_namespace":start -->

### `local_path_provisioner_namespace` (*Optional*)

Namespace where the local-path-provisioner operator will be installed to

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "local-path-provisioner"
  ```
  In file: <a href="./variables.tf#L37"><code>variables.tf#L37</code></a>

</details>
</blockquote><!-- variable:"local_path_provisioner_namespace":end -->
<blockquote><!-- variable:"sealed_secrets_controller_name":start -->

### `sealed_secrets_controller_name` (*Optional*)

Name of the sealed-secrets controller

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "sealed-secrets-release"
  ```
  In file: <a href="./variables.tf#L181"><code>variables.tf#L181</code></a>

</details>
</blockquote><!-- variable:"sealed_secrets_controller_name":end -->
<blockquote><!-- variable:"sealed_secrets_namespace":start -->

### `sealed_secrets_namespace` (*Optional*)

Namespace where the sealed-secrets operator will be installed to

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "sealed-secrets"
  ```
  In file: <a href="./variables.tf#L30"><code>variables.tf#L30</code></a>

</details>
</blockquote><!-- variable:"sealed_secrets_namespace":end -->
<blockquote><!-- variable:"step_ca_host":start -->

### `step_ca_host` (*Optional*)

Step CA IP or host, _*not*_ including the protocol (`https`).

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "192.168.178.155"
  ```
  In file: <a href="./variables.tf#L159"><code>variables.tf#L159</code></a>

</details>
</blockquote><!-- variable:"step_ca_host":end -->
<blockquote><!-- variable:"talos_config_file":start -->

### `talos_config_file` (*Optional*)

File name and path for the generated talos-config

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "output/talos-config.yaml"
  ```
  In file: <a href="./variables.tf#L137"><code>variables.tf#L137</code></a>

</details>
</blockquote><!-- variable:"talos_config_file":end -->
<blockquote><!-- variable:"talos_machine_config_file":start -->

### `talos_machine_config_file` (*Optional*)

File name and path for the generated talos-machine-config; use <node-name> in the file name to replace with node name

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "output/talos-machine-config-<node-name>.yaml"
  ```
  In file: <a href="./variables.tf#L144"><code>variables.tf#L144</code></a>

</details>
</blockquote><!-- variable:"talos_machine_config_file":end -->
<blockquote><!-- variable:"traefik_namespace":start -->

### `traefik_namespace` (*Optional*)

Namespace for Traefik deployment

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "traefik"
  ```
  In file: <a href="./variables.tf#L44"><code>variables.tf#L44</code></a>

</details>
</blockquote><!-- variable:"traefik_namespace":end -->
<blockquote><!-- variable:"versions_yaml":start -->

### `versions_yaml` (*Optional*)

Path to the `versions.yaml` file, that contains all relevant versions

<details style="border-top-color: inherit; border-top-width: 0.1em; border-top-style: solid; padding-top: 0.5em; padding-bottom: 0.5em;">
  <summary>Show more...</summary>

  **Type**:
  ```hcl
  string
  ```
  **Default**:
  ```json
  "../../versions.yaml"
  ```
  In file: <a href="./variables.tf#L1"><code>variables.tf#L1</code></a>

</details>
</blockquote><!-- variable:"versions_yaml":end -->

## Outputs
  
<blockquote><!-- output:"kube_config":start -->

#### `kube_config`

String containing the `kube-config.yaml`

In file: <a href="./outputs.tf#L26"><code>outputs.tf#L26</code></a>
</blockquote><!-- output:"kube_config":end -->
<blockquote><!-- output:"talos_config":start -->

#### `talos_config`

String containing the `talos-config.yaml`

In file: <a href="./outputs.tf#L20"><code>outputs.tf#L20</code></a>
</blockquote><!-- output:"talos_config":end -->