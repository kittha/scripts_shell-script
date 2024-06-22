#!/bin/bash

# create server & local repo only
# if you want to upload into GitHub remote repo, please use another script

SCRIPT_NAME=$(basename "$0")

echo "### nodejs express create server script for lazy guy ###"

while true; do
  echo "Enter server port num in range 1024 to 65535"
  read PORT_NUM

  if [[ "$PORT_NUM" =~ ^[0-9]+$ ]] && [ "$PORT_NUM" -ge 1024 ] && [ "$PORT_NUM" -le 65535 ]
  then
    echo "validated input: port num is $PORT_NUM"
    break
  else
    echo "nononono please input in range 1024 to 65535"
  fi
done

echo "Enter your project name"
read PROJECT_NAME

echo "creating core structure"
mkdir -p ./$PROJECT_NAME/server
cd ./$PROJECT_NAME/server || exit
git init
npm init -y &&
npm install express nodemon dotenv

echo "add node_modules into .gitignore file"
echo "node_modules" >> .gitignore
echo ".env" >> .gitignore

echo "creating git commit object"
git add .
git commit -m "init commit"


echo "creat app.mjs with init express setup"
cat <<EOL > app.mjs
import express from "express";

const app = express();
const port = $PORT_NUM;

app.get("/test", (req, res) => {
  return res.json("Server API is working");
});

app.listen(port, () => {
  console.log(\`Server is running at \${port}\`);
});
EOL

jq '.scripts.start = "nodemon app.mjs"' package.json > tmp.$$.json && mv tmp.$$.json package.json

echo "start server in port $PORT_NUM"
x-terminal-emulator -e "npm run start" &
sleep 1

echo "opening in browser"
google-chrome "http://localhost:$PORT_NUM/test"

# rm -- "$0"

echo "setup complete"
