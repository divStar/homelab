<!-- BEGIN_TF_DOCS -->
# Host setup module

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_restapi"></a> [restapi](#requirement\_restapi) | >= 1.20.0 |
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | ~> 2.7 |

## Providers

No providers.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_configuration_files"></a> [configuration\_files](#input\_configuration\_files) | Configuration files to copy to the host | <pre>list(object({<br/>    source      = string<br/>    destination = string<br/>    permissions = optional(number)<br/>    owner       = optional(string)<br/>    group       = optional(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_proxmox"></a> [proxmox](#input\_proxmox) | Proxmox host configuration | <pre>object({<br/>    name = string<br/>    host = string<br/>    port = number<br/>  })</pre> | n/a | yes |
| <a name="input_ssh"></a> [ssh](#input\_ssh) | SSH configuration for remote connection | <pre>object({<br/>    host    = string<br/>    user    = string<br/>    id_file = optional(string, "~/.ssh/id_rsa")<br/>  })</pre> | n/a | yes |
| <a name="input_storage"></a> [storage](#input\_storage) | Configuration of the storage (pools and directories) to import | <pre>list(object({<br/>    name = string<br/>    type = string # "pool" or "directory"<br/>    # For directories only:<br/>    path          = optional(string)<br/>    content_types = optional(list(string))<br/>  }))</pre> | n/a | yes |
| <a name="input_gitops_user"></a> [gitops\_user](#input\_gitops\_user) | Configuration of GitOps user. | <pre>object({<br/>    user        = optional(string, "gitops")<br/>    group       = optional(string, "gitops")<br/>    repo_name   = optional(string, "repo")<br/>    source_repo = optional(string, "/storage-pool/gitops")<br/>  })</pre> | `{}` | no |
| <a name="input_no_subscription"></a> [no\_subscription](#input\_no\_subscription) | Whether to use no-subscription repository instead of enterprise repository or not | <pre>object({<br/>    enabled           = bool<br/>    list_file         = optional(string, "pve-no-subscription.list")<br/>    list_file_content = optional(string, "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription")<br/>  })</pre> | <pre>{<br/>  "enabled": true<br/>}</pre> | no |
| <a name="input_org_source_repo_owner"></a> [org\_source\_repo\_owner](#input\_org\_source\_repo\_owner) | Original owner of the source repository (before, e.g. root:root) | <pre>object({<br/>    owner = optional(string, "root")<br/>    group = optional(string, "root")<br/>  })</pre> | `{}` | no |
| <a name="input_packages"></a> [packages](#input\_packages) | List of packages to install via apt-get | `list(string)` | `[]` | no |
| <a name="input_scripts"></a> [scripts](#input\_scripts) | Configuration for script management including shared directory and script items | <pre>object({<br/>    directory = optional(string, "scripts")<br/>    items = list(object({<br/>      name           = string<br/>      url            = string<br/>      apply_params   = optional(string, "")<br/>      destroy_params = optional(string, "")<br/>      run_on_destroy = optional(bool, true)<br/>    }))<br/>  })</pre> | <pre>{<br/>  "directory": "scripts",<br/>  "items": []<br/>}</pre> | no |
| <a name="input_terraform_user"></a> [terraform\_user](#input\_terraform\_user) | Configuration for Terraform provisioner user. Individual fields can be overridden. | <pre>object({<br/>    name    = optional(string, "terraform@pve")<br/>    comment = optional(string, "Terraform automation user")<br/>    role = object({<br/>      name = optional(string, "TerraformProv")<br/>      privileges = optional(list(string), [<br/>        "VM.Allocate",<br/>        "VM.Clone",<br/>        "VM.Config.Disk",<br/>        "VM.Config.CPU",<br/>        "VM.Config.Memory",<br/>        "VM.Config.Network",<br/>        "VM.Config.Cloudinit",<br/>        "VM.Config.Options",<br/>        "VM.PowerMgmt",<br/>        "VM.Monitor",<br/>        "Datastore.Allocate",<br/>        "Datastore.AllocateSpace",<br/>        "Datastore.Audit",<br/>        "SDN.Use",<br/>        "Sys.Audit",<br/>        "Sys.Modify"<br/>      ])<br/>    })<br/>    token = object({<br/>      name    = optional(string, "terraform-token")<br/>      comment = optional(string, "Terraform automation user API token")<br/>    })<br/>  })</pre> | <pre>{<br/>  "role": {},<br/>  "token": {}<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_configuration_files"></a> [configuration\_files](#output\_configuration\_files) | Configuration files copied to host |
| <a name="output_installed_packages"></a> [installed\_packages](#output\_installed\_packages) | The packages, that have been installed/removed |
| <a name="output_installed_scripts"></a> [installed\_scripts](#output\_installed\_scripts) | The scripts, that have been installed/removed |
| <a name="output_no_subscription"></a> [no\_subscription](#output\_no\_subscription) | States, whether a no-subscription repository was used (and some further details) |
| <a name="output_pve-user"></a> [pve-user](#output\_pve-user) | The user and role created on the Proxmox host |
| <a name="output_storage_pools"></a> [storage\_pools](#output\_storage\_pools) | List of storage pools that were imported and added to Proxmox |
| <a name="output_storage_pools_directories"></a> [storage\_pools\_directories](#output\_storage\_pools\_directories) | List of directories/datasets that were configured in Proxmox |
| <a name="output_token"></a> [token](#output\_token) | The API token created on the Proxmox host |
<!-- END_TF_DOCS -->