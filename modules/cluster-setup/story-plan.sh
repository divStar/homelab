#!/usr/bin/env bash

# Script to show Terraform module execution order in "story mode"
# Usage: ./story-plan-ex.sh [-d|--debug] [-x|--extended] [-p|--path PATH] [-b|--binary BINARY] [-h|--help]

set -euo pipefail

# =============================================================================
# CONFIGURATION
# =============================================================================

# Default values
DEBUG="false"
TERRAFORM_BINARY="tofu"
TERRAFORM_PATH="."
EXTENDED="false"

# RegEx patterns as constants (simplified)
readonly ID='[[:alnum:]_]+'  # Terraform identifiers: letters, digits, underscore
readonly DEPENDENCY_PATTERN='" -> "'
readonly MODULE_PATTERN="^module\.${ID}$"
readonly MODULE_RESOURCE_PATTERN="^module\.(${ID})\.${ID}\.${ID}$"
readonly STANDALONE_RESOURCE_PATTERN="^${ID}\.${ID}$"
readonly MODULE_TO_MODULE_PATTERN="^module\.${ID} module\.${ID}$"
readonly MODULE_RESOURCE_EXTRACT_PATTERN="^module\.(${ID})\."
readonly EXCLUDE_TYPES='(output|var|data)'
readonly SKIP_PATTERNS="(var\.|local\.|data\.|output\.|provider|root$|\]|reference|^\])"
readonly RESOURCE_EXCLUDE_PATTERN="\.${EXCLUDE_TYPES}\."
readonly RESOURCE_PREFIX_PATTERN="^(provider|var\.|local\.|data\.|output\.)"
readonly LABEL_PATTERN='label.*='
readonly SKIP_PREFIX_PATTERN='^\]'
readonly OUTPUT_PATTERN="\.output\.|^output\.|^local_file\.|\.local_file\."
readonly DEPENDENCY_EXTRACT_PATTERN='.*"([^"]*)" -> "([^"]*)".*/\1 \2/'
readonly ROOT_CLEANUP_PATTERN='\[root\] //g'
readonly EXPAND_CLOSE_PATTERN=' \(expand\)| \(close\)//g'
readonly PROVIDER_CLEANUP_PATTERN='provider\[.*\]//g'
readonly EMPTY_LINE_PATTERN='^\s*$'
readonly REFERENCE_PATTERN='reference)'

# Global variables
declare -A adj_list
declare -A in_degree
declare -A all_modules
declare -A output_modules

# =============================================================================
# UTILITY FUNCTIONS
# =============================================================================

debug() {
    if [[ "$DEBUG" == "true" ]]; then
        echo "$@" >&2
    fi
}

show_help() {
    cat << EOF
Usage: $0 [-d|--debug] [-x|--extended] [-p|--path PATH] [-b|--binary BINARY] [-h|--help]
  -d, --debug     Show debug information
  -x, --extended  Include individual resources (not just modules)
  -p, --path      Terraform project path (default: current directory)
  -b, --binary    Terraform binary to use (default: tofu)
  -h, --help      Show this help message

Examples:
  $0                                    # Modules only, current directory
  $0 -x                                 # Include all resources
  $0 -p /path/to/terraform -x           # Extended mode with specific path
  $0 -b terraform -d -x                 # All options with terraform binary
EOF
}

# =============================================================================
# PARSING FUNCTIONS
# =============================================================================

parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -d|--debug)
                DEBUG="true"
                shift
                ;;
            -x|--extended)
                EXTENDED="true"
                shift
                ;;
            -p|--path)
                TERRAFORM_PATH="$2"
                shift 2
                ;;
            -b|--binary)
                TERRAFORM_BINARY="$2"
                shift 2
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            *)
                echo "Unknown option: $1"
                echo "Use -h or --help for usage information"
                exit 1
                ;;
        esac
    done
}

