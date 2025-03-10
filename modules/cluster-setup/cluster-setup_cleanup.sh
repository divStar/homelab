#!/bin/bash

function print_usage() {
    echo "Usage: $0 PROXMOX_HOST [--dry-run]"
    echo "  PROXMOX_HOST    : Hostname/IP of your Proxmox server"
    echo "  --dry-run       : Optional. Show what would be done without making changes"
    exit 1
}

# Check if host argument is provided
if [ $# -lt 1 ]; then
    print_usage
fi

PROXMOX_HOST="$1"
shift  # Remove first argument, leaving any remaining flags

# Check for dry run flag
DRY_RUN=0
if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=1
    echo "Running in DRY RUN mode - no changes will be made"
fi

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
        for VMID in 810 820; do
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
echo "Cleaning up Terraform files..."
if [ $DRY_RUN -eq 1 ]; then
    echo "[DRY RUN] Would remove:"
    echo "  - terraform.lock.hcl file"
    echo "  - terraform.tfstate* files"
else
    rm -f terraform.lock.hcl
    rm -f terraform.tfstate*
fi

echo "Cleanup completed successfully!"