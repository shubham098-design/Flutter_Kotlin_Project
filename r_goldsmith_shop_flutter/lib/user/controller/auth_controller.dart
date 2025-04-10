import 'dart:io';

import 'package:get/get.dart';
import 'package:r_goldsmith_shop_flutter/admine/models/user_model.dart';
import 'package:r_goldsmith_shop_flutter/user/services/shared_pref_services.dart';
import 'package:r_goldsmith_shop_flutter/user/services/storage_service.dart';
import 'package:r_goldsmith_shop_flutter/user/utils/storage_key.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../admine/utils/helper.dart';
import '../route/routes.dart';
import '../services/supabase_services.dart';

class AuthController extends GetxController{
  SharedPrefServices sharedPrefServices = SharedPrefServices();

  var loginLoading = false.obs;
  var signupLoading = false.obs;
  var logoutLoading = false.obs;
  var updateProfileLoading = false.obs;
  var getUserDataLoading = false.obs;
  var getUserDataByLoading = false.obs;
  Rx<File?> image = Rx<File?>(null);
  Rx<UserModel?> user = Rx<UserModel?>(null);
  var updateButton = false.obs;

  @override
  void onInit() {
    getUserDataBy();
    super.onInit();
  }

  Future<void> login(String email, String password) async{
    try{
      loginLoading.value = true;
      final AuthResponse response =await SupabaseServices.supabaseClient.auth.signInWithPassword(email: email, password: password);
      loginLoading.value = false;
      if(response.user != null){
        StorageService.session.write(StorageKeys.userSession, response.user!.toJson());
        Get.offAllNamed(RoutesName.bottomNavigation);
      }
    } on AuthException catch(e){
      loginLoading.value = false;
    }
  }
  Future<void> signup(String name, String email, String password) async {
    try {
      signupLoading.value = true;
      final AuthResponse response = await SupabaseServices.supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      signupLoading.value = false;

      if (response.user != null) {
        final String? userId = response.user?.id; // User ka UUID
        await Supabase.instance.client.from('user_table').insert({
          'user_id': userId, // Store UUID
          'email': email,
          'name': name,
        });
        final responseForId =await SupabaseServices.supabaseClient.from('user_table').select('id').eq('user_id', userId!).limit(1);
            if (responseForId.isNotEmpty) {
              final id = responseForId[0]['id'] as int;
              sharedPrefServices.saveUserId(id);
            } else {
              print("no id found");
            }

        StorageService.session.write(StorageKeys.userSession, response.user!.toJson());
        Get.offAllNamed(RoutesName.bottomNavigation);
      }
    } on AuthException catch (e) {
      signupLoading.value = false;
      print("Error: ${e.message}");
      Get.snackbar("Error", e.message);
    }
  }


  Future<void> updateProfile(String name ,String phone , String address) async{
    try{
      var image_url = "";
      var dir = 'profile/$name';
      updateProfileLoading.value = true;
      if(image.value != null && image.value!.existsSync() ){
        await SupabaseServices.supabaseClient.storage.from('bucket').upload(dir, image.value!,fileOptions: const FileOptions(upsert: true));
        image_url = SupabaseServices.supabaseClient.storage.from('bucket')
            .getPublicUrl(dir);
      }
      await SupabaseServices.supabaseClient.from('user_table')
          .update({
        if (name.isNotEmpty) 'name': name,
        if (phone.isNotEmpty) 'phone': phone,
        if (address.isNotEmpty) 'address': address,
        'role': "User",
        if (image_url.isNotEmpty) 'image_url': image_url
      }).eq('id', sharedPrefServices.getUserId()).then((value){
        updateProfileLoading.value = false;
        Get.snackbar("Success", "Profile updated successfully");
        getUserDataBy();
      });

    }on AuthException catch(e){
      print("Error: ${e.message}");
      updateProfileLoading.value = false;
    }on StorageException catch(e){
      print("Error: ${e.message}");
      updateProfileLoading.value = false;
    }on Exception catch(e){
      print("Error: $e");
      updateProfileLoading.value = false;
    }
  }
  Future<void> logout() async{
    try{
      logoutLoading.value = true;
      await SupabaseServices.supabaseClient.auth.signOut().then((value) {
        logoutLoading.value = false;
        sharedPrefServices.clearUserId();
        StorageService.session.remove(StorageKeys.userSession);
        Get.snackbar("Success", "Logged out successfully");
        Get.offAllNamed(RoutesName.login);
      });
    } on AuthException catch(e){
      logoutLoading.value = false;
      Get.snackbar("Error", e.message);
    }
  }

  void imagePick() async{
    File? file = await pickImageFromGallery();
    if(file != null){
      image.value = file;
    }
  }


  Future<void> getUserData() async{
    try{
      getUserDataLoading.value = true;
      final response = await SupabaseServices.supabaseClient.from('user_table').select();
      if(response.isEmpty){
        throw Exception("No user found");
      }
      getUserDataLoading.value = false;
      Get.snackbar("Success", "User data fetched successfully");
    }on AuthException catch(e){
      getUserDataLoading.value = false;
      print("Error: ${e.message}");

    }on StorageException catch(e){
      getUserDataLoading.value = false;
      print("Error: ${e.message}");

    }on Exception catch(e){
      getUserDataLoading.value = false;
      print("Error: $e");

    }
  }

  Future<void> getUserDataBy() async {
    try {
      getUserDataByLoading.value = true;
      final response = await SupabaseServices.supabaseClient.from('user_table')
          .select().eq('id', sharedPrefServices.getUserId())
          .single();
      user.value = UserModel.fromJson(response);
      if (response.isEmpty) {
        throw Exception("No user found");
      }
      getUserDataByLoading.value = false;
    } on AuthException catch (e) {
      getUserDataByLoading.value = false;
      print("Error: ${e.message}");

    } on StorageException catch (e) {
      getUserDataByLoading.value = false;
      print("Error: ${e.message}");

    } on Exception catch (e) {
      getUserDataByLoading.value = false;
      print("Error: $e");
    }
  }
}