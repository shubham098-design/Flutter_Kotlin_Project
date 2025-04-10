
import 'package:get_storage/get_storage.dart';
import 'package:r_goldsmith_shop_flutter/user/utils/storage_key.dart';

class StorageService {

  static final session = GetStorage();
  static dynamic userSession = session.read(StorageKeys.userSession);

}