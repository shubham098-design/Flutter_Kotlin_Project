import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {

  late String uuidKey;

  Future<void> saveUuid(String uuid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uuid_key', uuid);
  }

  Future<String?> getUuid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('uuid_key');
  }

}



// await saveUuid("123e4567-e89b-12d3-a456-426614174000");
//
// String? storedUuid = await getUuid();
// print("Stored UUID: $storedUuid");