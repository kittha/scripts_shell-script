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

touch "$UTILS_DIR/db.mjs" || { echo "Failed to create db.mjs file."; exit 1; }

cat <<EOL > "$UTILS_DIR/db.mjs"
import * as pg from "pg";
import "dotenv/config";

const { Pool } = pg.default;

const connectionPool = new Pool({
  user: "",
  host: "",
  database: "",
  password: \`\${process.env.DB_PASSWORD}\`,
  port: 5432,
});

export default connectionPool;
EOL

echo "Script execution completed successfully."

#rm -- "$0"
