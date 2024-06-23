#!/bin/bash

SCRIPT_NAME=$(basename "$0")



PROJECT_NAME="$1"
PORT_NUM="$2"

if [ -z "$PROJECT_NAME" ] || [ -z "$PORT_NUM" ]; then
  echo "Error: Project name or port number not provided."
  exit 1
fi

SERVER_DIR="./$PROJECT_NAME/server"
ROUTES_DIR="$SERVER_DIR/routes"

if [ ! -d "$SERVER_DIR" ]; then
  echo "Error: Server directory not found. Make sure to run Script Two first."
  exit 1
fi

mkdir -p "$ROUTES_DIR"

touch "$ROUTES_DIR/post.mjs"

cat << 'EOL' > "$ROUTES_DIR/post.mjs"

import { Router } from "express";
import { validateCreatePostData } from "../middlewares/post.validation.mjs"
// import connectionPool from "../utils/db.mjs";

const postRouter = Router();



// CREATE
postRouter.post("/", [validateCreatePostData], async (req, res) => {
  try {
    const { title, content, category, length, status } = req.body;
    const newPost = {
      title,
      content,
      category,
      length,
      status,
      created_at: new Date(),
      updated_at: new Date(),
      published_at: new Date()
    };

    await connectionPool.query(
      `INSERT INTO posts (user_id, title, content, category, length, created_at, updated_at, published_at, status)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)`,
      [
        1,
        newPost.title,
        newPost.content,
        newPost.category,
        newPost.length,
        newPost.created_at,
        newPost.updated_at,
        newPost.published_at,
        newPost.status
      ]
    );

    return res.status(201).json({
      message: "Created post successfully"
    });
  } catch (error) {
    console.error("Error creating post:", error);
    return res.status(500).json({
      message: "Server could not create post because of a database issue"
    });
  }
});

// READ
postRouter.get("/:postId", async (req, res) => {
  const postIdFromClient = req.params.postId;

  try {
    const results = await connectionPool.query(
      `SELECT * FROM posts WHERE post_id=$1`,
      [postIdFromClient]
    );

    if (!results.rows[0]) {
      return res.status(404).json({
        message: `Server could not find a requested post (post id: ${postIdFromClient})`
      });
    }

    return res.status(200).json({
      data: results.rows[0],
    });
  } catch (error) {
    console.error("Error fetching post:", error);
    return res.status(500).json({
      message: "Server could not fetch the post due to a database issue"
    });
  }
});

postRouter.get("/", async (req, res) => {
  const title = req.query.title ? `%${req.query.title}%` : null;

  const category = req.query.category ? `%${req.query.category}%` : null;

  try {
    const result = await connectionPool.query(
      ` 
    SELECT * FROM posts WHERE (title ILIKE $1 OR $1 IS NULL) AND (category ILIKE $2 OR $2 IS NULL) 
    `,
      [title, category]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        message: `no posts found)`
      });
    }

    return res.json({
      data: result.rows,
    });
  } catch (error) {
    console.error("Error fetching posts:", error);
    return res.status(500).json({
      message: "Server could not fetch the posts due to a database issue"
    });
  }
});

// UPDATE
postRouter.put("/:postId", async (req, res) => {
  try {
    const postIdFromClient = req.params.postId;
    const { title, content, category, length, status } = req.body;
    const updatedPost = {
      title,
      content,
      category,
      length,
      status,
      updated_at: new Date()
    };

    await connectionPool.query(
      `
      UPDATE posts
      SET title = $2,
          content = $3,
          category = $4,
          length = $5,
          status = $6,
          updated_at = $7
      WHERE post_id = $1
      `,
      [
        postIdFromClient,
        updatedPost.title,
        updatedPost.content,
        updatedPost.category,
        updatedPost.length,
        updatedPost.status,
        updatedPost.updated_at
      ]
    );

    return res.status(200).json({
      message: "Updated post successfully"
    });
  } catch (error) {
    console.error("Error updating post:", error);
    return res.status(500).json({
      message: "Server could not update the post due to a database issue"
    });
  }
});

// DELETE
postRouter.delete("/:postId", async (req, res) => {
  try {
    const postIdFromClient = req.params.postId;

    const result = await connectionPool.query(
      `
        DELETE FROM posts
        WHERE post_id = $1
        `,
      [postIdFromClient]
    );

    if (result.rowCount === 0) {
      return res.status(404).json({
        message: `Server could not find a requested post (post id: ${postIdFromClient})`
      });
    }

    return res.status(200).json({
      message: "Deleted post successfully"
    });
  } catch (error) {
    console.error("Error deleting post:", error);
    return res.status(500).json({
      message: "Server could not delete the post due to a database issue"
    });
  }
});




export default postRouter













EOL

echo "Script execution completed successfully."

#rm -- "$0"
