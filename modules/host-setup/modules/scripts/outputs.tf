output "installed_scripts" {
  description = "The scripts, that have been installed/removed"
  value = { for script in var.scripts.items : script.name => {
    url            = script.url
    name           = script.name
    path_on_host   = var.scripts.directory
    run_on_destroy = script.run_on_destroy
    apply_params   = script.apply_params
    destroy_params = script.destroy_params
  } }
}