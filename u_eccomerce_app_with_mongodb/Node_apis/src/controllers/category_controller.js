const CategoryModel = require("../models/category_model");
const CategoryController = {
  createCategory: async function (req, res) {
    try {
      const categoryData = req.body;
      const newCategory = new CategoryModel(categoryData);
      await newCategory.save();
      return res.json({
        success: true,
        data: newCategory,
        message: "Category created successfully",
      });
    } catch (error) {
      return res.json({ success: false, error: error.message });
    }
  },

  fetchAllCategories: async function (req, res) {
    try {
      const categories = await CategoryModel.find();
      return res.json({ success: true, data: categories });
    } catch (error) {
      return res.json({ success: false, error: error.message });
    }
  },

  fetchCategoryById: async function (req, res) {
    try {
      const id = req.params.id;
      const foundCategory = await CategoryModel.findById(id);
      if (!foundCategory) {
        return res.json({ success: false, message: "Category not found" });
      }
      return res.json({ success: true, data: foundCategory });
    } catch (error) {
      return res.json({ success: false, error: error.message });
    }
  },
};

module.exports = CategoryController;
