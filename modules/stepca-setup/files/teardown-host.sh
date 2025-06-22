#!/bin/bash

# Proxmox ACME Certificate Teardown Script
# Reverts ACME certificate setup and removes Step CA configuration

set -euo pipefail

# Initialize variables
ACME_NAME=""
PROXMOX_NODE_NAME=""
LOG_FILE=""

# Function to display usage
usage() {
    cat << EOF
Usage: $0 --proxmox-node-name NAME --acme-name NAME [--log-file FILE]

Reverts ACME certificate setup and removes Step CA configuration from Proxmox nodes.

ARGUMENTS:
    --proxmox-node-name NAME    Name of the Proxmox node to revert configuration on
    --acme-name NAME            Name identifier of the ACME provisioner to remove
    --log-file FILE             Optional log file path (default: stdout)

EXAMPLE:
    $0 --proxmox-node-name pve \\
       --acme-name step-ca \\
       --log-file /var/log/$0.log

EOF
}

# Parse command line arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -a|--acme-name)
                ACME_NAME="$2"
                shift 2
                ;;
            -n|--proxmox-node-name)
                PROXMOX_NODE_NAME="$2"
                shift 2
                ;;
            -l|--log-file)
                LOG_FILE="$2"
                shift 2
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                error_exit "Unknown option: $1. Use --help for usage information."
                ;;
        esac
    done
    
    # Check if all required variables have values
    local missing_params=()
    
    [[ -z "$ACME_NAME" ]] && missing_params+=("--acme-name")
    [[ -z "$PROXMOX_NODE_NAME" ]] && missing_params+=("--proxmox-node-name")
    
    if [[ ${#missing_params[@]} -gt 0 ]]; then
        usage
        error_exit "Missing required parameters: ${missing_params[*]}"
    fi
}

# Logging function
log() {
    local message="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local log_entry="[$timestamp] $message"
    
    echo "$log_entry"
    
    if [[ -n "$LOG_FILE" ]]; then
        echo "$log_entry" >> "$LOG_FILE"
    fi
}

# Error handling function
error_exit() {
    log "ERROR: $1" >&2
    exit 1
}

# Check dependencies
check_dependencies() {
    local deps=("step" "pvesh" "jq")
    local missing_deps=()
    
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            missing_deps+=("$dep")
        fi
    done
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        error_exit "Missing required dependencies: ${missing_deps[*]}"
    fi
}

# Remove Step CA certificate and configuration
cleanup_step_ca() {
    log "Starting Step CA certificate cleanup"
    
    # Uninstall certificate only if it exists
    if [[ -f "/root/.step/certs/root_ca.crt" ]]; then
        log "Uninstalling root_ca.crt certificate"
        if step certificate uninstall /root/.step/certs/root_ca.crt; then
            log "Root CA certificate uninstalled successfully"
            log "Updating CA certificates..."
            update-ca-certificates --fresh
        else
            log "Warning: Failed to uninstall root CA certificate"
        fi
    else
        log "Root CA certificate not found, skipping uninstall"
    fi

    # Remove .step directory only if it exists
    if [[ -d "/root/.step" ]]; then
        log "Removing /root/.step directory"
        if rm -rf /root/.step; then
            log "Step directory removed successfully"
        else
            log "Warning: Failed to remove step directory"
        fi
    else
        log "Step directory not found, skipping removal"
    fi
    
    log "Step CA cleanup completed"
}

# Remove ACME configuration
cleanup_acme() {
    log "Starting ACME cleanup for account: $ACME_NAME"
    log "Proxmox node: $PROXMOX_NODE_NAME"
    
    # Check if the ACME account exists in the cluster
    log "Checking if ACME account exists: $ACME_NAME"
    
    local is_acme_account_exists
    if ! is_acme_account_exists=$(pvesh get /cluster/acme/account --output-format json 2>/dev/null | jq -r --arg name "$ACME_NAME" 'any(.[]; .name == $name)' 2>/dev/null); then
        log "Warning: Could not check existing ACME accounts"
        is_acme_account_exists="false"
    fi
    
    # Check if the ACME account is currently in use on this node
    log "Checking if ACME account is in use on this node"
    
    local is_current_acme_account
    if ! is_current_acme_account=$(pvesh get "/nodes/${PROXMOX_NODE_NAME}/config" --property acme --output-format json 2>/dev/null | jq -r --arg name "$ACME_NAME" '.acme | match("account=([^,]+)") | .captures[0].string == $name' 2>/dev/null); then
        log "Warning: Could not check current ACME account configuration"
        is_current_acme_account="false"
    fi
    
    # Debug output
    log "IS_ACME_ACCOUNT_EXISTS: $is_acme_account_exists"
    log "IS_CURRENT_ACME_ACCOUNT: $is_current_acme_account"
    
    # Only revoke certificates if this specific ACME account is currently in use
    if [[ "$is_current_acme_account" = "true" ]]; then
        log "Revoking ACME certificates for account: $ACME_NAME"
        if pvesh delete "/nodes/${PROXMOX_NODE_NAME}/certificates/acme/certificate"; then
            log "ACME certificates revoked successfully"
        else
            log "Warning: Failed to revoke ACME certificates"
        fi

        if pvesh set "/nodes/${PROXMOX_NODE_NAME}/config" --delete acme; then
            log "ACME domains removed successfully"
        else
            log "Warning: Failed to remove ACME domains"
        fi
    else
        log "ACME account $ACME_NAME is not in use on this node, skipping certificate revocation"
    fi
    
    # Only delete the ACME account if it exists
    if [[ "$is_acme_account_exists" = "true" ]]; then
        log "Deleting ACME account: $ACME_NAME"
        if pvesh delete "/cluster/acme/account/${ACME_NAME}"; then
            log "ACME account deleted successfully"
        else
            log "Warning: Failed to delete ACME account"
        fi
    else
        log "ACME account $ACME_NAME does not exist, skipping deletion"
    fi
    
    log "ACME cleanup completed"
}

# Main function
main() {
    # Parse command line arguments first
    parse_args "$@"
    
    # Check dependencies
    check_dependencies
    
    # Create log file directory if specified
    if [[ -n "$LOG_FILE" ]]; then
        local log_dir
        log_dir=$(dirname "$LOG_FILE")
        if [[ ! -d "$log_dir" ]]; then
            mkdir -p "$log_dir" || error_exit "Failed to create log directory: $log_dir"
        fi
        log "Logging to file: $LOG_FILE"
    fi
    
    # Remove ACME configuration
    cleanup_acme
    
    # Remove Step CA certificate and configuration
    cleanup_step_ca

    log "Teardown script completed successfully"
}

# Run main function with all arguments
main "$@"