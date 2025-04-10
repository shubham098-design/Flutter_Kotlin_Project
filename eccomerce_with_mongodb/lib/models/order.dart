// Order Model
class Order {
  final String id;
  final String userId;
  final List<OrderProduct> products;
  final int amount;
  final OrderAddress address;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Order({
    required this.id,
    required this.userId,
    required this.products,
    required this.amount,
    required this.address,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      userId: json['userId'],
      products: (json['products'] as List)
          .map((product) => OrderProduct.fromJson(product))
          .toList(),
      amount: json['amount'],
      address: OrderAddress.fromJson(json['address']),
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class OrderProduct {
  final Product product;
  final int quantity;

  OrderProduct({required this.product, required this.quantity});

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      product: Product.fromJson(json['productId']),
      quantity: json['quantity'],
    );
  }
}

class Product {
  final String id;
  final String name;
  final String category;
  final int price;
  final String description;
  final List<String> image;
  final int quantity;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.image,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      category: json['category'],
      price: json['price'],
      description: json['description'],
      image: List<String>.from(json['image']),
      quantity: json['quantity'],
    );
  }
}

class OrderAddress {
  final String street;
  final String city;
  final String pincode;

  OrderAddress({required this.street, required this.city, required this.pincode});

  factory OrderAddress.fromJson(Map<String, dynamic> json) {
    return OrderAddress(
      street: json['street'],
      city: json['city'],
      pincode: json['pincode'],
    );
  }
}
