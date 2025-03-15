const OrderModel = require("./../models/order_model");
const CartModel = require("./../models/cart_model");
const razorpay = require("./../services/razorpay");

const OrderController = {
  createOrder: async function (req, res) {
    try {
      const { user, items, status, totalAmount } = req.body;

      // creating the order in razorpay
      const razorpayOrder = await razorpay.orders.create({
        amount: totalAmount * 100,
        currency: "INR",
      });

      const newOrder = new OrderModel({
        user: user,
        items: items,
        status: status,
        totalAmount: totalAmount,
        razorpayOrderId: razorpayOrder.id,
      });
      await newOrder.save();

      // updating the cart items after order is placed
      await CartModel.findOneAndUpdate({ user: user._id }, { items: [] });

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
      const foundOrders = await OrderModel.find({ "user._id": userId }).sort({
        createdAt: -1,
      });

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
      const { orderId, status, razorpayPaymentId, razorpaySignature } =
        req.body;

      const updateOrder = await OrderModel.findOneAndUpdate(
        { _id: orderId },
        {
          status: status,
          razorpayPaymentId: razorpayPaymentId,
          razorpaySignature: razorpaySignature,
        },
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
