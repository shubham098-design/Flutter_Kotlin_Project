const express = require("express");
const admineRouter = express.Router();
const admine = require("../middlewares/admine");
const Product = require("../models/product");

// add product
admineRouter.post("/api/addproduct", admine, async (req, res) => {
  try {
    const { name, price, description, category, image } = req.body;
    let product = new Product({ name, price, description, category, image });
    product = await product.save();
    res
      .status(201)
      .json({ data: product, message: "Product added successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Something went wrong" });
  }
});

admineRouter.get("/api/products", admine, async (req, res) => {
  try {
    const products = await Product.find();
    res
      .status(200)
      .json({ data: products, message: "Products fetched successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Something went wrong" });
  }
});

admineRouter.get("/api/products/:id", admine, async (req, res) => {
  try {
    const product = await Product.findById(req.params.id);
    res
      .status(200)
      .json({ data: product, message: "Product fetched successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Something went wrong" });
  }
});

admineRouter.put("/api/products/:id", admine, async (req, res) => {
  try {
    const product = await Product.findByIdAndUpdate(req.params.id, req.body, {
      new: true,
      runValidators: true,
    });
    res
      .status(200)
      .json({ data: product, message: "Product updated successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Something went wrong" });
  }
});

admineRouter.delete("/api/products/:id", admine, async (req, res) => {
  try {
    const product = await Product.findByIdAndDelete(req.params.id);
    res
      .status(200)
      .json({ data: product, message: "Product deleted successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Something went wrong" });
  }
});

module.exports = admineRouter;
