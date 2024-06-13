##### DESTRUCTIVE SCRIPT: USE WITH CAUTION #####
##### SCRIPT WILL DELETE IT SELF AFTER EXECUTE #####
#!/bin/bash



#ENTER cleaning_target REMOTE REPO LINK
cleaning_target_link="git@github.com:kittha/sandbox.git"

#ENTER cleaning target LOCAL DIR NAME
#eg.github remote repo link is "git@github.com:kittha/sandbox.git"
#then cleaning target local dir name is <sandbox> NO DOT GIT
cleaning_target_dir_name="sandbox"



echo "***** CLEANING REMOTE REPO SCRIPT V1 *****" &&
echo "***** CREATE BY: KITTHA AT 2024-05-15T1545 *****" &&

echo "***** THIS SCRIPT WILL CLEARING REMOTE REPO *****" &&



echo "##### check if it need to deleting existing dir or not #####" && 
rmdir ./$cleaning_target_dir_name ;
rm -rf ./$cleaning_target_dir_name ; 
echo "----- check if it need to delete old dir = pass -----" &&


echo "##### create temp dir #####" && 
mkdir ./$cleaning_target_dir_name &&



echo "##### in dir: git init and create file #####" &&
cd ./$cleaning_target_dir_name &&
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
git remote add origin $cleaning_target_link &&
git push origin --mirror &&
cd .. &&
echo "----- clearing remote repo successful -----" &&



echo "##### check if it need to deleting existing dir or not #####" && 
rmdir ./$cleaning_target_dir_name ;
rm -rf ./$cleaning_target_dir_name ; 
echo "----- check if it need to delete old dir = pass -----" &&



echo "----- self-delete on progress -----" &&

SCRIPT_NAME="$(basename "$0")"
TEMP_SCRIPT="/tmp/temp_script_$$.sh"
cp "$0" "$TEMP_SCRIPT"
chmod +x "$TEMP_SCRIPT"
rm -- "$0"
exec "$TEMP_SCRIPT"
rm -- "$TEMP_SCRIPT"

echo "***** exit script *****" 
