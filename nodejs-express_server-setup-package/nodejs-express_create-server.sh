#!/bin/bash

# create server & local repo only
# if you want to upload into GitHub remote repo, please use another script

SCRIPT_NAME=$(basename "$0")

echo "### nodejs express create server script for lazy guy ###"


echo "Enter your project name"
read PROJECT_NAME

while true; 
do
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

echo "creating core structure"
mkdir -p ./$PROJECT_NAME/server || { echo "Failed to create project directory."; exit 1; }
cd ./$PROJECT_NAME/server || { echo "Failed to enter project directory."; exit 1; }
git init || { echo "Failed to initialize Git repository."; exit 1; }
npm init -y &&
npm install express nodemon dotenv || { echo "Failed to initialize npm and install dependencies."; exit 1; }


echo "add node_modules into .gitignore file"
echo "node_modules" >> .gitignore
echo ".env" >> .gitignore

echo "creating git commit object"
git add .
git commit -m "Initial commit" || { echo "Failed to create initial commit."; exit 1; }


echo "creat app.mjs with init express setup"
cat << 'EOL' > app.mjs

import express from "express";
// import connectionPool from "./utils/db.mjs";
import { validateCreatePostData } from "./middlewares/post.validation.mjs"
// edit here

const app = express();
const port = process.env.PORT || 4000;

app.use(express.json());

app.get("/test", (req, res) => {
  return res.json("Server API is working");
});

// CREATE
app.post("/posts", validateCreatePostData, async (req, res) => {
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
app.get("/posts/:postId", async (req, res) => {
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

app.get("/posts", async (req, res) => {
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
app.put("/posts/:postId", async (req, res) => {
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
app.delete("/posts/:postId", async (req, res) => {
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

app.listen(port, () => {
  console.log(`Server is running at ${port}`);
});


EOL

jq '.scripts.start = "nodemon app.mjs"' package.json > tmp.$$.json && mv tmp.$$.json package.json

echo "start server in port $PORT_NUM"
x-terminal-emulator -e "npm run start" &
sleep 2

#echo "opening in browser"
#google-chrome "http://localhost:$PORT_NUM/test"

#rm -- "$0"

echo "setup complete"
