import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:t_thread_clone_with_superbase_flutter/services/storage_services.dart';
import 'package:t_thread_clone_with_superbase_flutter/utils/helper.dart';

import '../routes/routes_name.dart';
import '../services/supabase_service.dart';
import '../utils/storage_key.dart';

class AuthController extends GetxController{

  var registerLoading = false.obs;
  var loginLoading = false.obs;

  Future<void> register(String name,String email, String password) async{
    try{
      registerLoading.value = true;
      final AuthResponse data = await SupabaseServices.client.auth.signUp(email: email, password: password, data: {'name':name});
      registerLoading.value = false;
      if(data.user != null){
        StorageServices.session.write(StorageKeys.userSession, data.session!.toJson());
        Get.offAllNamed(RouteName.home);
      }

    } on AuthException catch(e){
      registerLoading.value = false;
      showSnackBar("Error", e.message);
    }

  }

  Future<void> login(String email, String password) async{
    try{
      loginLoading.value = true;
      final AuthResponse data = await SupabaseServices.client.auth.signInWithPassword(email: email, password: password);
      loginLoading.value = false;
      if(data.user != null){
        StorageServices.session.write(StorageKeys.userSession, data.session!.toJson());
        Get.offAllNamed(RouteName.home);
      }
    } on AuthException catch(e){
      loginLoading.value = false;
      showSnackBar("Error", e.message);
    }
  }
}