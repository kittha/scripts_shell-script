#!/bin/bash

# Directory containing the files
source_dir="./epub_to_txt_dir"
# Prefix for the new folders
folder_prefix="group_"

# Change to the source directory
cd "$source_dir" || exit

# Counter for folder names
folder_counter=1
# Counter for files in the current folder
file_counter=0

# Create the first group folder
current_folder="${folder_prefix}${folder_counter}"
mkdir "$current_folder"

# Loop through all files in the source directory
for file in *; do
    # Check if it is a file
    if [[ -f "$file" ]]; then
        # Move the file to the current group folder
        mv "$file" "$current_folder"
        ((file_counter++))
        
        # If 25 files have been moved, reset the file counter and increment the folder counter
        if ((file_counter == 5)); then
            ((folder_counter++))
            current_folder="${folder_prefix}${folder_counter}"
            mkdir "$current_folder"
            file_counter=0
        fi
    fi
done

