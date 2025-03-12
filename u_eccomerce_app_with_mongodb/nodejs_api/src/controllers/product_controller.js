const ProductModel = require("../models/product_model");

const ProductController = {
  createProduct: async function (req, res) {
    try {
      const productData = req.body;
      const newProduct = new ProductModel(productData);
      await newProduct.save();
      return res.json({
        success: true,
        data: newProduct,
        message: "Product created successfully",
      });
    } catch (err) {
      return res.json({ success: false, error: error.message });
    }
  },

  fetchAllProduct: async function (req, res) {
    try {
      const products = await ProductModel.find();
      return res.json({
        success: true,
        data: products,
      });
    } catch (err) {
      return res.json({ success: false, error: error.message });
    }
  },

  fetchProductByCategory: async function (req, res) {
    try {
      const categoryId = req.params.id;
      const product = await ProductModel.find({ category: categoryId });
      if (!product) {
        return res.json({ success: false, message: "Product not found" });
      }
      return res.json({ success: true, data: product });
    } catch (err) {
      return res.json({ success: false, error: err.message });
    }
  },
};

module.exports = ProductController;
