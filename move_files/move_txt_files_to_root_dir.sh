#!/bin/bash

# Find all .txt files in the current directory and its subdirectories
find . -type f -name "*.txt" -exec mv {} . \;

echo "All .txt files have been moved to the root directory."

