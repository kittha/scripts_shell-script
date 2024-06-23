#!/bin/bash

# create server & local repo only
# if you want to upload into GitHub remote repo, please use another script

SCRIPT_NAME=$(basename "$0")


echo 'Enter your fullstack project name'
read PROJECTNAME

mkdir $PROJECTNAME
cd $PROJECTNAME
echo "add node_modules and .env into .gitignore file"
echo "node_modules" >> .gitignore
echo ".env" >> .gitignore
mkdir server
git init
cd server || exit


echo "### nodejs express create server script for lazy guy ###"

while true; do
  echo "Enter backend server port num in range 1024 to 65535 (4242)"
  read PORT_NUM

  if [[ "$PORT_NUM" =~ ^[0-9]+$ ]] && [ "$PORT_NUM" -ge 1024 ] && [ "$PORT_NUM" -le 65535 ]
  then
    echo "validated input: port num is $PORT_NUM"
    break
  else
    echo "nononono please input in range 1024 to 65535"
  fi
done


npm init -y &&
npm install express nodemon dotenv

echo "add node_modules and .env into .gitignore file"
echo "node_modules" >> .gitignore
echo ".env" >> .gitignore



echo "creat app.mjs with init express setup"
cat <<EOL > server.mjs
import express from "express";

const app = express();
const port = $PORT_NUM;

app.get('/api', (req, res) => {
  res.send("Hello from server");
});

app.get("/test", (req, res) => {
  return res.json("Server API is working");
});

app.listen(port, () => {
  console.log(\`Server is running at \${port}\`);
});
EOL

jq '.scripts.start = "nodemon server.mjs"' package.json > tmp.$$.json && mv tmp.$$.json package.json

echo "start server in port $PORT_NUM"
x-terminal-emulator -e "npm start" &
sleep 1

echo "opening in browser"
google-chrome "http://localhost:$PORT_NUM/test"
cd ..
echo "backend side setup complete"








echo "start setup frontend side"

npm create vite@latest client -- --template react
cd client

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

npm install

echo "start client server"
x-terminal-emulator -e "npm run dev"
sleep 1

echo "opening in browser"
google-chrome "http://localhost:5173/"

echo "setup frontend side complete"







echo "update vite config file"

CONFIG_FILE="vite.config.mjs"

# Write the new content to the file
cat <<EOL > $CONFIG_FILE
import react from "@vitejs/plugin-react"
import { defineConfig } from "vite"

export default defineConfig({
  plugins: [
    react(),
  ],
  server: {
    port: 3000,
    host: "0.0.0.0",
    proxy: {
        '/api': {
          target: 'http://localhost:$PORT_NUM',
          changeOrigin: true,
          rewrite: (path) => path.replace(/^\/api/, '')
        }
    }
  },
  build: {
    outDir: "build",
  },
})
EOL

echo "vite.config.mjs has been updated."





cd ..
echo "creating git commit object"
git add .
git commit -m "init commit"










# rm -- "$0"

echo "setup complete"
