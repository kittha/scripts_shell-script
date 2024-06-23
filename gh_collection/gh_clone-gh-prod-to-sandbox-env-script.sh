#!/bin/bash



#ENTER template REMOTE REPO LINK
template_link="https://github.com/kittha/kittha"

#ENTER template DIR NAME
#template dir name
#eg.github remote repo template link is "git@github.com:kittha/git-playground-template.git"
#then template dir name is <git-playground-template> NO DOT GIT
template_dir_name="kittha"



#ENTER sandbox REMOTE REPO LINK; if dont have, then create new blank github REMOTE REPO (sandbox) LINK
sandbox_link="git@github.com:kittha/sandbox.git"

#ENTER sandbox DIR NAME
#eg.github remote repo sandbox link is "git@github.com:kittha/sandbox.git"
#then sandbox dir name is <sandbox> NO DOT GIT
sandbox_dir_name="sandbox"



echo "***** CLONE GITHUB PROD REMOTE REPO TO SANDBOX REPO SCRIPT V2 *****" &&
echo "***** CREATE BY: KITTHA AT 2024-05-15T1445 *****" &&

echo "***** THIS SCRIPT WILL CLEARING REMOTE REPO *****" &&
echo "***** AND FETCH FRESH NEW REMOTE REPO INTO LOCAL DIR *****" &&



echo "##### check if it need to deleting existing template dir or not #####" && 
rm -r -f ./$template_dir_name.git ; 
echo "----- check if it need to delete old template dir = pass -----" &&

echo "##### check if it need to deleting existing sandbox dir or not #####" && 
rm -r -f ./$sandbox_dir_name ;
rm -r -f ./$sandbox_dir_name.git ; 
echo "----- check if it need to delete old sandbox dir = pass -----" &&








echo "##### create temp dir #####" && 
mkdir ./$sandbox_dir_name &&



echo "##### in dir: git init and create file #####" &&
cd ./$sandbox_dir_name &&
echo "This is the README" > README.md &&
git init &&
git checkout -b main &&
git add . &&
git commit -m "Add README.md (initial commit)" &&



echo "##### clearing files and folders in local repo #####" &&
git rm -r -f '*' ; 
git commit -m "Delete all files & folders" ; 
echo "----- clearing local repo successful -----" &&


echo "##### clearing files and folders in remote repo #####" &&
git remote add origin $sandbox_link &&
git push origin --mirror &&
cd .. &&
echo "----- clearing remote repo successful -----" &&



echo "##### check if it need to deleting existing sandbox dir or not #####" && 
rmdir ./$sandbox_dir_name ;
rm -rf ./$sandbox_dir_name ; 
echo "----- check if it need to delete old sandbox dir = pass -----" &&












echo "##### download remote template dir (bare) from remote repo #####" &&
git clone --bare $template_link &&
echo "----- download remote template dir (bare) successful -----" &&

cd $template_dir_name.git &&
echo "----- set remote url origin; clearing remote upstream url -----;" &&
git remote set-url origin $sandbox_link &&
git remote rm upstream ;
echo "----- set up remote url origin; remote upstream successful -----" &&



echo "##### init mirroring #####" &&
echo "----- mirror to: sandbox dir remote repo -----" && 
git push --mirror $sandbox_link && 
echo "----- mirroring template dir local to sandbox dir remote successful -----" && 

echo "##### clearing unused local template dir #####" && 
cd .. &&  
rm -rf ./$template_dir_name.git &&  
echo "----- clearing unused local template dir successful -----" && 




echo "##### download fresh remote sandbox dir from remote repo #####" && 
git clone $sandbox_link &&  
echo "***** clone-gh-prod-to-sandbox-env-script.sh script run successful! *****" &&
#read


echo "##### run vs code #####" && 
cd ./$sandbox_dir_name &&   
code . ;
echo "***** exit script *****" 
