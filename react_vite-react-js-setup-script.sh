#!/bin/bash
# first: chmod u+x createViteReactJsScript.sh (set only once)

# second: copy script to destination then run-script

# third ./viteReactJsSetupScript.sh
# input project name
# and this script will create vite react app template for you

echo 'Enter your project name' 
read PROJECTNAME 
npm create vite@latest ${PROJECTNAME} -- --template react

cd ${PROJECTNAME} 

echo "add ignore files list into .gitignore file"
cat <<EOL > .gitignore
# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*
lerna-debug.log*

node_modules
.env
dist
dist-ssr
*.local

# Editor directories and files
.vscode/*
!.vscode/extensions.json
.idea
.DS_Store
*.suo
*.ntvs*
*.njsproj
*.sln
*.sw?
EOL
touch .env

npm install 
#npm run dev
