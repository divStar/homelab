<!-- BEGIN_TF_DOCS -->
## Repository Management

Handles the deactivation of the enterprise repositories and
the creation and activation of the no-subscription repositories.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8.0 |
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | ~> 2.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ssh"></a> [ssh](#provider\_ssh) | 2.7.0 |

## Resources

| Name | Type |
|------|------|
| [ssh_resource.add_no_sub_repository](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.remove_no_sub_repository](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.update_all_repositories](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ssh"></a> [ssh](#input\_ssh) | SSH configuration for remote connection | <pre>object({<br/>    host    = string<br/>    user    = string<br/>    id_file = optional(string, "~/.ssh/id_rsa")<br/>  })</pre> | n/a | yes |
| <a name="input_no_subscription"></a> [no\_subscription](#input\_no\_subscription) | Whether to use no-subscription repository instead of enterprise repository or not | <pre>object({<br/>    enabled           = bool<br/>    list_file         = optional(string, "pve-no-subscription.list")<br/>    list_file_content = optional(string, "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription")<br/>  })</pre> | <pre>{<br/>  "enabled": true<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_no_subscription"></a> [no\_subscription](#output\_no\_subscription) | States, whether a no-subscription repository was used (and some further details) |
<!-- END_TF_DOCS -->