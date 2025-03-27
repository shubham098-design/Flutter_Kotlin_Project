const express = require("express");
const admineRouter = express.Router();
const admine = require("../middlewares/admine");
const Product = require("../models/product");

// add product
admineRouter.post("/api/addproduct", async (req, res) => {
  try {
    const { name, price, description, category, image,quantity } = req.body;
    let product = new Product({ name, price, description, category, image ,quantity});
    product = await product.save();
    res
      .status(201)
      .json({ data: product, message: "Product added successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Something went wrong" });
  }
});

admineRouter.get("/api/products", async (req, res) => {
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

admineRouter.get("/api/products/:id", async (req, res) => {
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

admineRouter.get("/api/products/category/:category", async (req, res) => {
  try {
    const category = req.params.category;
    console.log("Requested Category:", category); // Debugging

    const products = await Product.find({ category: category });

    if (products.length === 0) {
      return res
        .status(404)
        .json({ message: "No products found in this category" });
    }

    res.status(200).json({ data: products });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Something went wrong" });
  }
});

admineRouter.get("/api/products/search/:query", async (req, res) => {
  try {
    const query = req.params.query;
    console.log("Search Query:", query);

    // MongoDB `$or` operator for multiple fields search
    const products = await Product.find({
      $or: [
        { name: new RegExp(query, "i") }, // Search in product name
        { category: new RegExp(query, "i") }, // Search in category
      ],
    });

    if (products.length === 0) {
      return res.status(404).json({ message: "No products found" });
    }

    res.status(200).json({ data: products });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Something went wrong" });
  }
});


admineRouter.put("/api/products/:id", async (req, res) => {
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

admineRouter.delete("/api/products/:id", async (req, res) => {
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
