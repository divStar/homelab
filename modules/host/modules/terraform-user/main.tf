/**
 * # Terraform user
 *
 * Handles the creation and deletion of a dedicated user with a custom role
 * and API token for the Terraform provisioner on the host.
 */
locals {
  # SSH connection settings for reuse
  ssh = {
    host        = var.ssh.host
    user        = var.ssh.user
    private_key = file(var.ssh.id_file)
  }

  # User and API token token
  rawtoken = jsondecode(ssh_resource.create_api_token.result)
  token    = "PVEAPIToken=${local.rawtoken.full-tokenid}=${local.rawtoken.value}"
}

resource "ssh_resource" "create_user" {
  # when = "create"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    # Create user, who cannot login
    "pveum user add ${var.terraform_user.name} --comment '${var.terraform_user.comment}'"
  ]

  timeout = "20s"
}

resource "ssh_resource" "create_role" {
  # when = "create"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    # Create role with permissions needed for Talos/K8s setup
    "pveum role add ${var.terraform_user.role.name} -privs '${join(",", var.terraform_user.role.privileges)}'"
  ]

  timeout = "20s"
}

resource "ssh_resource" "assign_role" {
  # when = "create"
  depends_on = [ssh_resource.create_user, ssh_resource.create_role]

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    # Assign role to user
    "pveum aclmod / -user ${var.terraform_user.name} -role ${var.terraform_user.role.name}"
  ]

  timeout = "20s"
}

resource "ssh_resource" "create_api_token" {
  # when = "create"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    # Create a user token with the same privileges as the user himself
    "pveum user token add ${var.terraform_user.name} ${var.terraform_user.token.name} --comment '${var.terraform_user.token.comment}' --privsep=0 --output-format=json"
  ]

  timeout = "20s"
}

resource "ssh_resource" "delete_role" {
  when = "destroy"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    # Remove the role
    "pveum role delete ${var.terraform_user.role.name}"
  ]

  timeout = "20s"
}

resource "ssh_resource" "delete_user" {
  when = "destroy"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    # Remove the user
    "pveum user delete ${var.terraform_user.name}",
  ]

  timeout = "20s"
}