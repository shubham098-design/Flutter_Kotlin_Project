import 'dart:io';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../services/supabase_services.dart';
import '../../home/model/video_model.dart';

class AddController extends GetxController {
  RxBool isVideoUploading = false.obs;


  Future<void> uploadVideo(
      String title,
      String description,
      String category,
      String duration,
      String videoType,
      File videoFile,
      File thumbnail,
      ) async {
    try {
      isVideoUploading.value = true;
      final userId = SupabaseServices.supabaseClient.auth.currentUser?.id;
      if (userId == null) {
        print("User not logged in");
        return;
      }

      final now = DateTime.now().millisecondsSinceEpoch;
      final thumbnailPath = 'videos/$userId/thumbnail_$now.jpg';
      final videoPath = 'videos/$userId/video_$now.mp4';

      // Upload Thumbnail
      await SupabaseServices.supabaseClient.storage
          .from('bucket')
          .upload(
        thumbnailPath,
        thumbnail,
        fileOptions: const FileOptions(upsert: true),
      );

      // Upload Video
      await SupabaseServices.supabaseClient.storage
          .from('bucket')
          .upload(
        videoPath,
        videoFile,
        fileOptions: const FileOptions(
          upsert: true,
          contentType: 'video/mp4',
        ),
      );

      // Get public URLs
      final imageUrl = SupabaseServices.supabaseClient.storage
          .from('bucket')
          .getPublicUrl(thumbnailPath);

      final videoUrl = SupabaseServices.supabaseClient.storage
          .from('bucket')
          .getPublicUrl(videoPath);

      print("Image URL: $imageUrl");
      print("Video URL: $videoUrl");

      // Insert video data into Supabase
      final response = await SupabaseServices.supabaseClient
          .from('videos')
          .insert({
        'title': title,
        'description': description,
        'user_id': userId,
        'video_url': videoUrl,
        'thumbnail_url': imageUrl,
        'like_count': 0,
        'dislike_count': 0,
        'category': category,
        'duration': duration,
        'video_type': videoType,
        'view_count': 0,
      }).select();

      print("Inserted Data: $response");
      Get.snackbar("Success", "Video uploaded successfully!");
      isVideoUploading.value = false;
    } on StorageException catch (e) {
      print("Storage Error: ${e.message}");
      isVideoUploading.value = false;
    } on AuthException catch (e) {
      print("Auth Error: ${e.message}");
      isVideoUploading.value = false;
    } catch (e) {
      print("General Error: $e");
      isVideoUploading.value = false;
    }
  }

}
