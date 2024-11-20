/**
 * ## User Management
 *
 * Handles the creation and deletion of a dedicated user with a custom role
 * and API token for the Terraform provisioner on the host
 */
resource "ssh_resource" "create_terraform_user" {
  # when = "create"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

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
  # when = "create"
  timeout = "30s"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  depends_on = [ssh_resource.create_terraform_user]

  commands = [
    "pveum user token add ${var.terraform_user.name} ${var.terraform_user.token.name} --comment '${var.terraform_user.token.comment}' --privsep=0 --output-format=json"
  ]
}

resource "ssh_resource" "remove_terraform_user" {
  when    = "destroy"
  timeout = "30s"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    # Remove in correct order to prevent dependency issues
    "pveum user token remove ${var.terraform_user.name} ${var.terraform_user.token.name}",
    "pveum user delete ${var.terraform_user.name}",
    "pveum role delete ${var.terraform_user.role.name}"
  ]
}