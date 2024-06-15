#!/bin/bash

# create server & local repo only
# if you want to upload into GitHub remote repo, please use another script

echo "### assign script filename (for self-deleting later) ###"
SCRIPT_NAME=$(basename "$0")

echo "Enter your project name"
read PROJECT_NAME

echo "creating core structure"
mkdir -p ./$PROJECT_NAME/server
cd ./$PROJECT_NAME/server
git init;
npm init -y &&
npm install express nodemon

echo "add node_modules into .gitignore file"
echo "node_modules" >> .gitignore

echo "creating git commit object"
git add .
git commit -m "init commit"

# rm -- "$0"

echo "setup complete"
