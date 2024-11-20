locals {
  # SSH connection settings for reuse
  ssh = {
    host        = var.ssh.host
    user        = var.ssh.user
    private_key = file(var.ssh.id_file)
  }

  # User and API token token
  rawtoken = jsondecode(ssh_resource.create_terraform_api_token.result)
  token    = "PVEAPIToken=${local.rawtoken.full-tokenid}=${local.rawtoken.value}"
}