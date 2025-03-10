import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:t_thread_clone_with_superbase_flutter/models/comment_model.dart';
import 'package:t_thread_clone_with_superbase_flutter/utils/env.dart';

import '../models/post_model.dart';
import '../models/user_model.dart';
import '../services/supabase_service.dart';
import '../utils/helper.dart';

class ProfileController extends GetxController {
  var loading = false.obs;
  Rx<File?> image = Rx<File?>(null);
  var postLoading = false.obs;

  RxList<PostModel> posts = RxList<PostModel>();
  var replyLoading = false.obs;
  RxList<CommentModel> replies = RxList<CommentModel>();

  var userLoading = false.obs;
  Rx<UserModel?> user = Rx<UserModel?>(null);


  void pickImage() async {
    File? file = await pickImageFromGallery();
    if (file != null) {
      image.value = file;
    }
  }

  //* Update profile

  Future<void> updateProfile(String userId, String description) async {
    try {
      loading.value = true;
      var uploadedPath = "";
      if (image.value != null && image.value!.existsSync()) {
        final String dir = "$userId/profile.jpg";
        var path = await SupabaseServices.client.storage
            .from(Env.s3Bucket)
            .upload(dir, image.value!, fileOptions: FileOptions(upsert: true));
        uploadedPath = path;
      }

      // * update profile
      await SupabaseServices.client.auth.updateUser(
        UserAttributes(
          data: {
            "description": description,
            "image": uploadedPath.isNotEmpty ? uploadedPath : null,
          },
        ),
      );
      loading.value = false;
      Get.back();
      showSnackBar("Success", "Profile Updated Successfully");
    } on StorageException catch (e) {
      loading.value = false;
      showSnackBar("Error", e.message);
    } on AuthException catch (e) {
      loading.value = false;
      showSnackBar("Error", e.message);
    } catch (e) {
      loading.value = false;
      showSnackBar("Error", e.toString());
    }
  }

  // * Fetch Post

  void fetchUserThreads(String userId) async {
    try {
      postLoading.value = true;
      final List<dynamic> responce = await SupabaseServices.client
          .from("posts")
          .select('''
      id ,content , image ,created_at ,comment_count , like_count,user_id,
      user:user_id (email , metadata) , likes:likes (user_id ,post_id)
      ''')
          .eq("user_id", userId)
          .order("id", ascending: false);

      if (responce.isNotEmpty) {
        posts.value = [for (var item in responce) PostModel.fromJson(item)];
      }
      postLoading.value = false;
      print("The post responce is ${jsonEncode(responce)}");
    } catch (e) {
      postLoading.value = false;
      print("Error fetching threads: $e");
      showSnackBar("Error", e.toString());
    }
  }

  // * Fetch Replay

  void fetchReplies(String userId) async {
    try {
      replyLoading.value = true;
      final List<dynamic> responce = await SupabaseServices.client
          .from("comments")
          .select('''
          user_id , post_id , reply , created_at , user:user_id (email , metadata)
          ''')
          .eq("user_id", userId)
          .order("id", ascending: false);
      if (responce.isNotEmpty) {
        replies.value = [
          for (var item in responce) CommentModel.fromJson(item),
        ];
      }
      replyLoading.value = false;
      print("The comment responce is ${jsonEncode(responce)}");
    } catch (e) {
      replyLoading.value = false;
      showSnackBar("Error", e.toString());
    }
  }

  // * get user
  Future<void> getUser(String userId) async {
    userLoading.value = true;
    var data = await SupabaseServices.client
        .from("users")
        .select("*")
        .eq("id", userId)
        .single();
    userLoading.value = false;
    user.value = UserModel.fromJson(data);

    // * Fetch posts and comments
    fetchUserThreads(userId);
    fetchReplies(userId);
  }


  // * Delete thread
  Future<void> deleteThread(int postId) async {
    try {
      await SupabaseServices.client.from("posts").delete().eq("id", postId);

      posts.removeWhere((element) => element.id == postId);
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      showSnackBar("Success", "thread deleted successfully!");
    } catch (e) {
      showSnackBar("Error", "Something went wrong.pls try again.");
    }
  }

  // * Delete thread
  Future<void> deleteReply(int replyId) async {
    try {
      await SupabaseServices.client.from("comments").delete().eq("id", replyId);

      replies.removeWhere((element) => element.id == replyId);
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      showSnackBar("Success", "Reply deleted successfully!");
    } catch (e) {
      showSnackBar("Error", "Something went wrong.pls try again.");
    }
  }
}
