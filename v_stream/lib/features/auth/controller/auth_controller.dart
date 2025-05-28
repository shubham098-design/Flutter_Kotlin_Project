import 'dart:io';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:v_stream/services/supabase_services.dart';

import '../../../route/routes_name.dart';
import '../../../services/shared_preferences.dart';
import '../model/user_model.dart';

class AuthController extends GetxController {
  SharedPreferencesService sharedPreferencesService = SharedPreferencesService();
  RxBool isLoggedIn = false.obs;
  RxBool isSigningUp = false.obs;
  RxBool isGettingUser = false.obs;
  RxBool isUpdatingProfile = false.obs;
  Rx<File?> image = Rx<File?>(null);
  UserModel? userModel;

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  Future<void> login(String email, String password) async {
    try {
      isLoggedIn.value = true;
      final AuthResponse authResponse = await SupabaseServices
          .supabaseClient
          .auth
          .signInWithPassword(email: email, password: password);
      if (authResponse.user != null) {
        isLoggedIn.value = false;
        await sharedPreferencesService.saveUuid(authResponse.user!.id);
        Get.offAllNamed(RoutesName.bottom_navigation_bar_route);
      }

      print(
        "Shared Pref Uuid : -----------------------------> ${sharedPreferencesService.getUuid()}",
      );
    } on AuthException catch (e) {
      isLoggedIn.value = false;
      print(e);
    } catch (e) {
      isLoggedIn.value = false;
      print(e);
    }
  }

  Future<void> signUp(
    String username,
    String email,
    String password,
    String phone,
  ) async {
    try {
      isSigningUp.value = true;

      // Step 1: Create user (without metadata)
      final AuthResponse authResponse = await SupabaseServices
          .supabaseClient
          .auth
          .signUp(email: email, password: password);
      print("User: ${authResponse.user}");
      print("Session: ${authResponse.session}");

      print("Sign Up Success: ${authResponse.user?.id}");

      if (authResponse.user != null) {
        final userId = authResponse.user!.id;

        await SupabaseServices.supabaseClient.from('users').insert({
          'username': username,
          'email': email,
          'password': password,
          'phone': phone,
          'user_id': userId,
        });
        print("Insert Success: $userId");

        await sharedPreferencesService.saveUuid(userId);

        isSigningUp.value = false;
        Get.offAllNamed(RoutesName.bottom_navigation_bar_route);
      }
    } on AuthException catch (e) {
      isSigningUp.value = false;
      print("SignUp Error: ${e.message}");
    } catch (e) {
      isSigningUp.value = false;
      print("General Error: $e");
    }
  }

  Future<void> getUser() async {
    try {
      isGettingUser.value = true;

      final userId =
          SupabaseServices
              .supabaseClient
              .auth
              .currentUser
              ?.id; // this is return uuid type not string

      print("Current user ID: $userId");

      if (userId == null) {
        print("No user is logged in.");
        isGettingUser.value = false;
        return;
      }

      final response =
          await SupabaseServices.supabaseClient
              .from('users')
              .select()
              .eq('user_id', userId.toString())
              .single();

      userModel = UserModel.fromJson(response);
      print("User data: $response");
      isGettingUser.value = false;
    } on AuthException catch (e) {
      isGettingUser.value = false;
      print("Auth Error: ${e.message}");
    } catch (e) {
      isGettingUser.value = false;
      print("General Error: $e");
    }
  }

  Future<void> updateProfile(
      String username,
      String? phone,
      String? channel_name,
      String? channel_description,
      File? profilePic,
      ) async {
    isUpdatingProfile.value = true;
    try {
      final userId = SupabaseServices.supabaseClient.auth.currentUser?.id;
      if (userId == null) {
        print("User not logged in");
        return;
      }

      var imageUrl = "";
      final dir = 'profile/$username';

      if (profilePic != null && profilePic.existsSync()) {
        await SupabaseServices.supabaseClient.storage
            .from('bucket')
            .upload(dir, profilePic, fileOptions: const FileOptions(upsert: true));
        imageUrl = SupabaseServices.supabaseClient.storage.from('bucket').getPublicUrl(dir);
      } else {
        imageUrl = userModel?.profilePic ?? "";
      }


      final response = await SupabaseServices.supabaseClient
          .from('users')
          .update({
        'username': username,
        'phone': phone,
        'profile_pic': imageUrl,
        'channel_name': channel_name,
        'channel_description': channel_description,
      })
          .eq("user_id", userId)
          .select();

      // Optionally check if response has error
      print("Update response: $response");

      getUser();

    } on AuthException catch (e) {
      print("Auth Error: ${e.message}");
    } on StorageException catch (e) {
      print("Storage Error: ${e.message}");
    } catch (e) {
      print("General Error: $e");
    } finally {
      isUpdatingProfile.value = false;
    }
  }

}
