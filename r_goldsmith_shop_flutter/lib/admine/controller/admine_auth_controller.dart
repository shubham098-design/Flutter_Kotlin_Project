import 'package:get/get.dart';
import 'package:r_goldsmith_shop_flutter/admine/route/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../user/route/routes.dart';
import '../../user/services/storage_service.dart';
import '../../user/services/supabase_services.dart';
import '../../user/utils/storage_key.dart';

class AdmineAuthController extends GetxController{

  var loginLoading = false.obs;
  var signupLoading = false.obs;
  var logoutLoading = false.obs;

  Future<void> login(String email, String password) async{
    try{
      loginLoading.value = true;
      final AuthResponse response =await SupabaseServices.supabaseClient.auth.signInWithPassword(email: email, password: password);
      loginLoading.value = false;
      if(response.user != null){
        StorageService.session.write(StorageKeys.userSession, response.user!.toJson());
        Get.offAllNamed(AdmineRouteNames.mob_dashboard_screen);
      }
    } on AuthException catch(e){
      loginLoading.value = false;
      Get.snackbar("Error", e.message);
    }
  }
  Future<void> signup(String name , String email , String password) async{
    try{
      signupLoading.value = true;
      final AuthResponse response =await SupabaseServices.supabaseClient.auth.signUp(email: email, password: password, data: {'name':name});
      signupLoading.value = false;
      if(response.user != null){

        /// store the user data in the sup-abase database
        await Supabase.instance.client.from('user_table').insert({'email': email, 'name': name, 'password': password,});

        StorageService.session.write(StorageKeys.userSession, response.user!.toJson());
        Get.offAllNamed(AdmineRouteNames.mob_dashboard_screen);
      }
    } on AuthException catch(e){
      signupLoading.value = false;
      Get.snackbar("Error", e.message);
    }
  }

  Future<void> logout() async{
    try{
      logoutLoading.value = true;
      await SupabaseServices.supabaseClient.auth.signOut().then((value) {
        logoutLoading.value = false;

        Get.offAllNamed(AdmineRouteNames.mob_onboarding_screen);
      });
    } on AuthException catch(e){
      logoutLoading.value = false;
      Get.snackbar("Error", e.message);
    }
  }


}