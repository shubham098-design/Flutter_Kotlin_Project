const express = require("express");
const bodyParser = require("body-parser");
// const helmet = require("helmet");
const morgan = require("morgan");
const cors = require("cors");
const mongoose = require("mongoose");

const app = express();
// const port = 3000;
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
// app.use(helmet());
app.use(morgan("dev"));
app.use(cors());

// app.get("/", (req, res) => {
//   res.json({ message: "Hello World!", errror: "error" });
// });

// const DB =
//   "mongodb+srv://shubhamdhaniyan:shu251203@cluster0.z1uay.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

// const DB =
//   "mongodb+srv://shubhamdhaniyan09:shu251203@cluster0.tb197.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

const DB =
  "mongodb+srv://shubhamdhaniyan09:shu251203@cluster0.0btbu.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

// connect to the database
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connected to the database");
  })
  .catch((err) => {
    console.log(err);
  });

const UserRoutes = require("./routes/user_routes");
app.use("/api/user", UserRoutes);

const CategoryRoutes = require("./routes/category_routes");
app.use("/api/category", CategoryRoutes);

const ProductRoutes = require("./routes/products_routes");
app.use("/api/product", ProductRoutes);

const CartRoutes = require("./routes/cart_routes");
app.use("/api/cart", CartRoutes);

const OrderRoutes = require("./routes/order_routes");
app.use("/api/order", OrderRoutes);

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
  console.log(`Example app listening on port ${PORT}`);
});
