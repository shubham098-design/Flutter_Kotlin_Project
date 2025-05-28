class UserModel {
  final int id;
  final String createdAt;
  final String username;
  final String email;
  final String password;
  final String phone;
  final String? profilePic;
  final String userId;
  final String? channelName;
  final String? channelDescription;

  UserModel({
    required this.id,
    required this.createdAt,
    required this.username,
    required this.email,
    required this.password,
    required this.phone,
    this.profilePic,
    required this.userId,
    this.channelName,
    this.channelDescription,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      createdAt: json['created_at'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      profilePic: json['profile_pic'],
      userId: json['user_id'],
      channelName: json['channel_name'],
      channelDescription: json['channel_description'],
    );
  }
}
