const mongoose = require("mongoose");

const productSchema = new mongoose.Schema({
  name: { type: String, required: true, trim: true },
  category: { type: String, required: true },
  price: { type: Number, required: true },
  description: { type: String, required: true, trim: true },
  image: [{ type: String, required: true }],
  quantity: { type: Number, required: true },
});

const Product = mongoose.model("Product", productSchema);

// ✅ Export both Product and productSchema
module.exports = { Product, productSchema };
