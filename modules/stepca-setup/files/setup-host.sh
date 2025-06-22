#!/bin/bash

# Proxmox ACME Certificate Setup Script
# Sets up ACME certificates using Step CA for Proxmox nodes

set -euo pipefail

# Initialize variables
STEP_SERVER=""
FINGERPRINT=""
ACME_NAME=""
ACME_CONTACT=""
PROXMOX_NODE_NAME=""
ACME_DOMAINS=""
LOG_FILE=""

# Function to display usage
usage() {
    cat << EOF
Usage: $0 --step-server IP --proxmox-node-name NAME --fingerprint FINGERPRINT --acme-name NAME --acme-contact EMAIL --acme-domains DOMAINS [--log-file FILE]

Sets up ACME certificates using Step CA for Proxmox nodes.

ARGUMENTS:
    --step-server IP            IP address or hostname of the Step CA server
    --proxmox-node-name NAME    Name of the Proxmox node to configure
    --fingerprint FINGERPRINT   SHA256 fingerprint of the Step CA root certificate
    --acme-name NAME            Name identifier of the ACME provisioner in Step CA
    --acme-contact EMAIL        Contact email address for ACME certificate requests
    --acme-domains DOMAINS      Semicolon-separated list of domains/IPs for the certificate
    --log-file FILE             (Optional) log file path (default: stdout)

EXAMPLE:
    $0 --step-server 192.168.1.100 \\
       --proxmox-node-name pve01 \\
       --fingerprint abcd1234efgh5678ijkl9012mnop3456qrst7890 \\
       --acme-name step-ca \\
       --acme-contact admin@example.com \\
       --acme-domains "pve01.example.com;192.168.1.10" \\
       --log-file /var/log/$0.log

EOF
}

# Parse command line arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -i|--step-server)
                STEP_SERVER="$2"
                shift 2
                ;;
            -f|--fingerprint)
                FINGERPRINT="$2"
                shift 2
                ;;
            -a|--acme-name)
                ACME_NAME="$2"
                shift 2
                ;;
            -c|--acme-contact)
                ACME_CONTACT="$2"
                shift 2
                ;;
            -n|--proxmox-node-name)
                PROXMOX_NODE_NAME="$2"
                shift 2
                ;;
            -d|--acme-domains)
                ACME_DOMAINS="$2"
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
    
    [[ -z "$STEP_SERVER" ]] && missing_params+=("--step-server")
    [[ -z "$FINGERPRINT" ]] && missing_params+=("--fingerprint")
    [[ -z "$ACME_NAME" ]] && missing_params+=("--acme-name")
    [[ -z "$ACME_CONTACT" ]] && missing_params+=("--acme-contact")
    [[ -z "$PROXMOX_NODE_NAME" ]] && missing_params+=("--proxmox-node-name")
    [[ -z "$ACME_DOMAINS" ]] && missing_params+=("--acme-domains")
    
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

# Validate required parameters
validate_params() {
    # Validate email format (basic check)
    if [[ ! "$ACME_CONTACT" =~ ^[^@]+@[^@]+\.[^@]+$ ]]; then
        error_exit "Invalid email format: $ACME_CONTACT"
    fi
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

# Bootstrap Step CA certificate
bootstrap_certificate() {
    log "Starting Step CA certificate bootstrap"
    log "Step CA IP: $STEP_SERVER"
    log "Fingerprint: $FINGERPRINT"
    
    # Install certificate
    log "Installing Step CA certificate..."
    
    if ! step ca bootstrap --ca-url "https://${STEP_SERVER}" --fingerprint "$FINGERPRINT" --install --force; then
        error_exit "Failed to bootstrap Step CA certificate"
    fi
    
    log "Step CA certificate installed successfully"
}

# Setup ACME configuration
setup_acme() {
    log "Starting ACME setup for Proxmox node: $PROXMOX_NODE_NAME"
    log "ACME Account: $ACME_NAME"
    log "ACME Contact: $ACME_CONTACT"
    log "ACME Domains: $ACME_DOMAINS"

    # Check if ACME account already exists and register it if possible
    if pvesh get /cluster/acme/account --output-format json | jq --exit-status --arg acme_name "$ACME_NAME" '.[] | select(.name == $acme_name)' > /dev/null 2>&1; then
        log "WARNING: ACME account '$ACME_NAME' already exists. Please verify it's configured correctly for Step CA at https://${STEP_SERVER}/acme/${ACME_NAME}/directory"
    elif ! pvesh create /cluster/acme/account --name "$ACME_NAME" --directory "https://${STEP_SERVER}/acme/${ACME_NAME}/directory" --contact "$ACME_CONTACT"; then
        error_exit "Failed to register ACME account"
    fi
    log "ACME account registered successfully: $ACME_NAME"
    
    # Set ACME domains and/or IP addresses on the host
    log "Configuring ACME domains on node: $PROXMOX_NODE_NAME"
    if ! pvesh set "/nodes/${PROXMOX_NODE_NAME}/config" --acme "account=${ACME_NAME},domains=${ACME_DOMAINS}"; then
        error_exit "Failed to configure ACME domains"
    fi
    
    log "ACME domains configured successfully"
    
    # Order certificates
    log "Ordering ACME certificates..."
    # Note: sometimes the order process will fail saying the CSR was unacceptable (badCSR).
    # This is very likely due to IP addresses in the domain list and the following bug: https://bugzilla.proxmox.com/show_bug.cgi?id=4687
    # TODO: remove this comment once the mentioned bug is fixed.
    if ! pvesh create "/nodes/${PROXMOX_NODE_NAME}/certificates/acme/certificate" --force true; then
        error_exit "Failed to order ACME certificates"
    fi
    
    log "ACME certificates ordered successfully"
    log "ACME setup completed successfully for account: $ACME_NAME"
}

# Main function
main() {
    # Parse command line arguments first
    parse_args "$@"
    
    # Validate parameters
    validate_params
    
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
    
    # Bootstrap Step CA certificate
    bootstrap_certificate
    
    # Setup ACME configuration
    setup_acme
    
    log "Script completed successfully"
}

# Run main function with all arguments
main "$@"