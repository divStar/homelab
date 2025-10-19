output "imported_directories" {
  description = "List of imported directories, their mountpoints and types"
  value = {
    for k, v in var.storage_directories : k => {
      path    = v.path
      content = split(",", v.content)
    }
  }
}