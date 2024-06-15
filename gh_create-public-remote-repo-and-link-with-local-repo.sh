#!/bin/bash

# Edit here
# Input your GitHub username (don't add whitespace around=symbol)
MY_GH_USERNAME="kittha"





echo "### assign script filename (for self-deleting later) ###"
SCRIPT_NAME=$(basename "$0")




echo "### check if GitHub CLI is installed? ###"
if ! command -v gh &> /dev/null
then
    echo "GitHub CLI (gh) isn't installed. Exit."
    exit 1
fi




echo "### assign current dir name ###"
REPO_NAME=${PWD##*/}





echo "### is this dir is a git local repo??? ###"
if [ ! -d .git ]; then
    echo "this dir isn't git local repo. start git init."
    git init
else
    echo "this is already a git local repo"
fi


echo "### write script name into .gitignore file ###"
echo "$SCRIPT_NAME" >> .gitignore



echo "### creating remote repo name: '$REPO_NAME' on GitHub by using GitHub CLI ###"
gh repo create "$REPO_NAME" --public 





echo "### linking GitHub remote repo with git local repo ###"
git remote add origin "git@github.com:$MY_GH_USERNAME/$REPO_NAME.git"

echo "### crosscheck remote repo url (origin of clone) ###"
git remote -v





echo "### push initial commit to GitHub ###"
git add .
git commit -m "init commit"
git push -u origin main




# echo "### script file is self-deleting ###"
# rm -- "$0"

echo "### setup complete ###"
