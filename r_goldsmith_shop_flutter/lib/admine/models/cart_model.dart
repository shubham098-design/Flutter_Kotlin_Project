class CartModel {
  final int id;
  final DateTime createdAt;
  final int productId;
  final String quantity;
  final int userId;

  CartModel({
    required this.id,
    required this.createdAt,
    required this.productId,
    required this.quantity,
    required this.userId,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      productId: json['product_id'],
      quantity: json['quantity'],
      userId: json['user_id'],
    );
  }
}
