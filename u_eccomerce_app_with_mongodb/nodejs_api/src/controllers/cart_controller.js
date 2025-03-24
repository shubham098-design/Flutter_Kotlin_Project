const CartModel = require("./../models/cart_model");
const CartController = {
  addToCart: async function (req, res) {
    try {
      const { product, user, quantity } = req.body;
      const foundCart = await CartModel.findOne({ user: user }).populate(
        "items.product"
      );

      // if cart does not exist
      if (!foundCart) {
        const newCart = new CartModel({ user: user });
        newCart.items.push({ product: product, quantity: quantity });
        await newCart.save();
        return res.json({
          success: true,
          data: newCart,
          message: "Product added to cart successfully",
        });
      }

      // Deleting the item if it already exist

      const deletedItem = await CartModel.findOneAndUpdate(
        { user: user, "items.product": product },
        { $pull: { items: { product: product } } },
        { new: true }
      );

      // if cart already exists
      const updatedCart = await CartModel.findOneAndUpdate(
        { user: user },
        { $push: { items: { product: product, quantity: quantity } } },
        { new: true }
      ).populate("items.product");
      return res.json({
        success: true,
        data: updatedCart.items,
        message: "Product added to cart successfully",
      });
    } catch (err) {
      return res.json({ success: false, error: err.message });
    }
  },

  removeFromCart: async function (req, res) {
    try {
      const { user, product } = req.body;
      const updatedCart = await CartModel.findOneAndUpdate(
        { user: user },
        { $pull: { items: { product: product } } },
        { new: true }
      );

      return res.json({
        success: true,
        data: updatedCart,
        message: "Product added to cart successfully",
      });
    } catch (err) {
      return res.json({ success: false, error: err.message });
    }
  },

  getCartForUser: async function (req, res) {
    try {
      const user = req.params.user;
      const foundCart = await CartModel.findOne({ user: user });

      if (!foundCart) {
        return res.json({
          success: true,
          data: [],
        });
      }

      return res.json({
        success: true,
        data: foundCart.items,
      });
    } catch (err) {
      return res.json({ success: false, error: err.message });
    }
  },
};

module.exports = CartController;
