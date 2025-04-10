import 'dart:convert';
import 'package:eccomerce_with_mongodb/common/widget/bottom_bar.dart';
import 'package:eccomerce_with_mongodb/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../../constrants/utils.dart';
import '../shared_pref/shared_prefs.dart';

class UserService {
  static const String baseUrl =
      "https://ecommerceamozonclone.vercel.app/api/users";


  static Future<String?> signup(
      String name, String email, String password, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/signup"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "address": '',
          "type": "user",
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        String userId = data["user"]["_id"];
        await SharedPrefs.saveUserId(userId);
        showSnackBar(context, "Account created successfully");
        Navigator.pushNamed(context, BottomBar.routeName);
        return userId;
      } else {
        // ✅ Show Error Message
        final errorData = jsonDecode(response.body);
        showSnackBar(context, errorData["message"] ?? "Signup Failed");
        return null;
      }
    } catch (error) {
      showSnackBar(context, "Error: $error");
      return null;
    }
  }
  Future<String?> login(String email, String password, BuildContext context) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (!data.containsKey("user")) {
        print("Error: 'user' key not found in response");
        return null;
      }

      String userId = data["user"]["_id"];
      print("Extracted User ID: $userId");

      await SharedPrefs.saveUserId(userId);
      showSnackBar(context, "Login Successful");
      Navigator.pushNamed(context, BottomBar.routeName);
      return userId;
    } else {
      print("Login Failed: ${response.body}");
    }
    return null;
  }


  Future<void> logout() async {
    await SharedPrefs.clearUserId();
  }

  Future<User?> getUserById() async {
    String? userId = await SharedPrefs.getUserId();

    final response = await http.get(Uri.parse("https://ecommerceamozonclone.vercel.app/api/users/$userId"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);

      try {
        return User.fromJson(data);  // This will use the updated factory constructor
      } catch (e) {
        print("Error parsing user data: $e");
        return null;  // Or handle the error as required
      }
    } else {
      print("Error: ${response.statusCode}");
      return null;  // Or handle the error as required
    }
  }


  Future<List<User>> getAllUsers() async {
    final response = await http.get(Uri.parse("$baseUrl/users"));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((user) => User.fromJson(user)).toList();
    }
    return [];
  }

  Future<User?> updateUser( Map<String, dynamic> updatedData) async {
    final response = await http.put(
      Uri.parse("$baseUrl/users/${SharedPrefs.getUserId()}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(updatedData),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data["user"]);
    }
    return null;
  }
}
