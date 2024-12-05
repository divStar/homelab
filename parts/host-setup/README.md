<!-- BEGIN_TF_DOCS -->

# Configuration files to copy to the host
configuration_files = ""

# Proxmox host configuration
proxmox = ""

# SSH configuration for remote connection
ssh = ""

# Configuration of the storage (pools and directories) to import
storage = ""

# Configuration of GitOps user.
gitops_user = {}

# Whether to use no-subscription repository instead of enterprise repository or not
no_subscription = {
  "enabled": true
}

# Original owner of the source repository (before, e.g. root:root)
org_source_repo_owner = {}

# List of packages to install via apt-get
packages = []

# Configuration for script management including shared directory and script items
scripts = {
  "directory": "scripts",
  "items": []
}

# Configuration for Terraform provisioner user. Individual fields can be overridden.
terraform_user = {
  "role": {},
  "token": {}
}
<!-- END_TF_DOCS -->