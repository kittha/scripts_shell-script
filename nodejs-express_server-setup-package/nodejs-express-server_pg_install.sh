#!/bin/bash

SERVER_DIR=$(find . -type d -name "server" 2>/dev/null)

if [ -z "$SERVER_DIR" ]; then
    echo "No folder named 'server' found."
    exit 1
fi

UTILS_DIR="$SERVER_DIR/utils"
mkdir -p "$UTILS_DIR"

DB_FILE="$UTILS_DIR/db.mjs"
touch "$DB_FILE"

cat <<EOL > "$DB_FILE"
import pg from "pg";
import "dotenv/config";

const { Pool } = pg.default;

const connectionPool = new Pool({
  user: "",
  host: "",
  database: "",
  password: `${process.env.DB_PASSWORD}`,
  port: 5432,
});

export default connectionPool;
EOL

echo "Script execution completed successfully."

#rm -- "$0"
