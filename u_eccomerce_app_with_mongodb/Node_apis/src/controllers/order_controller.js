const OrderModel = require("./../models/order_model");
const OrderController = {
  createOrder: async function (req, res) {
    try {
      const { user, items } = req.body;
      const newOrder = new OrderModel({
        user: user,
        items: items,
      });
      await newOrder.save();

      return res.json({
        success: true,
        data: newOrder,
        message: "Order created successfully",
      });
    } catch (err) {
      return res.json({ success: false, error: err.message });
    }
  },

  fetchOrdersForUser: async function (req, res) {
    try {
      const userId = req.params.userId;
      const foundOrders = await OrderModel.find({ "user.id": userId });

      return res.json({
        success: true,
        data: foundOrders,
      });
    } catch (err) {
      return res.json({ success: false, error: err.message });
    }
  },

  updateOrderStatus: async function (req, res) {
    try {
      const { orderId, status } = req.body;

      const updateOrder = await OrderModel.findOneAndUpdate(
        { _id: orderId },
        { status: status },
        { new: true }
      );
      return res.json({
        success: true,
        data: updateOrder,
      });
    } catch (err) {
      return res.json({ success: false, error: err.message });
    }
  },
};

module.exports = OrderController;
