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
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_ssh"></a> [ssh](#requirement\_ssh) | ~> 2.7 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_ssh"></a> [ssh](#provider\_ssh) | 2.7.0 |

## Resources

| Name | Type |
|------|------|
| [ssh_resource.package_cleanup](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.package_installation](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.script_cleanup](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.script_download](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.script_execute](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ssh_configuration"></a> [ssh\_configuration](#input\_ssh\_configuration) | SSH configuration for remote connection | <pre>object({<br/>    host = string<br/>    user = string<br/>    id   = optional(string, "~/.ssh/id_rsa")<br/>  })</pre> | n/a | yes |
| <a name="input_packages"></a> [packages](#input\_packages) | List of packages to install via apt-get | `list(string)` | `[]` | no |
| <a name="input_scripts"></a> [scripts](#input\_scripts) | Configuration for script management including shared directory and script items | <pre>object({<br/>    directory = optional(string, "scripts")<br/>    items = list(object({<br/>      name           = string<br/>      url            = string<br/>      apply_params   = optional(string, "")<br/>      destroy_params = optional(string, "")<br/>      run_on_destroy = optional(bool, true)<br/>    }))<br/>  })</pre> | <pre>{<br/>  "directory": "scripts",<br/>  "items": []<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_installed_packages"></a> [installed\_packages](#output\_installed\_packages) | n/a |
| <a name="output_managed_scripts"></a> [managed\_scripts](#output\_managed\_scripts) | n/a |
<!-- END_TF_DOCS -->