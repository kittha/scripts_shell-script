#!/bin/bash

SERVER_DIR=$(find . -type d -name "server" 2>/dev/null)

if [ -z "$SERVER_DIR" ]; then
    echo "No folder named 'server' found."
    exit 1
fi

MIDDLEWARES_DIR="$SERVER_DIR/middlewares"
mkdir -p "$MIDDLEWARES_DIR"

touch "$MIDDLEWARES_DIR/post.validation.mjs"

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

# EOF

echo "Script execution completed successfully."

#rm -- "$0"
