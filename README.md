# Single-node cluster setup

> [!NOTE]
> Even though currently the scripts are set up for just a single node, all pieces of software are capable of setting up and running multiple control planes and worker nodes.
>
> If you run Traefik in HA, make sure to shift from built-in `certificatesResolvers` usage to `cert-manager`. I removed `cert-manager`, because I am unlikely to have multiple nodes (for now).

This repository contains multiple modules and scripts, that you can run manually to set up a homelab / NAS. The scripts are very opinionated and they work for me - feel free to change anything you might want or need.

## Contents

### BOM
Here's a list of all the software being used in this homelab setup:

**Infrastructure & Virtualization:**
- <img src="docs/assets/proxmox-logo-stacked-color.svg" width="20" height="20"> **[Proxmox VE](https://www.proxmox.com/en/proxmox-virtual-environment/overview)** - Virtualization platform
- <img src="docs/assets/talos-logo.svg" width="20" height="20"> **[Talos Linux](https://www.talos.dev/)** - Immutable Kubernetes OS
- <img src="docs/assets/alpine-logo.svg" width="20" height="20"> **[Alpine Linux](https://alpinelinux.org/)** - Lightweight Linux distribution for containers

**Kubernetes & Container Orchestration:**
- <img src="docs/assets/kubernetes-logo.svg" width="20" height="20"> **[Kubernetes](https://kubernetes.io/)** - Container orchestration platform
- <img src="docs/assets/cilium-logo.svg" width="20" height="20"> **[Cilium](https://cilium.io/)** - eBPF-based networking, observability, and security
- <img src="docs/assets/traefik-logo.svg" width="20" height="20"> **[Traefik](https://traefik.io/)** - Modern reverse proxy and load balancer with automatic service discovery
- <img src="docs/assets/local-path-provisioner-logo.svg" width="20" height="20"> **[Local Path Provisioner](https://github.com/rancher/local-path-provisioner)** - Dynamic local storage provisioner

**Security & PKI:**
- <img src="docs/assets/smallstep-logo.svg" width="20" height="20"> **[Step-CA](https://smallstep.com/certificates/)** - Certificate authority for internal PKI
- <img src="docs/assets/sealedsecrets-logo.svg" width="20" height="20"> **[Sealed Secrets](https://sealed-secrets.netlify.app/)** - Kubernetes controller for one-way encrypted Secrets

**DNS & Service Discovery:**
- <img src="docs/assets/external-dns-logo.svg" width="20" height="20"> **[External DNS](https://github.com/kubernetes-sigs/external-dns)** - Kubernetes addon to configure external DNS servers

**Identity & Access Management:**
- <img src="docs/assets/zitadel-logo.svg" width="20" height="20"> **[Zitadel](https://zitadel.com/)** - Identity and access management platform

**Infrastructure as Code:**
- <img src="docs/assets/tofu-on-light.svg" width="20" height="20"> **[OpenTofu](https://opentofu.org/)** / **[Terraform](https://www.terraform.io/)** - Infrastructure provisioning
- <img src="docs/assets/helm-logo.svg" width="20" height="20"> **[Helm](https://helm.sh/)** - Kubernetes package manager

### Main Modules

- **[`host`](modules/host/README.md)** - Configures the Proxmox host with required packages, users, storage pools, and system settings
  - **[`copy-configs`](modules/host/modules/copy-configs/README.md)** - Handles copying configuration files to the host
  - **[`directory-mappings`](modules/host/modules/directory-mappings/README.md)** - Maps directories for VirtioFS sharing with VMs
  - **[`packages`](modules/host/modules/packages/README.md)** - Installs additional APT packages on the host
  - **[`repositories`](modules/host/modules/repositories/README.md)** - Manages APT repositories (enables no-subscription repo)
  - **[`scripts`](modules/host/modules/scripts/README.md)** - Executes various non-interactive setup scripts
  - **[`share-user`](modules/host/modules/share-user/README.md)** - Creates a dedicated user for file sharing
  - **[`terraform-user`](modules/host/modules/terraform-user/README.md)** - Creates Terraform user and API token for Proxmox automation
  - **[`trust-proxmox-ca`](modules/host/modules/trust-proxmox-ca/README.md)** - Configures Proxmox to trust its own CA certificate
  - **[`zfs-storage`](modules/host/modules/zfs-storage/README.md)** - Imports and manages ZFS storage pools

- **[`stepca-lxc`](modules/stepca-lxc/README.md)** - Sets up Step-CA certificate authority in an Alpine LXC container for internal PKI management

- **[`cluster`](modules/cluster/README.md)** - Sets up the Talos Kubernetes cluster on Proxmox with networking (Cilium), ingress (Traefik), storage (local-path-provisioner), DNS (external-dns), and secrets management (sealed-secrets)
  - **[`talos-download-image`](modules/cluster/modules/talos-download-image/README.md)** - Downloads and manages Talos images for deployment
  - **[`talos-prepare-cluster`](modules/cluster/modules/talos-prepare-cluster/README.md)** - Prepares cluster by generating machine secrets and configurations
  - **[`talos-create-vm`](modules/cluster/modules/talos-create-vm/README.md)** - Creates Talos VMs on Proxmox with proper configuration
  - **[`talos-await-cluster`](modules/cluster/modules/talos-await-cluster/README.md)** - Waits for Talos cluster to become ready and available
  - **`cilium`** - Installs Cilium CNI for eBPF-based networking, observability, and security
  - **`sealed-secrets`** - Installs sealed-secrets controller for encrypted secret management
  - **`external-dns`** - Installs external-dns for automatic DNS record management
  - **`local-path-provisioner`** - Installs local-path-provisioner for dynamic local storage
  - **`traefik`** - Installs Traefik v3 ingress controller with ACME support and OIDC capabilities

### Common Modules

- **[`common/modules/alpine`](modules/common/modules/alpine/README.md)** - Creates Alpine Linux LXC containers with SSH access and basic packages
- **[`common/modules/helm-terraform-installer`](modules/common/modules/helm-terraform-installer/README.md)** - Installs Helm charts through Terraform with namespace and manifest management

### Application Modules

- <span style="font-variant: small-caps; background: orange; padding-left: 2pt; padding-right: 2pt; color: #555; border-radius: 3pt;">on-going</span> **[`k8s-apps/zitadel`](modules/k8s-apps/zitadel/README.md)** - Deploys Zitadel identity and access management platform

### Legacy Modules (Not in Use)

- **[`(not-in-use)lldap-lxc`](modules/(not-in-use)lldap-lxc/README.md)** - LLDAP lightweight directory service (deprecated)
- **[`(not-in-use)pihole-lxc`](modules/(not-in-use)pihole-lxc/README.md)** - Pi-hole DNS server (deprecated)

### Scripts

- **[backup-state.sh](scripts/backup-state.sh)** - Backs up Terraform state files to a remote host via SSH/SCP. Useful for preserving infrastructure state before major changes.
  - Usage: `./backup-state.sh -d /remote/path [-s source_dir] [-h host] [-u user]`

- **[restore-state.sh](scripts/restore-state.sh)** - Restores Terraform state files from a remote host. Complements the backup script for disaster recovery.
  - Usage: `./restore-state.sh -d /remote/path [-h host] [-u user] [-o output_dir]`

- **[cleanup-cluster.sh](scripts/cleanup-cluster.sh)** - Completely removes cluster VMs from Proxmox and cleans up local Terraform files. Supports dry-run mode.
  - Usage: `./cleanup-cluster.sh PROXMOX_HOST [--dry-run] [--tf-path PATH]`

- **[generate-docs.sh](scripts/generate-docs.sh)** - Automatically generates README documentation for all Terraform modules using terraform-docs. Includes execution story generation.
  - Usage: `./generate-docs.sh [PATH]`

- **[story-plan.sh](scripts/story-plan.sh)** - Analyzes Terraform dependency graphs to show resource execution order. Supports both module-only and extended (resource-level) views.
  - Usage: `./story-plan.sh [-d|--debug] [-x|--extended] [-r|--raw] [-p|--path PATH] [-b|--binary BINARY]`