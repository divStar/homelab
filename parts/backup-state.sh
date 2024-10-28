#!/bin/bash

# backup-state.sh
DEFAULT_HOST="192.168.178.27"
DEFAULT_USER="root"

# Show usage/help
show_usage() {
    echo "Usage: ./backup-state.sh -d remote_dir [-h host] [-u user]"
    echo
    echo "Required:"
    echo "  -d dir        Remote directory (e.g., /root/terraform-state)"
    echo
    echo "Options:"
    echo "  -h host       Target host (default: $DEFAULT_HOST)"
    echo "  -u user       Remote user (default: $DEFAULT_USER)"
    echo
    echo "Examples:"
    echo "  ./backup-state.sh -d /root/terraform-state"
    echo "  ./backup-state.sh -d /root/state -h 10.0.0.1"
    echo "  ./backup-state.sh -d /home/admin/tfstate -u admin"
}

# Set defaults
HOST=$DEFAULT_HOST
USER=$DEFAULT_USER
REMOTE_DIR=""

# Parse options
while getopts "h:u:d:" opt; do
    case $opt in
        h) HOST="$OPTARG" ;;
        u) USER="$OPTARG" ;;
        d) REMOTE_DIR="$OPTARG" ;;
        \?) show_usage; exit 1 ;;
    esac
done

# Check if remote directory is specified
if [ -z "$REMOTE_DIR" ]; then
    echo "Error: Remote directory (-d) must be specified"
    echo
    show_usage
    exit 1
fi

# Check if terraform state files exist
if ! ls terraform.tfstate* >/dev/null 2>&1; then
    echo "Error: No terraform state files found in current directory"
    exit 1
fi

# Create remote directory and copy files
ssh $USER@$HOST "mkdir -p $REMOTE_DIR" && scp terraform.tfstate* $USER@$HOST:$REMOTE_DIR/

exit_code=$?
if [ $exit_code -eq 0 ]; then
    echo "Successfully backed up terraform state file(s) to $USER@$HOST:$REMOTE_DIR/"
else
    echo "Failed to backup terraform state file(s)"
    exit $exit_code
fi