/**
 * ## Terraform user
 *
 * Handles the creation and deletion of a dedicated user with a custom role
 * and API token for the Terraform provisioner on the host.
 */
resource "ssh_resource" "create_user" {
  # when = "create"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    # Create user, who cannot login
    "pveum user add ${local.terraform_user.name} --comment '${local.terraform_user.comment}'"
  ]
}

resource "ssh_resource" "create_role" {
  # when = "create"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    # Create role with permissions needed for Talos/K8s setup
    "pveum role add ${local.terraform_user.role.name} -privs '${join(",", local.terraform_user.role.privileges)}'"
  ]
}

resource "ssh_resource" "assign_role" {
  # when = "create"
  depends_on = [ssh_resource.create_user, ssh_resource.create_role]

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    # Assign role to user
    "pveum aclmod / -user ${local.terraform_user.name} -role ${local.terraform_user.role.name}"
  ]
}

resource "ssh_resource" "create_api_token" {
  # when = "create"
  timeout = "30s"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    # Create a user token with the same privileges as the user himself
    "pveum user token add ${local.terraform_user.name} ${local.terraform_user.token.name} --comment '${local.terraform_user.token.comment}' --privsep=0 --output-format=json"
  ]
}

resource "ssh_resource" "delete_api_token" {
  when    = "destroy"
  timeout = "30s"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    # Remove the user token
    "pveum user token remove ${local.terraform_user.name} ${local.terraform_user.token.name}"
  ]
}

resource "ssh_resource" "unassign_role" {
  when = "destroy"

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    # Unassign the role
    "pveum user modify ${local.terraform_user.name} --remove-role ${local.terraform_user.role.name}"
  ]
}

resource "ssh_resource" "delete_role" {
  when       = "destroy"
  depends_on = [ssh_resource.unassign_role]

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    # Remove the role
    "pveum role delete ${local.terraform_user.role.name}"
  ]
}

resource "ssh_resource" "delete_user" {
  when       = "destroy"
  depends_on = [ssh_resource.unassign_role]

  host        = local.ssh.host
  user        = local.ssh.user
  private_key = local.ssh.private_key

  commands = [
    # Remove the user
    "pveum user delete ${local.terraform_user.name}",
  ]
}