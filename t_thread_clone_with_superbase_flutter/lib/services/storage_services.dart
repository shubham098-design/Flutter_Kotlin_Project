import 'package:get_storage/get_storage.dart';

import '../utils/storage_key.dart';

class StorageServices {

  static final session = GetStorage();
  static dynamic userSession = session.read(StorageKeys.userSession);
}