#!/bin/bash


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
movieRouter.post("/", async (req, res) => {

  const collection = db.collection("movies");

  const movieData = { ...req.body };
  const movies = await collection.insertOne(movieData);

  return res.json({
    message: `Movie record (${movies.insertedId}) has been created successfully`,
  });
});


// READ
movieRouter.get("/", async (req, res) => {
  const collection = db.collection("movies");

  const movies = await collection
    .find({ year: 2008 })
    .limit(10) // limit the result documents by 10
    .toArray(); // convert documents into an array

  return res.json({ data: movies });
});


// UPDATE
movieRouter.put("/:movieId", async (req, res) => {

  const collection = db.collection("movies");

  const movieId = ObjectId(req.params.movieId);
  // นำข้อมูลที่ส่งมาใน Request Body ทั้งหมด Assign ใส่ลงไปใน Variable ที่ชื่อว่า `newMovieData`
  const newMovieData = { ...req.body };

  await collection.updateOne(
    {
      _id: movieId,
    },
    {
      $set: newMovieData,
    }
  );
  
  return res.json({
    message: `Movie record (${movieId}) has been updated successfully`,
  });
});


// DELETE
movieRouter.delete("/:movieId", async (req, res) => {
  const collection = db.collection("movies");

  await collection.deleteOne({
    _id: movieId,
  });


  return res.json({
    message: `Movie record (${movieId}) has been deleted successfully`,
  });
});
 



export default movieRouter



EOL

echo "Script execution completed successfully."

#rm -- "$0"
