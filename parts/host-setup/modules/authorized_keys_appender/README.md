<!-- BEGIN_TF_DOCS -->

# Name of the symbolic link to the actual gitops git repository
repo_name = ""

# SSH configuration for remote connection
ssh = ""

# Path to SSH public key file to add to authorized_keys (e.g. ~/.ssh/id_rsa.pub)
ssh_key_file = ""

# Username to add SSH key for
target_user = ""

# Git access mode: 'read-only' or 'read-write'
git_access_mode = "read-write"
<!-- END_TF_DOCS -->