<!-- BEGIN_TF_DOCS -->
## GitOps user

Handles the creation and deletion of a dedicated user git+ssh access (gitops)
as well as setting and restoring owner / group of the original gitops repository.

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
| [ssh_resource.add_gitops_user](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |
| [ssh_resource.remove_gitops_user](https://registry.terraform.io/providers/loafoe/ssh/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ssh"></a> [ssh](#input\_ssh) | SSH configuration for remote connection | <pre>object({<br/>    host    = string<br/>    user    = string<br/>    id_file = optional(string, "~/.ssh/id_rsa")<br/>  })</pre> | n/a | yes |
| <a name="input_gitops_user"></a> [gitops\_user](#input\_gitops\_user) | Configuration of GitOps user. | <pre>object({<br/>    user        = optional(string, "gitops")<br/>    group       = optional(string, "gitops")<br/>    repo_name   = optional(string, "repo")<br/>    source_repo = optional(string, "/storage-pool/gitops")<br/>  })</pre> | `{}` | no |
| <a name="input_org_source_repo_owner"></a> [org\_source\_repo\_owner](#input\_org\_source\_repo\_owner) | Original owner of the source repository (before, e.g. root:root) | <pre>object({<br/>    owner = optional(string, "root")<br/>    group = optional(string, "root")<br/>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_git_ssh_url"></a> [git\_ssh\_url](#output\_git\_ssh\_url) | The git+ssh address / URL |
| <a name="output_repo_actual_path"></a> [repo\_actual\_path](#output\_repo\_actual\_path) | Actual path to the git repository |
| <a name="output_repo_local_path"></a> [repo\_local\_path](#output\_repo\_local\_path) | Local path to the repository symlink |
| <a name="output_user"></a> [user](#output\_user) | Name of the gitops user, that allows access to the gitops git repository via SSH |
| <a name="output_user_home"></a> [user\_home](#output\_user\_home) | Home directory of the git user |
<!-- END_TF_DOCS -->