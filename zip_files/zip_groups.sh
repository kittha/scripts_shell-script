#!/bin/bash

# Navigate to the directory containing the group folders
cd ./epub_to_txt_dir

# Loop through each group folder and zip it
for dir in group_*/
do
    # Remove trailing slash
    dir_name="${dir%/}"
    
    # Create a zip file with the same name as the directory
    zip -r "${dir_name}.zip" "$dir_name"
    
    echo "Zipped $dir_name into ${dir_name}.zip"
done

