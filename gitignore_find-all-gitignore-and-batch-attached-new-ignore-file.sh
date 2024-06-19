#!/bin/bash


SEARCH_DIR="."


echo "Choose an option:"
echo "1. Manual set: NAME_TO_IGNORE"
echo "2. Use predefined NAME_TO_IGNORE in script"
echo "3. Exit"
read -p "Enter your choice [1-3]: " choice

case $choice in
    1)
        echo "Please set NAME_TO_IGNORE to insert into .gitignore file (batch action)"
        read NAME_TO_IGNORE
        ;;
    2)  
        NAME_TO_IGNORE="ggshield_secret-leak-schedule-scan/"
        ;;  
    3)
        echo "Exiting."
        exit 0
        ;;
    *)
        echo "Invalid choice. Please enter 1, 2, or 3."
        exit 1
        ;;
esac


# Find all .gitignore files in the repo
gitignore_files=$(find "$SEARCH_DIR" -type f -name ".gitignore")

# Loop over each .gitignore file found
for file in $gitignore_files; do
  # Chk if NAME_TO_IGNORE is already exist in the .gitignore file
  if ! grep -q "^$NAME_TO_IGNORE" "$file"; then
    # Chk .gitignore last_char, if it \n or not?
    last_char=$(tail -c 1 "$file")
    # If .gitignore last_char isn't \n, then insert \n
    if [ "$last_char" != "" ]; then
      echo -e "\n$NAME_TO_IGNORE" >> "$file"
    else
      # If last char is \n then attached NAME_TO_IGNORE
      echo "$NAME_TO_IGNORE" >> "$file"
    fi
    echo "Added $NAME_TO_IGNORE to $file"
  else
    echo "$NAME_TO_IGNORE already exists in $file"
  fi  
done


echo "Edit multiple .gitignore files completed."

