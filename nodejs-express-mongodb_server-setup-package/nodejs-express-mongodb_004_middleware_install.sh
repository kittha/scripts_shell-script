#!/bin/bash

SCRIPT_NAME=$(basename "$0")


PROJECT_NAME="$1"
PORT_NUM="$2"

if [ -z "$PROJECT_NAME" ] || [ -z "$PORT_NUM" ]; then
  echo "Error: Project name or port number not provided."
  exit 1
fi

SERVER_DIR="./$PROJECT_NAME/server"
MIDDLEWARES_DIR="$SERVER_DIR/middlewares"

if [ ! -d "$SERVER_DIR" ]; then
  echo "Error: Server directory not found. Make sure to run Script Two first."
  exit 1
fi


mkdir -p "$MIDDLEWARES_DIR" || { echo "Failed to create middlewares directory."; exit 1; }

touch "$MIDDLEWARES_DIR/post.validation.mjs" || { echo "Failed to create post.validation.mjs file."; exit 1; }


cat <<EOL > "$MIDDLEWARES_DIR/post.validation.mjs"


export const validateCreatePostData = (req, res, next) => {
  try {
    if (!req.body.title) {
      return res.status(401).json({
        message: "กรุณาส่งข้อมูล Title ของโพสต์เข้ามาด้วย"
      });
    }

    if (!req.body.content) {
      return res.status(401).json({
        message: "กรุณาส่งข้อมูล Content ของโพสต์เข้ามาด้วย"
      });
    }

    if (!req.body.category) {
      return res.status(401).json({
        message: "กรุณาส่งข้อมูล Category ของโพสต์เข้ามาด้วย"
      });
    }

    if (!req.body.length) {
      return res.status(401).json({
        message: "กรุณาส่งข้อมูล Length ของโพสต์เข้ามาด้วย"
      });
    }

    const postLengthList = ["short", "long", "medium"];
    const hasPostLengthList = postLengthList.includes(req.body.length);

    if (!hasPostLengthList) {
      return res.status(401).json({
        message: "กรุณาส่งข้อมูล Length ของโพสต์ตามที่กำหนด เช่น 'short', 'long' หรือ 'medium'"
      });
    }

    if (req.body.content.length > 100) {
      return res.status(401).json({
        message: "กรุณาส่งข้อมูล Content ของโพสต์ตามที่กำหนดไม่เกิน 100 ตัวอักษร"
      });
    }

    next();

  } catch (error) {
    console.error('Validation error:', error.message);
    res.status(400).json({ error: error.message });
  }
};

EOL

echo "Script execution completed successfully."

#rm -- "$0"
