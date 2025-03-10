#!/bin/bash

# restore-state.sh
DEFAULT_HOST="192.168.178.27"
DEFAULT_USER="root"

# Show usage/help
show_usage() {
    echo "Usage: ./restore-state.sh -d remote_dir [-h host] [-u user] [-o output_dir]"
    echo
    echo "Required:"
    echo "  -d dir        Remote directory (e.g., /root/terraform-state)"
    echo
    echo "Options:"
    echo "  -h host       Target host (default: $DEFAULT_HOST)"
    echo "  -u user       Remote user (default: $DEFAULT_USER)"
    echo "  -o dir        Local output directory (default: current directory)"
    echo
    echo "Examples:"
    echo "  ./restore-state.sh -d /root/terraform-state"
    echo "  ./restore-state.sh -d /root/state -h 10.0.0.1 -o ./my-project"
    echo "  ./restore-state.sh -d /home/admin/tfstate -u admin -o ../other-project"
}

# Set defaults
HOST=$DEFAULT_HOST
USER=$DEFAULT_USER
REMOTE_DIR=""
OUTPUT_DIR="."

# Parse options
while getopts "h:u:d:o:" opt; do
    case $opt in
        h) HOST="$OPTARG" ;;
        u) USER="$OPTARG" ;;
        d) REMOTE_DIR="$OPTARG" ;;
        o) OUTPUT_DIR="$OPTARG" ;;
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

# Create local output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Copy terraform state files from remote to local
scp "$USER@$HOST:$REMOTE_DIR/terraform.tfstate*" "$OUTPUT_DIR/"

exit_code=$?
if [ $exit_code -eq 0 ]; then
    echo "Successfully restored terraform state file(s) from $USER@$HOST:$REMOTE_DIR/ to $OUTPUT_DIR/"
else
    echo "Failed to restore terraform state file(s)"
    exit $exit_code
fi