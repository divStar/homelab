#!/bin/bash

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to display usage information
show_usage() {
    echo "Usage: $0 [OPTIONS] [PATH]"
    echo "  PATH: Directory path to search for modules (default: ../)"
    echo "Options:"
    echo "  -v, --verbose    Show terraform-docs output and errors"
    echo "  -h, --help       Show this help message"
    echo "Example: $0 /path/to/terraform/modules"
    echo "         $0 --verbose ../../infrastructure"
    exit 0
}

# Function to parse and validate command line arguments
parse_arguments() {
    SEARCH_PATH="../"
    VERBOSE=false
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_usage
                ;;
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            -*)
                echo "Error: Unknown option $1"
                show_usage
                ;;
            *)
                if [ "$SEARCH_PATH" != "../" ]; then
                    echo "Error: Multiple paths provided."
                    show_usage
                fi
                SEARCH_PATH="$1"
                shift
                ;;
        esac
    done
    
    # Convert to absolute path and validate
    SEARCH_PATH=$(realpath "$SEARCH_PATH" 2>/dev/null)
    if [ $? -ne 0 ] || [ ! -d "$SEARCH_PATH" ]; then
        echo "Error: Invalid path. Directory does not exist."
        exit 1
    fi
}

# Function to validate config file
validate_config() {
    local config_path="$1"
    
    if [ ! -f "$config_path" ]; then
        echo "Error: Config file $config_path not found!"
        exit 1
    fi
}

# Function to find terraform modules
find_terraform_modules() {
    local search_path="$1"
    
    find "$search_path" -type f -name "*.tf" -not -path "*/.terraform/*" -exec dirname {} \; | sort -u
}

# Function to get relative path for display
get_display_path() {
    local module_dir="$1"
    local search_path="$2"
    
    # Get relative path by removing the search path prefix
    local relative_path="${module_dir#$search_path}"
    # Remove leading slash if present
    relative_path="${relative_path#/}"
    # If empty (same directory), use the directory name instead of dot
    if [ -z "$relative_path" ]; then
        relative_path="$(basename "$search_path")"
    fi
    
    echo "$relative_path"
}

# Function to run terraform-docs on a module
run_terraform_docs() {
    local module_dir="$1"
    local config_path="$2"
    local verbose="$3"
    
    if [ "$verbose" = "true" ]; then
        # In verbose mode, show output and capture errors
        local output
        local exit_code
        output=$(cd "$module_dir" && terraform-docs . -c "$config_path" 2>&1)
        exit_code=$?
        
        if [ $exit_code -ne 0 ] || [ -n "$output" ]; then
            echo
            echo -e "  ${YELLOW}Output from $(basename "$module_dir"):${NC}"
            echo "$output" | sed 's/^/    /'
        fi
        
        return $exit_code
    else
        # Silent mode - suppress all output
        (cd "$module_dir" && terraform-docs . -c "$config_path" > /dev/null 2>&1)
    fi
}

# Function to process a single module
process_module() {
    local module_dir="$1"
    local search_path="$2"
    local config_path="$3"
    local verbose="$4"
    
    local display_path=$(get_display_path "$module_dir" "$search_path")
    
    printf " Module: ${BLUE}%s${NC}" "$display_path"
    
    if run_terraform_docs "$module_dir" "$config_path" "$verbose"; then
        printf " ${GREEN}✔${NC}\n"
    else
        printf " ${RED}✗${NC}\n"
    fi
}

# Function to process all modules
process_all_modules() {
    local search_path="$1"
    local config_path="$2"
    local verbose="$3"
    
    find_terraform_modules "$search_path" | while read -r module_dir; do
        process_module "$module_dir" "$search_path" "$config_path" "$verbose"
    done
}

# Main function
main() {
    # Parse arguments - this sets global variables SEARCH_PATH and VERBOSE
    parse_arguments "$@"
    
    # Store the directory where the script itself is located
    local script_dir="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
    local config_path="$(realpath "$script_dir/../.terraform-docs.yml")"
    
    # Validate config file exists
    validate_config "$config_path"
    
    # Display header information
    echo -e "Using config file: ${YELLOW}$config_path${NC}"
    echo -e "Searching for Terraform modules in: ${YELLOW}$SEARCH_PATH${NC}"
    if [ "$VERBOSE" = "true" ]; then
        echo -e "${YELLOW}Verbose mode enabled${NC}"
    fi
    echo
    
    # Process all modules
    process_all_modules "$SEARCH_PATH" "$config_path" "$VERBOSE"
    
    echo
    echo "Documentation generation complete."
}

# Run main function with all arguments
main "$@"