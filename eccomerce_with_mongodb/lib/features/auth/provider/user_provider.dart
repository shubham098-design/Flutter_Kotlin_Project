import 'package:flutter/material.dart';
import '../../../models/user.dart';
import '../services/user_service.dart';
import '../shared_pref/shared_prefs.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();
  User? _user;
  String? _userId;
  bool _isLoading = false;

  User? get user => _user;
  String? get userId => _userId;
  bool get isLoading => _isLoading;


  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loadUserId() async {
    _setLoading(true);
    _userId = await SharedPrefs.getUserId();
    _setLoading(false);
    notifyListeners();
  }


  Future<bool> signup(String name, String email, String password,BuildContext context) async {
    _setLoading(true);
    String? userId = await UserService.signup(name, email, password,context);
    _setLoading(false);

    if (userId != null) {
      _userId = userId;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> login(String email, String password,BuildContext context) async {
    _setLoading(true);
    String? userId = await _userService.login(email, password, context);
    _setLoading(false);

    if (userId != null) {
      _userId = userId;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _setLoading(true);
    await _userService.logout();
    _user = null;
    _userId = null;
    _setLoading(false);
    notifyListeners();
  }

  // Method to fetch user details
  Future<void> fetchUserDetails() async {
    _user = await UserService().getUserById();  // Assuming UserService has getUserById method
    notifyListeners();
  }

  Future<List<User>> getAllUsers() async {
    _setLoading(true);
    List<User> users = await _userService.getAllUsers();
    _setLoading(false);
    return users;
  }

  Future<bool> updateUser(Map<String, dynamic> updatedData) async {
    _setLoading(true);
    User? updatedUser = await _userService.updateUser( updatedData);
    _setLoading(false);

    if (updatedUser != null) {
      _user = updatedUser;
      notifyListeners();
      return true;
    }
    return false;
  }
}
