#!/bin/bash

# create server & local repo only
# if you want to upload into GitHub remote repo, please use another script

SCRIPT_NAME=$(basename "$0")



PROJECT_NAME="$1"
PORT_NUM="$2"




echo "creating core structure"
mkdir -p ./$PROJECT_NAME/server || { echo "Failed to create project directory."; exit 1; }
cd ./$PROJECT_NAME/server || { echo "Failed to enter project directory."; exit 1; }
echo 'DB_PASSWORD=""' >> .env
echo "PORT=\"$PORT_NUM\"" >> .env

git init || { echo "Failed to initialize Git repository."; exit 1; }
npm init -y &&
npm install --save dotenv express nodemon pg || { echo "Failed to initialize npm and install dependencies."; exit 1; }
#npm install --save dotenv express mongodb nodemon || { echo "Failed to initialize npm and install dependencies."; exit 1; }

echo "add node_modules into .gitignore file"
echo "node_modules" >> .gitignore
echo ".env" >> .gitignore

echo "creating git commit object"
git add .
git commit -m "Initial commit" || { echo "Failed to create initial commit."; exit 1; }


echo "creat app.mjs with init express setup"
cat << EOL > app.mjs

import express from "express";
import { Router } from "express";
import movieRouter from "./apps/movies.js";
// TODO: unlock import connectionPool in files at routes folder
import { client } from "./utils/db.js"

async function init() {
  const app = express();
  const port = \${process.env.PORT} || 4000;
  
  await client.connect();
  
  app.use(express.json());
  app.use(express.urlencoded({ extended: true }));
  
  app.use("/movies", movieRouter);

  app.get("/test", (req, res) => {
    return res.json("Server API is working");
  });
  
  app.get("*", (req, res) => {
    res.status(404).send("Not found");
  }

  app.listen(port, () => {
    console.log(\`Server is running at \${port}\`);
  });
}

init();

EOL

jq '.scripts.start = "nodemon app.mjs"' package.json > tmp.$$.json && mv tmp.$$.json package.json

echo "start server in port $PORT_NUM"
x-terminal-emulator -e "npm run start" &
sleep 2

#echo "opening in browser"
#google-chrome "http://localhost:$PORT_NUM/test"

#rm -- "$0"

echo "setup complete"
