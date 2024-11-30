<!-- BEGIN_TF_DOCS -->
## Copy configurations

Handles the copying of configuration files to the host.

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
| [ssh_resource.copy_configuration_files](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.remove_configuration_files](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_configuration_files"></a> [configuration\_files](#input\_configuration\_files) | Configuration files to copy to the host | <pre>list(object({<br/>    source      = string<br/>    destination = string<br/>    permissions = optional(number)<br/>    owner       = optional(string)<br/>    group       = optional(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_ssh"></a> [ssh](#input\_ssh) | SSH configuration for remote connection | <pre>object({<br/>    host    = string<br/>    user    = string<br/>    id_file = optional(string, "~/.ssh/id_rsa")<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_configuration_files"></a> [configuration\_files](#output\_configuration\_files) | Configuration files copied to host |
<!-- END_TF_DOCS -->