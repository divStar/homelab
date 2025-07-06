#!/bin/bash

# Function to display usage information
show_usage() {
    echo "Usage: $0 [PATH]"
    echo "  PATH: Directory path to search for modules (default: ../)"
    echo "Example: $0 /path/to/terraform/modules"
    echo "         $0 ../../infrastructure"
    exit 1
}

# Parse command line arguments
SEARCH_PATH="../"
if [ $# -eq 1 ]; then
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        show_usage
    fi
    SEARCH_PATH="$1"
elif [ $# -gt 1 ]; then
    echo "Error: Too many arguments provided."
    show_usage
fi

# Convert to absolute path and validate
SEARCH_PATH=$(realpath "$SEARCH_PATH" 2>/dev/null)
if [ $? -ne 0 ] || [ ! -d "$SEARCH_PATH" ]; then
    echo "Error: Invalid path '$1'. Directory does not exist."
    exit 1
fi

# Store the directory where the script itself is located
SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
CONFIG_PATH="$SCRIPT_DIR/../.terraform-docs.yml"
STORY_SCRIPT_PATH="$SCRIPT_DIR/story-plan.sh"

# Check if config file exists
if [ ! -f "$CONFIG_PATH" ]; then
    echo "Error: Config file $CONFIG_PATH not found!"
    exit 1
fi

# Check if story script exists
if [ ! -f "$STORY_SCRIPT_PATH" ]; then
    echo "Error: Story script $STORY_SCRIPT_PATH not found!"
    exit 1
fi

echo "Using config file: $CONFIG_PATH"
echo "Using story script: $STORY_SCRIPT_PATH"
echo "Searching for modules directories in: $SEARCH_PATH"

# Find all directories named "modules" recursively in the specified path
find "$SEARCH_PATH" -type d -name "modules" | while read -r modules_dir; do
    echo "Found modules directory: $modules_dir"
    
    # Find all module directories within each modules directory
    find "$modules_dir" -maxdepth 1 -type d | grep -v "^$modules_dir\$" | while read -r module_dir; do
        # Check if this directory contains Terraform files
        if ls "$module_dir"/*.tf >/dev/null 2>&1; then
            echo "  Generating docs for module: $module_dir"
            
            # Run terraform-docs using the config from the starting directory
            (cd "$module_dir" && terraform-docs . -c "$CONFIG_PATH")
            
            # Generate execution story and append to README.md
            echo "  Adding execution story for module: $module_dir"
            README_PATH="$module_dir/README.md"
            
            if [ -f "$README_PATH" ]; then
                # Generate the execution story
                STORY_OUTPUT=$("$STORY_SCRIPT_PATH" -x -r -p "$module_dir" 2>/dev/null)
                
                # Check if we got any output from the story script
                if [ -n "$STORY_OUTPUT" ]; then
                    # Check if placeholder exists in README.md
                    if grep -q "EXECUTION_STORY_PLACE_HOLDER" "$README_PATH"; then
                        # Create temporary file with the execution story content
                        TEMP_STORY=$(mktemp)
                        {
                            echo "$STORY_OUTPUT"
                        } > "$TEMP_STORY"
                        
                        # Replace the placeholder with the story content
                        sed -i "/EXECUTION_STORY_PLACE_HOLDER/r $TEMP_STORY" "$README_PATH"
                        sed -i "/EXECUTION_STORY_PLACE_HOLDER/d" "$README_PATH"
                        
                        # Clean up temp file
                        rm "$TEMP_STORY"
                        
                        echo "    ✓ Execution story replaced placeholder in $README_PATH"
                    else
                        echo "    ⚠ EXECUTION_STORY_PLACE_HOLDER not found in $README_PATH"
                    fi
                else
                    echo "    ⚠ No execution story generated for $module_dir"
                fi
            else
                echo "    ⚠ README.md not found in $module_dir"
            fi
        fi
    done
done

echo "Documentation generation complete."