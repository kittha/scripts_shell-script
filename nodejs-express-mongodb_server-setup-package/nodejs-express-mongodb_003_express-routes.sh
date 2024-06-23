#!/bin/bash

#fix me with mongo syntax

SCRIPT_NAME=$(basename "$0")



PROJECT_NAME="$1"
PORT_NUM="$2"

if [ -z "$PROJECT_NAME" ] || [ -z "$PORT_NUM" ]; then
  echo "Error: Project name or port number not provided."
  exit 1
fi

SERVER_DIR="./$PROJECT_NAME/server"
API_DIR="$SERVER_DIR/apps"

if [ ! -d "$SERVER_DIR" ]; then
  echo "Error: Server directory not found. Make sure to run Script Two first."
  exit 1
fi

mkdir -p "$API_DIR"

touch "$API_DIR/post.js"

cat << 'EOL' > "$API_DIR/post.js"

import { ObjectId } from "mongodb";
import { Router } from "express";
// import { db } from "../utils/db.js"
import { validateCreatePostData } from "../middlewares/post.validation.mjs"

const movieRouter = Router();



// CREATE


// READ


// UPDATE


// DELETE

 



export default movieRouter



EOL

echo "Script execution completed successfully."

#rm -- "$0"