get_graph_data() {
    # Convert to absolute path if needed
    local abs_path
    if [[ "$TERRAFORM_PATH" == "." ]]; then
        abs_path="$(pwd)"
    elif [[ "${TERRAFORM_PATH:0:1}" == "/" ]]; then
        abs_path="$TERRAFORM_PATH"
    else
        abs_path="$(pwd)/$TERRAFORM_PATH"
    fi
    
    debug "🔧 Running: $TERRAFORM_BINARY graph -chdir='$abs_path'"
    "$TERRAFORM_BINARY" -chdir="$abs_path" graph 2>/dev/null
}

extract_dependencies() {
    local graph_data="$1"
    
    debug "🔍 Debug: Raw grep output:"
    if [[ "$DEBUG" == "true" ]]; then
        echo "$graph_data" | grep -E "$DEPENDENCY_PATTERN" | head -10 >&2
        echo >&2
    fi


    # Clean and filter dependencies
    echo "$graph_data" | \
        grep -E "$DEPENDENCY_PATTERN" | \
        sed -E "s/$DEPENDENCY_EXTRACT_PATTERN" | \
        sed -E "s/$ROOT_CLEANUP_PATTERN" | \
        sed -E "s/$EXPAND_CLOSE_PATTERN" | \
        sed -E "s/$PROVIDER_CLEANUP_PATTERN" | \
        grep -v "$EMPTY_LINE_PATTERN" | \
        grep -v "$REFERENCE_PATTERN"
}

is_valid_resource() {
    local item="$1"
    
    # Check if it's a module
    [[ "$item" =~ $MODULE_PATTERN ]] && return 0
    
    # Check if it's a module resource (but not output/var/data)
    if [[ "$item" =~ $MODULE_RESOURCE_PATTERN ]]; then
        [[ ! "$item" =~ $RESOURCE_EXCLUDE_PATTERN ]] && return 0
    fi
    
    # Check if it's a standalone resource
    [[ "$item" =~ $STANDALONE_RESOURCE_PATTERN ]] && return 0
    
    return 1
}

should_skip_item() {
    local item="$1"
    
    # Skip if matches skip patterns
    [[ "$item" =~ $SKIP_PATTERNS ]] && return 0
    
    # Skip if starts with ] or is root
    [[ "$item" =~ $SKIP_PREFIX_PATTERN ]] && return 0
    [[ "$item" == "root" ]] && return 0
    
    return 1
}

filter_extended_dependencies() {
    local all_deps="$1"
    
    while read -r from to; do
        [[ -z "$from" || -z "$to" ]] && continue
        
        # Skip obvious garbage
        should_skip_item "$from" && continue
        should_skip_item "$to" && continue
        
        # Keep if at least one side is a valid resource/module
        if is_valid_resource "$from" || is_valid_resource "$to"; then
            echo "$from $to"
        fi
    done <<< "$all_deps"
}

filter_dependencies() {
    local all_deps="$1"
    
    if [[ "$EXTENDED" == "true" ]]; then
        debug "🔍 Debug: Filtering for modules and resources (extended mode):"
        filter_extended_dependencies "$all_deps"
    else
        debug "🔍 Debug: Filtering for modules only (normal mode):"
        echo "$all_deps" | \
            grep -E "$MODULE_TO_MODULE_PATTERN" | \
            sed -E 's/module\.([a-zA-Z_][a-zA-Z0-9_]*) module\.([a-zA-Z_][a-zA-Z0-9_]*)/\1 \2/'
    fi
}

extract_all_resources() {
    local graph_data="$1"
    
    if [[ "$EXTENDED" == "true" ]]; then
        while IFS= read -r line; do
            if [[ "$line" =~ $LABEL_PATTERN ]]; then
                local resource
                resource=$(echo "$line" | sed -n 's/.*label = "\([^"]*\)".*/\1/p')
                
                # Keep actual resources and modules only
                if [[ "$resource" =~ $STANDALONE_RESOURCE_PATTERN ]] || 
                   [[ "$resource" =~ $MODULE_PATTERN ]] ||
                   [[ "$resource" =~ $MODULE_RESOURCE_PATTERN ]]; then
                    # Capture outputs separately but don't include in execution flow
                    if [[ "$resource" =~ $OUTPUT_PATTERN ]]; then
                        debug "📄 Adding output resource: $resource"
                        output_modules[$resource]=1
                    # Skip other vars, data sources, providers  
                    elif [[ ! "$resource" =~ $RESOURCE_EXCLUDE_PATTERN ]] && [[ ! "$resource" =~ $RESOURCE_PREFIX_PATTERN ]]; then
                        debug "📋 Adding resource: $resource"
                        all_modules[$resource]=1
                        in_degree[$resource]=0
                    fi
                fi
            fi
        done <<< "$(echo "$graph_data" | grep -E 'label.*=')"
    fi
}

