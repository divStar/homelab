#!/bin/bash

# Store the path where the script was started from
CONFIG_PATH=$(pwd)"/.terraform-docs.yml"

# Check if config file exists
if [ ! -f "$CONFIG_PATH" ]; then
  echo "Error: Config file $CONFIG_PATH not found!"
  exit 1
fi

echo "Using config file: $CONFIG_PATH"
echo "Searching for modules directories..."

# Find all directories named "modules" recursively
find . -type d -name "modules" | while read -r modules_dir; do
  echo "Found modules directory: $modules_dir"
  
  # Find all module directories within each modules directory
  find "$modules_dir" -maxdepth 1 -type d | grep -v "^$modules_dir\$" | while read -r module_dir; do
    # Check if this directory contains Terraform files
    if ls "$module_dir"/*.tf >/dev/null 2>&1; then
      echo "  Generating docs for module: $module_dir"
      
      # Run terraform-docs using the config from the starting directory
      (cd "$module_dir" && terraform-docs . -c "$CONFIG_PATH")
    fi
  done
done

echo "Documentation generation complete."