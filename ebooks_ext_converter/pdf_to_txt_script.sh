#!/bin/bash

# Determine the directory where the script is located
SOURCE_DIR="$(dirname "$(realpath "$0")")"
DEST_DIR="$HOME/Downloads/pdf_to_txt_dir"

# Ensure the destination directory exists
mkdir -p "$DEST_DIR"
if [ $? -ne 0 ]; then
    echo "Failed to create destination directory: $DEST_DIR"
    exit 1
fi

# Find all PDF files in the source directory and its subdirectories
find "$SOURCE_DIR" -type f -name '*.pdf' | while read -r file; do
    # Get the base name of the file (without the extension)
    base_name=$(basename "$file" .pdf)
    # Get the relative directory path
    rel_dir=$(dirname "${file#$SOURCE_DIR/}")
    # Create the corresponding directory in the destination
    mkdir -p "$DEST_DIR/$rel_dir"
    if [ $? -ne 0 ]; then
        echo "Failed to create directory: $DEST_DIR/$rel_dir"
        continue
    fi
    
    # Convert the PDF file to plain text using pdftotext
    pdftotext "$file" "$DEST_DIR/$rel_dir/$base_name.txt"
    if [ $? -eq 0 ]; then
        echo "Converted $file to $DEST_DIR/$rel_dir/$base_name.txt"
    else
        echo "Failed to convert $file"
    fi
done

echo "Conversion complete."