# =============================================================================
# TOPOLOGICAL SORT
# =============================================================================

build_dependency_graph() {
    local deps="$1"
    
    debug "🔍 Debug: Parsed as 'FROM depends_on TO' relationships:"
    
    # Parse dependencies - NOTE: FROM -> TO means FROM depends on TO
    # So TO must be created before FROM
    while IFS=' ' read -r from to; do
        [[ -z "$from" || -z "$to" ]] && continue
        
        debug "  $from depends on $to (so $to runs before $from)"
        
        # Reverse the relationship: TO comes before FROM
        # Add FROM to TO's dependents list
        if [[ -z "${adj_list[$to]:-}" ]]; then
            adj_list[$to]="$from"
        else
            adj_list[$to]="${adj_list[$to]} $from"
        fi
        
        # Track in-degrees: FROM has one more dependency
        in_degree[$from]=$((${in_degree[$from]:-0} + 1))
        in_degree[$to]=$((${in_degree[$to]:-0} + 0))  # Ensure it exists
        
        # Track all modules
        all_modules[$from]=1
        all_modules[$to]=1
    done <<< "$deps"
}

topological_sort() {
    debug "🔍 Debug: Final in-degrees:"
    if [[ "$DEBUG" == "true" ]]; then
        for module in "${!all_modules[@]}"; do
            echo "  $module: ${in_degree[$module]} dependencies" >&2
        done
        echo >&2
    fi

    # Find modules with no incoming dependencies (roots)
    local queue=()
    for module in "${!all_modules[@]}"; do
        if [[ ${in_degree[$module]} -eq 0 ]]; then
            queue+=("$module")
        fi
    done

    # Kahn's algorithm
    local execution_order=()
    while [[ ${#queue[@]} -gt 0 ]]; do
        # Pop from queue (FIFO)
        local current="${queue[0]}"
        queue=("${queue[@]:1}")
        
        execution_order+=("$current")
        
        # Process dependents
        if [[ -n "${adj_list[$current]:-}" ]]; then
            for dependent in ${adj_list[$current]}; do
                in_degree[$dependent]=$((${in_degree[$dependent]:-0} - 1))
                if [[ ${in_degree[$dependent]} -eq 0 ]]; then
                    queue+=("$dependent")
                fi
            done
        fi
    done

    printf '%s\n' "${execution_order[@]}"
}

# =============================================================================
# OUTPUT FUNCTIONS
# =============================================================================

print_execution_order() {
    local execution_order=("$@")
    
    if [[ "$EXTENDED" == "true" ]]; then
        
        # Group resources by their parent modules for tree view
        local -A module_resources
        local -A module_outputs
        local standalone_modules=()
        local standalone_resources=()
        local output_resources=()
        
        # Separate modules from resources and group them, identify outputs
        for item in "${execution_order[@]}"; do
            if [[ "$item" =~ $OUTPUT_PATTERN ]]; then
                # This is an output resource (including local_file) - move to bottom
                output_resources+=("$item")
            elif [[ "$item" =~ $MODULE_PATTERN ]]; then
                # This is a top-level module
                standalone_modules+=("$item")
            elif [[ "$item" =~ $MODULE_RESOURCE_EXTRACT_PATTERN ]]; then
                # This is a resource within a module
                local parent_module="module.${BASH_REMATCH[1]}"
                if [[ -z "${module_resources[$parent_module]:-}" ]]; then
                    module_resources[$parent_module]="$item"
                else
                    module_resources[$parent_module]="${module_resources[$parent_module]} $item"
                fi
            else
                # This is a standalone resource (not in a module)
                standalone_resources+=("$item")
            fi
        done
        
        # Print in hierarchical order
        local step=1
        
        # Print standalone resources first (if any)
        for resource in "${standalone_resources[@]}"; do
            printf "%2d. 🔧 %s\n" $step "$resource"
            ((step++))
        done
        
        # Print modules with their resources
        for module in "${standalone_modules[@]}"; do
            printf "%2d. 📦 \033[1m%s\033[0m\n" "$step" "$module"
            ((step++))
            
            # Print resources belonging to this module (indented)
            if [[ -n "${module_resources[$module]:-}" ]]; then
                for resource in ${module_resources[$module]}; do
                    printf "%2d.   🔧 %s\n" $step "$resource"
                    ((step++))
                done
            fi
        done
        
        
        # Print output resources at the bottom (if any exist)
        local has_any_outputs=false
        [[ ${#output_resources[@]} -gt 0 ]] && has_any_outputs=true
        [[ ${#output_modules[@]} -gt 0 ]] 2>/dev/null && has_any_outputs=true
        
        if [[ "$has_any_outputs" == "true" ]]; then
            echo
            echo "📄 Output Resources (informational):"
            local step_count=$((${#execution_order[@]} - ${#output_resources[@]} + 1))
            
            # Collect all outputs into one array and sort
            local all_outputs=()
            
            # Add output_resources (local_file, etc. from execution order)
            for output in "${output_resources[@]}"; do
                all_outputs+=("$output")
            done
            
            # Add output_modules (discovered outputs)
            if [[ ${#output_modules[@]} -gt 0 ]] 2>/dev/null; then
                for output in "${!output_modules[@]}"; do
                    all_outputs+=("$output")
                done
            fi
            
            # Sort and display unique outputs
            if [[ ${#all_outputs[@]} -gt 0 ]]; then
                readarray -t sorted_outputs < <(printf '%s\n' "${all_outputs[@]}" | sort -u)
                for output in "${sorted_outputs[@]}"; do
                    printf "%2d. 📄 %s\n" $step_count "$output"
                    ((step_count++))
                done
            fi
        fi
        
        echo
        printf "Total items: %d (modules + resources)\n" ${#execution_order[@]}
    else
        local step=1
        for item in "${execution_order[@]}"; do
            printf "%2d. 📦 %s\n" "$step" "$item"
            ((step++))
        done

        # Print output resources for normal mode too
        if [[ ${#output_modules[@]} -gt 0 ]] 2>/dev/null; then
            echo
            echo "📄 Output Resources (informational):"
            local step_count=$((${#execution_order[@]} + 1))
            
            # Collect and sort all outputs
            local all_outputs=()
            for output in "${!output_modules[@]}"; do
                all_outputs+=("$output")
            done
            
            # Sort and display unique outputs
            if [[ ${#all_outputs[@]} -gt 0 ]]; then
                readarray -t sorted_outputs < <(printf '%s\n' "${all_outputs[@]}" | sort -u)
                for output in "${sorted_outputs[@]}"; do
                    printf "%2d. 📄 %s\n" $step_count "$output"
                    ((step_count++))
                done
            fi
        fi

        echo
        printf "Total modules: %d\n" ${#execution_order[@]}
    fi
}

check_for_cycles() {
    local execution_order=("$@")
    
    # Check for cycles
    if [[ ${#execution_order[@]} -ne ${#all_modules[@]} ]]; then
        echo
        echo "⚠️  WARNING: Possible dependency cycle detected!"
        echo "   Some modules may not appear in the execution order."
        echo "   Missing modules:"
        for module in "${!all_modules[@]}"; do
            local found="false"
            for exec_module in "${execution_order[@]}"; do
                if [[ "$module" == "$exec_module" ]]; then
                    found="true"
                    break
                fi
            done
            if [[ "$found" == "false" ]]; then
                echo "     - $module (in-degree: ${in_degree[$module]})"
            fi
        done
    fi
}

# =============================================================================
# MAIN EXECUTION
# =============================================================================

main() {
    # Parse command line arguments
    parse_arguments "$@"
    
    # Show immediate feedback with header and scanning message
    local mode_text="Normal"
    [[ "$EXTENDED" == "true" ]] && mode_text="Extended"
    
    echo "🚀 Terraform Execution Order ($mode_text mode):"
    echo "================================================================================"
    
    # Convert to absolute path for display
    local display_path
    if [[ "$TERRAFORM_PATH" == "." ]]; then
        display_path="$(pwd)"
    elif [[ "${TERRAFORM_PATH:0:1}" == "/" ]]; then
        display_path="$TERRAFORM_PATH"
    else
        display_path="$(pwd)/$TERRAFORM_PATH"
    fi
    
    echo "📁 Scanning project path: $display_path"
    
    # Show different progress based on debug mode
    if [[ "$DEBUG" == "true" ]]; then
        echo "⏳ Analyzing dependencies..."
    else
        printf "⏳ Analyzing dependencies... extracting graph data"
    fi
    
    # Get graph data from stdin or run terraform/tofu graph
    local graph_data
    graph_data=$(get_graph_data)
    
    # Extract all dependencies and capture outputs (for both modes)
    if [[ "$DEBUG" != "true" ]]; then
        printf "\r⏳ Analyzing dependencies... finding output references          "
    fi
    
    local all_deps
    # Capture outputs and local_file resources directly in main function scope
    while IFS= read -r line; do
        if [[ "$line" =~ $DEPENDENCY_PATTERN ]]; then
            local from_to
            from_to=$(echo "$line" | sed -E 's/.*"([^"]*)" -> "([^"]*)".*/\1 \2/')
            local from=$(echo "$from_to" | cut -d' ' -f1 | sed -E 's/\[root\] //g' | sed -E 's/ \(expand\)| \(close\)//g')
            local to=$(echo "$from_to" | cut -d' ' -f2 | sed -E 's/\[root\] //g' | sed -E 's/ \(expand\)| \(close\)//g')
            
            # Check both from and to for outputs/local_files
            if [[ "$to" =~ $OUTPUT_PATTERN ]]; then
                debug "📄 Found output reference: $to"
                output_modules[$to]=1
            fi
            if [[ "$from" =~ $OUTPUT_PATTERN ]]; then
                debug "📄 Found output reference: $from"
                output_modules[$from]=1
            fi
        fi
    done <<< "$graph_data"
    
    if [[ "$DEBUG" != "true" ]]; then
        printf "\r⏳ Analyzing dependencies... processing dependencies        "
    fi
    
    all_deps=$(extract_dependencies "$graph_data")
    
    # Extract all resources in extended mode
    extract_all_resources "$graph_data"
    
    # Filter dependencies based on mode
    if [[ "$DEBUG" != "true" ]]; then
        printf "\r⏳ Analyzing dependencies... building dependency graph      "
    fi
    
    local filtered_deps
    filtered_deps=$(filter_dependencies "$all_deps")
    
    debug "🔍 Debug: After filtering:"
    if [[ "$DEBUG" == "true" && -n "$filtered_deps" ]]; then
        echo "$filtered_deps" >&2
    fi
    debug
    
    # Build dependency graph
    build_dependency_graph "$filtered_deps"
    
    # Perform topological sort
    if [[ "$DEBUG" != "true" ]]; then
        printf "\r⏳ Analyzing dependencies... calculating execution order    "
    fi
    
    local execution_order
    readarray -t execution_order < <(topological_sort)
    
    # Complete the analysis
    if [[ "$DEBUG" == "true" ]]; then
        echo "✅ Analysis complete!"
    else
        printf "\r✅ Analysis complete!                                        \n"
    fi
    echo
    
    # Display results
    print_execution_order "${execution_order[@]}"
    check_for_cycles "${execution_order[@]}"
}

# Run main function with all arguments
main "$@"