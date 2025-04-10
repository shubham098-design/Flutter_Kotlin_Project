import 'dart:convert';

// ✅ Main Response Class
class CartResponse {
  final List<CartItem> cart;

  CartResponse({required this.cart});

  // JSON se Dart object me convert karne ka method
  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      cart: (json["cart"] as List).map((item) => CartItem.fromJson(item)).toList(),
    );
  }
}

// ✅ Cart Item Class
class CartItem {
  final Product product;
  final int quantity;
  final String id;

  CartItem({required this.product, required this.quantity, required this.id});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json["product"]),
      quantity: json["quantity"],
      id: json["_id"],
    );
  }
}

// ✅ Product Class
class Product {
  final String name;
  final String category;
  final int price;
  final String description;
  final List<String> image;
  final int quantity;
  final String id;

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.image,
    required this.quantity,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json["name"],
      category: json["category"],
      price: json["price"],
      description: json["description"],
      image: List<String>.from(json["image"]),
      quantity: json["quantity"],
      id: json["_id"],
    );
  }
}
