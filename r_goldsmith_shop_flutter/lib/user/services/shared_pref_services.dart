import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices {
  static late SharedPreferences _prefs;

  /// App start hone par initialize karein
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save user ID
  void saveUserId(int userId) {
    _prefs.setInt('USER_ID', userId);
  }

  /// Directly integer return karega, async nahi hoga
  int getUserId() {
    return _prefs.getInt('USER_ID') ?? -1;  // Default value -1 rakhi hai
  }

  /// Clear user ID
  void clearUserId() {
    _prefs.remove('USER_ID');
  }
}
