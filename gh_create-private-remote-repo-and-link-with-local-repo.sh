#!/bin/bash

# Get script name
SCRIPT_NAME=$(basename "$0")

# Ensure GitHub CLI is installed
if ! command -v gh &> /dev/null
then
    echo "GitHub CLI (gh) could not be found. Please install it and authenticate."
    exit 1
fi

# Get the current directory name
REPO_NAME=${PWD##*/}

# Check if the current directory is a git repository
if [ ! -d .git ]; then
    echo "This directory is not a git repository. Initializing a new git repository."
    git init
else
    echo "This is already a git repository."
fi

echo "$SCRIPT_NAME" >> .gitignore

# Create a new repository on GitHub
echo "Creating repository '$REPO_NAME' on GitHub..."
gh repo create "$REPO_NAME" --private 

# Add the GitHub repository as a remote to the local repository
echo "Adding GitHub remote repository..."
git remote add origin "git@github.com:kittha/$REPO_NAME.git"

# Verify the remote has been added
echo "Verifying remote repository..."
git remote -v

# Automatically push the initial commit to GitHub
echo "Pushing initial commit to GitHub..."
git add .
git commit -m "Initial commit"
git push -u origin main

echo "Self-deleting script file..."
rm -- "$0"

echo "Repository setup complete"
