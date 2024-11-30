<!-- BEGIN_TF_DOCS -->
## Terraform user

Handles the creation and deletion of a dedicated user with a custom role
and API token for the Terraform provisioner on the host.

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
| [ssh_resource.assign_role](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.create_api_token](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.create_role](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.create_user](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.delete_api_token](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.delete_role](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.delete_user](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.unassign_role](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ssh"></a> [ssh](#input\_ssh) | SSH configuration for remote connection | <pre>object({<br/>    host    = string<br/>    user    = string<br/>    id_file = optional(string, "~/.ssh/id_rsa")<br/>  })</pre> | n/a | yes |
| <a name="input_terraform_user"></a> [terraform\_user](#input\_terraform\_user) | Configuration for Terraform provisioner user. Individual fields can be overridden. | <pre>object({<br/>    name    = optional(string, "terraform@pve")<br/>    comment = optional(string, "Terraform automation user")<br/>    role = object({<br/>      name = optional(string, "TerraformProv")<br/>      privileges = optional(list(string), [<br/>        "VM.Allocate",<br/>        "VM.Clone",<br/>        "VM.Config.Disk",<br/>        "VM.Config.CPU",<br/>        "VM.Config.Memory",<br/>        "VM.Config.Network",<br/>        "VM.Config.Cloudinit",<br/>        "VM.Config.Options",<br/>        "VM.PowerMgmt",<br/>        "VM.Monitor",<br/>        "Datastore.Allocate",<br/>        "Datastore.AllocateSpace",<br/>        "Datastore.Audit",<br/>        "SDN.Use",<br/>        "Sys.Audit",<br/>        "Sys.Modify"<br/>      ])<br/>    })<br/>    token = object({<br/>      name    = optional(string, "terraform-token")<br/>      comment = optional(string, "Terraform automation user API token")<br/>    })<br/>  })</pre> | <pre>{<br/>  "role": {},<br/>  "token": {}<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pve-user"></a> [pve-user](#output\_pve-user) | The user and role created on the Proxmox host |
| <a name="output_token"></a> [token](#output\_token) | The API token created on the Proxmox host |
<!-- END_TF_DOCS -->