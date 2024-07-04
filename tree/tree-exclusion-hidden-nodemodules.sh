#!/bin/bash

# Function to print the directory tree
print_tree() {
    local directory=$1  # First argument is the directory to list
    local prefix=$2     # Second argument is the prefix for formatting

    # Array of all files and directories in the specified directory
    local files=("$directory"/*)
    # Last index of the files array
    local last_index=$((${#files[@]} - 1))

    # Loop through each file/directory in the array
    for index in "${!files[@]}"; do
        local file="${files[$index]}"
        local base_file=$(basename "$file")

        # Skip node_modules directory
        if [ "$base_file" == "node_modules" ]; then
            continue
        fi

        # Determine the appropriate tree branch character
        if [ "$index" -eq "$last_index" ]; then
            echo "${prefix}└── ${base_file}"
            new_prefix="${prefix}    "
        else
            echo "${prefix}├── ${base_file}"
            new_prefix="${prefix}│   "
        fi

        # If the current file is a directory, call the function recursively
        if [ -d "$file" ]; then
            print_tree "$file" "$new_prefix"
        fi
    done
}

# Starting directory for the tree
root_directory="."

# Print the directory tree starting from the root directory
print_tree "$root_directory" ""

