output "installed_packages" {
  description = "The packages, that have been installed/removed"
  value = [for pkg in var.packages : {
    name   = pkg
    status = "installed at ${timestamp()}"
  }]
}