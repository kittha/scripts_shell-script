#!/bin/bash

NAME_TO_IGNORE="ggshield_secret-leak-schedule-scan/"
SEARCH_DIR="."

# Find all .gitignore files in the repo
gitignore_files=$(find "$SEARCH_DIR" -type f -name ".gitignore")

# Loop over each .gitignore file found
for file in $gitignore_files; do
  # Chk if NAME_TO_IGNORE is already exist in the .gitignore file
  if ! grep -q "^$NAME_TO_IGNORE" "$file"; then
    # If not, add NAME_TO_IGNORE to the .gitignore file
    echo -e "\n$NAME_TO_IGNORE" >> "$file"
    echo "Added $NAME_TO_IGNORE to $file"
  else
    echo "$NAME_TO_IGNORE already exists in $file"
  fi  
done

echo "Edit multiple .gitignore files completed."

