/**
 * ## User Management
 *
 * Handles the creation and deletion of a dedicated user with a custom role
 * and API token for the Terraform provisioner on the host
 */

locals {
  rawtoken = jsondecode(ssh_resource.create_terraform_api_token.result)
  token = "PVEAPIToken=${local.rawtoken.full-tokenid}=${local.rawtoken.value}"
}

resource "ssh_resource" "create_terraform_user" {
  host        = local.ssh_config.host
  user        = local.ssh_config.user
  private_key = local.ssh_config.private_key

  # when = "create"

  commands = [
    # Create user, who cannot login
    "pveum user add ${var.terraform_user.name} --comment '${var.terraform_user.comment}'",

    # Create role with permissions needed for Talos/K8s setup
    "pveum role add ${var.terraform_user.role.name} -privs '${join(",", var.terraform_user.role.privileges)}'",

    # Assign role to user
    "pveum aclmod / -user ${var.terraform_user.name} -role ${var.terraform_user.role.name}"
  ]
}

resource "ssh_resource" "create_terraform_api_token" {
  host        = local.ssh_config.host
  user        = local.ssh_config.user
  private_key = local.ssh_config.private_key

  # when = "create"
  timeout = "30s"

  depends_on = [ssh_resource.create_terraform_user]

  commands = [
    "pveum user token add ${var.terraform_user.name} ${var.terraform_user.token.name} --comment '${var.terraform_user.token.comment}' --privsep=0 --output-format=json"
  ]
}

resource "ssh_resource" "remove_terraform_user" {
  host        = local.ssh_config.host
  user        = local.ssh_config.user
  private_key = local.ssh_config.private_key

  when    = "destroy"
  timeout = "30s"

  commands = [
    # Remove in correct order to prevent dependency issues
    "pveum user token remove ${var.terraform_user.name} ${var.terraform_user.token.name}",
    "pveum user delete ${var.terraform_user.name}",
    "pveum role delete ${var.terraform_user.role.name}"
  ]
}