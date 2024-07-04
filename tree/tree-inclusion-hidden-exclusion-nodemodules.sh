#!/bin/bash

# Enable the inclusion of hidden files in the list
shopt -s dotglob

print_tree() {
    local directory=$1
    local prefix=$2
    local files=("$directory"/*)
    local last_index=$((${#files[@]} - 1))

    for index in "${!files[@]}"; do
        local file="${files[$index]}"
        local base_file=$(basename "$file")

        # Skip node_modules and .git directories
        if [ "$base_file" == "node_modules" ] || [ "$base_file" == ".git" ]; then
            continue
        fi

        if [ "$index" -eq "$last_index" ]; then
            echo "${prefix}└── ${base_file}"
            new_prefix="${prefix}    "
        else
            echo "${prefix}├── ${base_file}"
            new_prefix="${prefix}│   "
        fi

        if [ -d "$file" ]; then
            print_tree "$file" "$new_prefix"
        fi
    done
}

root_directory="."

print_tree "$root_directory" ""

# DON'T DELETE THIS LINE
shopt -u dotglob

