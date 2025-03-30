const express = require("express");
const { Product } = require("../models/product");
const User = require("../models/user");
const userRouter = express.Router();


userRouter.post("/api/addToCart", async (req, res) => {
  try {
    const { userId, productId } = req.body;

    // 🛑 Validate inputs
    if (!userId || !productId) {
      return res
        .status(400)
        .json({ message: "User ID and Product ID are required" });
    }

    // ✅ Find user & product
    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    const product = await Product.findById(productId);
    if (!product) {
      return res.status(404).json({ message: "Product not found" });
    }

    // ✅ Check if product already in cart
    let isProductFound = false;
    for (let i = 0; i < user.cart.length; i++) {
      if (user.cart[i].product._id.equals(product._id)) {
        user.cart[i].quantity += 1;
        isProductFound = true;
        break;
      }
    }

    // ✅ If product not found, push new entry
    if (!isProductFound) {
      user.cart.push({ product, quantity: 1 });
    }

    await user.save();
    res.status(200).json({ message: "Product added to cart", cart: user.cart });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Internal server error" });
  }
});

userRouter.get("/api/getCart", async (req, res) => {
  try {
    const { userId } = req.query; // 👈 Extract userId from query parameters

    if (!userId) {
      return res.status(400).json({ message: "User ID is required" });
    }

    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    res.status(200).json({ cart: user.cart });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Internal server error" });
  }
});

userRouter.delete("/api/removeFromCart/:productId", async (req, res) => {
  try {
    const { userId } = req.query; // 👈 Get userId from query params
    const { productId } = req.params;

    if (!userId || !productId) {
      return res.status(400).json({ message: "User ID and Product ID are required" });
    }

    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    // ✅ Remove product from cart
    user.cart = user.cart.filter((item) => item.product._id.toString() !== productId);

    await user.save();

    res.status(200).json({ message: "Product removed from cart", cart: user.cart });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Internal server error" });
  }
});

module.exports = userRouter;
