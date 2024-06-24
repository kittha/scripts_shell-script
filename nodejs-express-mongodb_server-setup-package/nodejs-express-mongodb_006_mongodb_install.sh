#!/bin/bash

SCRIPT_NAME=$(basename "$0")


PROJECT_NAME="$1"
PORT_NUM="$2"

if [ -z "$PROJECT_NAME" ] || [ -z "$PORT_NUM" ]; then
  echo "Error: Project name or port number not provided."
  exit 1
fi

SERVER_DIR="./$PROJECT_NAME/server"
UTILS_DIR="$SERVER_DIR/utils"

if [ ! -d "$SERVER_DIR" ]; then
  echo "Error: Server directory not found. Make sure to run Script Two first."
  exit 1
fi

mkdir -p "$UTILS_DIR" || { echo "Failed to create utils directory."; exit 1; }

touch "$UTILS_DIR/db.js" || { echo "Failed to create db.mjs file."; exit 1; }

cat <<EOL > "$UTILS_DIR/db.js"
import { MongoClient } from "mongodb"

const connectionString = "mongodb://127.0.0.1:27017";
//const connectionString = "mongodb://myUsername:\${process.env.DB_PASSWORD}@127.0.0.1:27017/myDatabase";

export const client = new MongoClient(connectionString, {
  useUnifiedTopology: true,
});

export const db = client.db("");
// edit here
EOL

echo "Script execution completed successfully."

#rm -- "$0"
