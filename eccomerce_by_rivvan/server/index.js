// import packages
const express = require("express");
const mongoose = require("mongoose");

// instantiate express
const app = express();
const DB =
  "mongodb+srv://shubhamdhaniyan:shu251203@cluster0.z1uay.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

// import files
const authRouter = require("./routes/auth");
const productRouter = require("./routes/product");
const cartRouter = require("./routes/cart");
const orderRouter = require("./routes/order");
const userRouter = require("./routes/user");

// middleware
app.use(express.json());
app.use(authRouter);
app.use(productRouter);
app.use(cartRouter);
app.use(orderRouter);
app.use(userRouter);
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
