<!-- BEGIN_TF_DOCS -->
## GitOps Management: authorized\_keys appender

Handles appending of SSH keys to the authorized\_keys file of a given user.

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
| [ssh_resource.add_key](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_repo_name"></a> [repo\_name](#input\_repo\_name) | Name of the symbolic link to the actual gitops git repository | `string` | n/a | yes |
| <a name="input_ssh"></a> [ssh](#input\_ssh) | SSH configuration for remote connection | <pre>object({<br/>    host    = string<br/>    user    = string<br/>    id_file = optional(string, "~/.ssh/id_rsa")<br/>  })</pre> | n/a | yes |
| <a name="input_ssh_key_file"></a> [ssh\_key\_file](#input\_ssh\_key\_file) | Path to SSH public key file to add to authorized\_keys (e.g. ~/.ssh/id\_rsa.pub) | `string` | n/a | yes |
| <a name="input_target_user"></a> [target\_user](#input\_target\_user) | Username to add SSH key for | `string` | n/a | yes |
| <a name="input_git_access_mode"></a> [git\_access\_mode](#input\_git\_access\_mode) | Git access mode: 'read-only' or 'read-write' | `string` | `"read-write"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_mode"></a> [access\_mode](#output\_access\_mode) | Applied access mode (read-only or read-write) for the SSH key |
| <a name="output_authorized_keys_path"></a> [authorized\_keys\_path](#output\_authorized\_keys\_path) | Path to the authorized\_keys file where the key was added |
| <a name="output_key_permissions"></a> [key\_permissions](#output\_key\_permissions) | Summary of permissions applied to this key |
| <a name="output_key_with_restrictions"></a> [key\_with\_restrictions](#output\_key\_with\_restrictions) | Complete authorized\_keys entry including all restrictions |
| <a name="output_ssh_key_file_used"></a> [ssh\_key\_file\_used](#output\_ssh\_key\_file\_used) | Path to the SSH public key file that was used |
<!-- END_TF_DOCS -->