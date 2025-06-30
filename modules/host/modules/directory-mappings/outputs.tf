output "directory_mappings" {
  description = "Directory mappings created"
  value = [
    for mapping in var.directory_mappings : {
      id      = mapping.id
      path    = mapping.path
      comment = mapping.comment
    }
  ]
}