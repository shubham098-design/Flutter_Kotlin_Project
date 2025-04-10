class User {
  final String id;
  final String name;
  final String email;
  final String address;
  final String type;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.type,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["user"]["_id"],  // Accessing the _id inside the "user" key
      name: json["user"]["name"],
      email: json["user"]["email"],
      address: json["user"]["address"],
      type: json["user"]["type"],
    );
  }
}
