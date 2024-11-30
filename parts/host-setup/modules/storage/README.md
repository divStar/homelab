<!-- BEGIN_TF_DOCS -->
## Storage Management

Handles the import and export of ZFS pools as well as directories.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
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
| [ssh_resource.export_zfs_pools](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.import_zfs_pools](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_proxmox"></a> [proxmox](#input\_proxmox) | Proxmox host configuration | <pre>object({<br/>    name = string<br/>    host = string<br/>    port = number<br/>  })</pre> | n/a | yes |
| <a name="input_ssh"></a> [ssh](#input\_ssh) | SSH configuration for remote connection | <pre>object({<br/>    host    = string<br/>    user    = string<br/>    id_file = optional(string, "~/.ssh/id_rsa")<br/>  })</pre> | n/a | yes |
| <a name="input_storage"></a> [storage](#input\_storage) | Configuration of the storage (pools and directories) to import | <pre>list(object({<br/>    name = string<br/>    type = string # "pool" or "directory"<br/>    # For directories only:<br/>    path          = optional(string)<br/>    content_types = optional(list(string))<br/>  }))</pre> | n/a | yes |
| <a name="input_token"></a> [token](#input\_token) | API token for the terraform user on the Proxmox host | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_storage_pools"></a> [storage\_pools](#output\_storage\_pools) | List of storage pools that were imported and added to Proxmox |
| <a name="output_storage_pools_directories"></a> [storage\_pools\_directories](#output\_storage\_pools\_directories) | List of directories/datasets that were configured in Proxmox |
<!-- END_TF_DOCS -->