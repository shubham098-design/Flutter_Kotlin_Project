import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:t_thread_clone_with_superbase_flutter/routes/routes_name.dart';
import 'package:t_thread_clone_with_superbase_flutter/services/storage_services.dart';
import 'package:t_thread_clone_with_superbase_flutter/services/supabase_service.dart';

import '../utils/storage_key.dart';

class SettingController extends GetxController{
  void logout() async{
    // * remove user from session from local storage
    StorageServices.session.remove(StorageKeys.userSession);
    await SupabaseServices.client.auth.signOut();
    Get.offAllNamed(RouteName.login);
  }
}