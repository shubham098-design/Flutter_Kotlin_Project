class OrderModel{
  final int productId;

  OrderModel({required this.productId});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(productId: json['product_id']);
  }
  Map<String, dynamic> toJson() {
    return {'product_id': productId};
  }
}