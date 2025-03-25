// import packages
const express = require("express");
const mongoose = require("mongoose");

// instantiate express
const app = express();
const DB =
  "mongodb+srv://shubhamdhaniyan:shu251203@cluster0.z1uay.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

// import files
const authRouter = require("./routes/auth");
const admineRouter = require("./routes/admine");

// middleware
app.use(express.json());
app.use(authRouter);
app.use(admineRouter);
// create server
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connected to MongoDB");
  })
  .catch((err) => {
    console.log(err);
  });

app.listen(3000, () => console.log("http://localhost:3000"));
module.exports = app;
