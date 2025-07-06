#!/bin/bash

function print_usage() {
    echo "Usage: $0 PROXMOX_HOST [--dry-run] [--tf-path PATH]"
    echo "  PROXMOX_HOST    : Hostname/IP of your Proxmox server"
    echo "  --dry-run       : Optional. Show what would be done without making changes"
    echo "  --tf-path PATH  : Optional. Path to Terraform files (default: current directory)"
    exit 1
}

# Check if host argument is provided
if [ $# -lt 1 ]; then
    print_usage
fi

PROXMOX_HOST="$1"
shift  # Remove first argument, leaving any remaining flags

# Initialize variables
DRY_RUN=0
TF_PATH="."

# Parse remaining arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run)
            DRY_RUN=1
            echo "Running in DRY RUN mode - no changes will be made"
            shift
            ;;
        --tf-path)
            if [[ -z "$2" ]] || [[ "$2" == --* ]]; then
                echo "Error: --tf-path requires a path argument"
                print_usage
            fi
            TF_PATH="$2"
            shift 2
            ;;
        *)
            echo "Error: Unknown option $1"
            print_usage
            ;;
    esac
done

echo "Starting cleanup process..."

# SSH into Proxmox and stop/delete VMs
echo "Connecting to ${PROXMOX_HOST}..."
if [ $DRY_RUN -eq 1 ]; then
    echo "[DRY RUN] Would SSH into ${PROXMOX_HOST} and execute:"
    echo "  - Check and stop VM 810 if running"
    echo "  - Delete VM 810"
    echo "  - Check and stop VM 820 if running"
    echo "  - Delete VM 820"
else
    ssh root@${PROXMOX_HOST} << 'EOF'
        # Stop VMs if they're running
        for VMID in 810; do
            if qm status $VMID | grep -q "status: running"; then
                echo "Stopping VM $VMID..."
                qm stop $VMID
                # Wait for VM to stop
                while qm status $VMID | grep -q "status: running"; do
                    sleep 2
                done
            fi
            
            # Delete VM
            echo "Deleting VM $VMID..."
            qm destroy $VMID
        done
EOF

    # Check SSH command status
    if [ $? -ne 0 ]; then
        echo "Error: Failed to execute commands on Proxmox host"
        exit 1
    fi
fi

# Remove Terraform-related files
echo "Cleaning up Terraform files in: ${TF_PATH}"
if [ $DRY_RUN -eq 1 ]; then
    echo "[DRY RUN] Would remove:"
    echo "  - ${TF_PATH}/terraform.lock.hcl file"
    echo "  - ${TF_PATH}/terraform.tfstate* files"
else
    # Check if the path exists
    if [ ! -d "$TF_PATH" ]; then
        echo "Warning: Terraform path '$TF_PATH' does not exist"
    else
        rm -f "${TF_PATH}/terraform.lock.hcl"
        rm -f "${TF_PATH}"/terraform.tfstate*
    fi
fi

echo "Cleanup completed successfully!"