#!/bin/bash

# Determine the directory where the script is located
SOURCE_DIR="$(dirname "$(realpath "$0")")"
DEST_DIR="$HOME/Downloads/epub_to_md_dir"

# Ensure the destination directory exists
mkdir -p "$DEST_DIR"

# Find all EPUB files in the source directory and its subdirectories
find "$SOURCE_DIR" -type f -name '*.epub' | while read -r file; do
    # Get the base name of the file (without the extension)
    base_name=$(basename "$file" .epub)
    # Get the relative directory path
    rel_dir=$(dirname "${file#$SOURCE_DIR/}")
    # Create the corresponding directory in the destination
    mkdir -p "$DEST_DIR/$rel_dir"
    # Convert the EPUB file to Markdown and save it in the corresponding directory in the destination
    pandoc "$file" -t markdown -o "$DEST_DIR/$rel_dir/$base_name.md"
    echo "Converted $file to $DEST_DIR/$rel_dir/$base_name.md"
done

echo "Conversion complete."

