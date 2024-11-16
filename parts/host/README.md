<!-- BEGIN_TF_DOCS -->
# Host setup module

This module manages remote script execution and package installation via SSH.

## Usage

```hcl
module "remote_setup" {
  source = "github.com/username/repo"

  ssh_configuration = {
    host = "example.com"
    user = "admin"
  }

  packages = [
    "vim",
    "git"
  ]

  scripts = {
    items = [
        {
            name = "pve-mod-nag-screen.sh"
            url = "https://raw.githubusercontent.com/Meliox/PVE-mods/refs/heads/main/pve-mod-nag-screen.sh"
            apply_params = "install"
            destroy_params = "uninstall"
            # run_on_destroy defaults to true if not specified
        }
    ]
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_restapi"></a> [restapi](#requirement\_restapi) | >= 1.20.0 |
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | ~> 2.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_restapi"></a> [restapi](#provider\_restapi) | 1.20.0 |
| <a name="provider_ssh"></a> [ssh](#provider\_ssh) | 2.7.0 |

## Resources

| Name | Type |
|------|------|
| [restapi_object.add_directory_storage](https://registry.terraform.io/providers/Mastercard/restapi/latest/docs/resources/object) | resource |
| [restapi_object.add_pool_storage](https://registry.terraform.io/providers/Mastercard/restapi/latest/docs/resources/object) | resource |
| [ssh_resource.create_terraform_api_token](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.create_terraform_user](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.export_zfs_pools](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.import_zfs_pools](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.package_install](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.package_remove](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.remove_terraform_user](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.script_cleanup](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.script_download](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.script_execute](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_proxmox_configuration"></a> [proxmox\_configuration](#input\_proxmox\_configuration) | Proxmox host configuration | <pre>object({<br/>    name = string<br/>    host = string<br/>    port = number<br/>  })</pre> | n/a | yes |
| <a name="input_ssh_configuration"></a> [ssh\_configuration](#input\_ssh\_configuration) | SSH configuration for remote connection | <pre>object({<br/>    host = string<br/>    user = string<br/>    id   = optional(string, "~/.ssh/id_rsa")<br/>  })</pre> | n/a | yes |
| <a name="input_storages"></a> [storages](#input\_storages) | n/a | <pre>list(object({<br/>    name          = string<br/>    type          = string # "pool" or "directory"<br/>    # For directories only:<br/>    path          = optional(string)       # Path of the folder in the host system<br/>    content_types = optional(list(string)) # One or more of: iso,vztmpl,backup,snippets,rootdir,images<br/>  }))</pre> | n/a | yes |
| <a name="input_packages"></a> [packages](#input\_packages) | List of packages to install via apt-get | `list(string)` | `[]` | no |
| <a name="input_scripts"></a> [scripts](#input\_scripts) | Configuration for script management including shared directory and script items | <pre>object({<br/>    directory = optional(string, "scripts")<br/>    items = list(object({<br/>      name           = string<br/>      url            = string<br/>      apply_params   = optional(string, "")<br/>      destroy_params = optional(string, "")<br/>      run_on_destroy = optional(bool, true)<br/>    }))<br/>  })</pre> | <pre>{<br/>  "directory": "scripts",<br/>  "items": []<br/>}</pre> | no |
| <a name="input_terraform_user"></a> [terraform\_user](#input\_terraform\_user) | Configuration for Terraform provisioner user. Individual fields can be overridden. | <pre>object({<br/>    name    = optional(string, "terraform@pve")<br/>    comment = optional(string, "Terraform automation user")<br/>    role = object({<br/>      name = optional(string, "TerraformProv")<br/>      privileges = optional(list(string), [<br/>        "VM.Allocate",<br/>        "VM.Clone",<br/>        "VM.Config.Disk",<br/>        "VM.Config.CPU",<br/>        "VM.Config.Memory",<br/>        "VM.Config.Network",<br/>        "VM.Config.Cloudinit",<br/>        "VM.Config.Options",<br/>        "VM.PowerMgmt",<br/>        "VM.Monitor",<br/>        "Datastore.Allocate",<br/>        "Datastore.AllocateSpace",<br/>        "Datastore.Audit",<br/>        "SDN.Use",<br/>        "Sys.Audit"<br/>      ])<br/>    })<br/>    token = object({<br/>      name = optional(string, "terraform-token")<br/>      comment = optional(string, "Terraform automation user API token")<br/>    })<br/>  })</pre> | <pre>{<br/>  "role": {},<br/>  "token": {}<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_installed_packages"></a> [installed\_packages](#output\_installed\_packages) | The packages, that have been installed/removed |
| <a name="output_installed_scripts"></a> [installed\_scripts](#output\_installed\_scripts) | The scripts, that have been installed/removed |
| <a name="output_storage_pools"></a> [storage\_pools](#output\_storage\_pools) | List of storage pools that were imported and added to Proxmox |
| <a name="output_storage_pools_directories"></a> [storage\_pools\_directories](#output\_storage\_pools\_directories) | List of directories/datasets that were configured in Proxmox |
| <a name="output_users"></a> [users](#output\_users) | The user, role and API token created on the Proxmox host |
<!-- END_TF_DOCS -->