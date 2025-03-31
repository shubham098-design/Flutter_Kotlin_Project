const mongoose = require("mongoose");
const { productSchema } = require("./product");

console.log("productSchema:", productSchema);

const userSchema = new mongoose.Schema({
  name: { type: String, required: true, trim: true },
  email: { type: String, required: true, unique: true, trim: true },
  password: { type: String, required: true, trim: true },
  address: { type: String, default: "" },
  type: { type: String, default: "user" },
  cart: [
    {
      product: productSchema, // ✅ Now it will work!
      quantity: {
        type: Number,
        required: true,
      },
    },
  ],
});

const User = mongoose.model("User", userSchema);
module.exports = User;
