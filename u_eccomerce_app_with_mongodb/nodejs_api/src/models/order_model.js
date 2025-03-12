const { Schema, model } = require("mongoose");

const OrderItemSchema = new Schema({
  product: { type: Map, required: true },
  quantity: { type: Number, default: 1 },
});

const OrderSchema = new Schema({
  user: { type: Map, required: true },
  items: { type: [OrderItemSchema], default: [] },
  status: { type: String, default: "order-placed" },
  updatedOn: { type: Date },
  createdOn: { type: Date },
});

OrderSchema.pre("save", function (next) {
  this.updatedOn = new Date();
  this.createdOn = new Date();
  next();
});

OrderSchema.pre(["update", "findOneAndUpdate", "updateOne"], function (next) {
  const update = this.getUpdate();
  delete update._id;
  this.updatedOn = new Date();
  next();
});

const OrderModel = model("Order", OrderSchema);

module.exports = OrderModel;
