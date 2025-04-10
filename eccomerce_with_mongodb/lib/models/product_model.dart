class ProductModel {
  final String id;
  final String name;
  final String category;
  final int price;
  final String description;
  final List<String> images;
  final int quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.images,
    required this.quantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      name: json['name'],
      category: json['category'],
      price: json['price'],
      description: json['description'],
      images: List<String>.from(json['image']),
      quantity: json['quantity'],
    );
  }
}