<!-- BEGIN_TF_DOCS -->
## Script Management

Handles the download, execution and cleanup of (shell-)scripts on the host

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
| [ssh_resource.script_cleanup](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.script_download](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.script_execute](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ssh"></a> [ssh](#input\_ssh) | SSH configuration for remote connection | <pre>object({<br/>    host    = string<br/>    user    = string<br/>    id_file = optional(string, "~/.ssh/id_rsa")<br/>  })</pre> | n/a | yes |
| <a name="input_scripts"></a> [scripts](#input\_scripts) | Configuration for script management including shared directory and script items | <pre>object({<br/>    directory = optional(string, "scripts")<br/>    items = list(object({<br/>      name           = string<br/>      url            = string<br/>      apply_params   = optional(string, "")<br/>      destroy_params = optional(string, "")<br/>      run_on_destroy = optional(bool, true)<br/>    }))<br/>  })</pre> | <pre>{<br/>  "directory": "scripts",<br/>  "items": []<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_installed_scripts"></a> [installed\_scripts](#output\_installed\_scripts) | The scripts, that have been installed/removed |
<!-- END_TF_DOCS -->