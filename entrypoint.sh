#!/bin/bash

echo "Finding all tfvars in the project"
# Find all tfvars in all folders
find . -type f -name "*.tfvars"

# Output file
output_file="atlantis.yaml"

# Clear the output file if it exists
> "$output_file"

echo "# This file is maintained automatically by a gha." >> "$output_file"
echo "# Manual edits may be lost in future updates." >> "$output_file"
echo "version: 3" >> "$output_file"
echo "projects:" >> "$output_file"

# Find all .tfvars files and append their path and filename to the output file
find . -type f -name "*.tfvars" | while read -r file; do
  # Get the directory path
  dir_path=$(dirname "$file")
  # Get the directory path without the ./ part
  path_without_dots="${dir_path//.\//}"
  # Get the filename
  filename=$(basename "$file")
  # Get the name
  name=${filename%.*}
  # Get the name of the project by replacing / for -
  project="${path_without_dots//\//-}"
 
  echo "  - name: $project-$name" >> "$output_file"
  echo "    autoplan:" >> "$output_file"
  echo "      enabled: true" >> "$output_file"
  echo "      when_modified: [\"*.tf\",\"$filename\"]" >> "$output_file"
  echo "    dir: $path_without_dots" >> "$output_file"
  echo "    workflow: workspaces" >> "$output_file"
  echo "    workspace: $name" >> "$output_file"
  echo -e "" >> "$output_file"

done

# Check the outputile
cat $output_file
