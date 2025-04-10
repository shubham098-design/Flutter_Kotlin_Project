class CartItemModel {
  final int productId;

  CartItemModel({required this.productId});

  // JSON to Dart object conversion
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(productId: json['product_id']);
  }

  // Dart object to JSON conversion
  Map<String, dynamic> toJson() {
    return {'product_id': productId};
  }
}
