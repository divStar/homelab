/**
 * # Host setup module
 * 
 * This module manages remote script execution and package installation via SSH.
 * 
 * ## Usage
 * 
 * ```hcl
 * module "remote_setup" {
 *   source = "github.com/username/repo"
 *   
 *   ssh_configuration = {
 *     host = "example.com"
 *     user = "admin"
 *   }
 *
 *   packages = [
 *     "vim",
 *     "git"
 *   ]
 *
 *   scripts = {
 *     items = [
 *         {
 *             name = "pve-mod-nag-screen.sh"
 *             url = "https://raw.githubusercontent.com/Meliox/PVE-mods/refs/heads/main/pve-mod-nag-screen.sh"
 *             apply_params = "install"
 *             destroy_params = "uninstall"
 *             # run_on_destroy defaults to true if not specified
 *         }
 *     ]
 *   }
 * }
 * ```
 */

locals {
  # SSH connection settings for reuse
  ssh_config = {
    host        = var.ssh_configuration.host
    user        = var.ssh_configuration.user
    private_key = file(var.ssh_configuration.id)
  }

  # Script paths and commands
  script_paths = { for script in var.scripts.items : script.name => "${var.scripts.directory}/${script.name}" }
  cleanup_dir_cmd = "if [ -d '${var.scripts.directory}' ] && [ -z \"$(ls -A '${var.scripts.directory}')\" ]; then rmdir '${var.scripts.directory}'; fi"

  # Package management commands
  pkg_install_cmd = [for pkg in var.packages : "DEBIAN_FRONTEND=noninteractive apt-get install -y ${pkg}"]
  pkg_remove_cmd  = [for pkg in var.packages : "DEBIAN_FRONTEND=noninteractive apt-get remove -y ${pkg}"]

  # User management result
  token_data = jsondecode(ssh_resource.proxmox_api_token.result)
}

#------------------------------------------------------------------------------
# Package Management Resources
#------------------------------------------------------------------------------

resource "ssh_resource" "package_installation" {
    host         = local.ssh_config.host
    user         = local.ssh_config.user
    private_key  = local.ssh_config.private_key
    
    commands = concat(
        ["apt-get update"],
        local.pkg_install_cmd
    )

    lifecycle {
        create_before_destroy = true
    }
}

resource "ssh_resource" "package_cleanup" {
    host         = local.ssh_config.host
    user         = local.ssh_config.user
    private_key  = local.ssh_config.private_key
    
    when = "destroy"

    commands = concat(
        local.pkg_remove_cmd,
        ["apt-get autoremove -y"],
        ["apt-get clean"]
    )

    lifecycle {
        create_before_destroy = true
    }
}

#------------------------------------------------------------------------------
# Script Management Resources
#------------------------------------------------------------------------------

resource "ssh_resource" "script_download" {
    host         = local.ssh_config.host
    user         = local.ssh_config.user
    private_key  = local.ssh_config.private_key

    for_each = { for script in var.scripts.items : script.name => script }

    commands = [
        "mkdir -p '${var.scripts.directory}'",
        "wget -O '${local.script_paths[each.key]}' '${each.value.url}'",
        "chmod +x '${local.script_paths[each.key]}'"
    ]

    lifecycle {
        create_before_destroy = true
    }
}

resource "ssh_resource" "script_execute" {
    host         = local.ssh_config.host
    user         = local.ssh_config.user
    private_key  = local.ssh_config.private_key

    for_each = { for script in var.scripts.items : script.name => script }

    depends_on = [ssh_resource.script_download]

    commands = ["'${local.script_paths[each.key]}' ${each.value.apply_params}"]

    lifecycle {
        create_before_destroy = true
    }
}

resource "ssh_resource" "script_cleanup" {
    host         = local.ssh_config.host
    user         = local.ssh_config.user
    private_key  = local.ssh_config.private_key

    for_each = { for script in var.scripts.items : script.name => script }

    when = "destroy"

    commands = each.value.run_on_destroy ? [
        "'${local.script_paths[each.key]}' ${each.value.destroy_params}",
        "rm -f '${local.script_paths[each.key]}'",
        local.cleanup_dir_cmd
    ] : [
        "rm -f '${local.script_paths[each.key]}'",
        local.cleanup_dir_cmd
    ]

    lifecycle {
        create_before_destroy = true
    }
}

#------------------------------------------------------------------------------
# User Management Resources
#------------------------------------------------------------------------------

resource "ssh_resource" "proxmox_terraform_user_create" {
    host         = local.ssh_config.host
    user         = local.ssh_config.user
    private_key  = local.ssh_config.private_key

    # when = "create"

    commands = [
        # Create user with no password (API token only)
        "pveum user add terraform@pve --comment 'Terraform automation user' --enable 0",

        # Create role with permissions needed for Talos/K8s setup
        "pveum role add TerraformProv -privs 'VM.Allocate,VM.Clone,VM.Config.Disk,VM.Config.CPU,VM.Config.Memory,VM.Config.Network,VM.Config.Cloudinit,VM.Config.Options,VM.PowerMgmt,VM.Monitor,Datastore.Allocate,Datastore.AllocateSpace,Datastore.Audit,SDN.Use,Sys.Audit'",

        # Assign role to user
        "pveum aclmod / -user terraform@pve -role TerraformProv"
    ]
}

resource "ssh_resource" "proxmox_api_token" {
    host         = local.ssh_config.host
    user         = local.ssh_config.user
    private_key  = local.ssh_config.private_key

    # when = "create"

    depends_on = [ssh_resource.proxmox_terraform_user_create]

    commands = [
        "pveum user token add terraform@pve terraform-token --privsep=0 --output-format=json"
    ]
}

resource "ssh_resource" "proxmox_terraform_cleanup" {
    host         = local.ssh_config.host
    user         = local.ssh_config.user
    private_key  = local.ssh_config.private_key

    when = "destroy"
    timeout = "30s"

    commands = [
        # Remove in correct order to prevent dependency issues
        "pveum user token remove terraform@pve terraform-token",
        "pveum user delete terraform@pve",
        "pveum role delete TerraformProv"
    ]
}