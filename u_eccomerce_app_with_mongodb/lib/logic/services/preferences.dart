import 'package:shared_preferences/shared_preferences.dart';

class Preferences {


  static Future<void> saveUserDetails(String email, String password) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
    print("Preferences saved");
  }

  static Future<Map<String, String>> fetchUserDetails() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {"email": prefs.getString('email') ?? "", "password": prefs.getString('password') ?? ""};
  }

  static Future<void> clear() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    print("Preferences cleared");

  }


}