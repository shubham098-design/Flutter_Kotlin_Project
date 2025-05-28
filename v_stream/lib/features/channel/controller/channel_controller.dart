import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:v_stream/features/auth/model/user_model.dart';

import '../../../services/supabase_services.dart';
import '../../home/model/video_model.dart';

class ChannelController extends GetxController {
  var videosList = <Video>[].obs;
  var isGettingVideos = false.obs;


  Future<void> getUserByIdVideos(String userId) async {
    try {
      isGettingVideos.value = true;

      final response = await SupabaseServices.supabaseClient
          .from('videos')
          .select()
          .eq('user_id', userId)
          .eq('video_type', 'video')
          .order('created_at', ascending: false);


      List<Video> fetchedVideos = [];

      for (var videoJson in response) {
        Video video = Video.fromJson(videoJson);

        final userResponse = await SupabaseServices.supabaseClient
            .from('users')
            .select()
            .eq('user_id', userId,)
            .maybeSingle();

        if (userResponse != null) {
          video.user = UserModel.fromJson(userResponse);
        }

        fetchedVideos.add(video);
      }

      videosList.value = fetchedVideos;

      print("Videos List: ---------------------------------> ${videosList.first}");

      isGettingVideos.value = false;
    } on AuthException catch (e) {
      print("Auth Error: ${e.message}");
      isGettingVideos.value = false;
    } catch (e) {
      print("General Error: $e");
      isGettingVideos.value = false;
    }
  }

  var shortsList = <Video>[].obs;
  var isGettingShorts = false.obs;

  Future<void> getUserByIdShort(String userId) async {
    try {
      isGettingShorts.value = true;

      final response = await SupabaseServices.supabaseClient
          .from('videos')
          .select()
          .eq('user_id', userId)
          .eq('video_type', 'short')
          .order('created_at', ascending: false);


      List<Video> fetchedVideos = [];

      for (var videoJson in response) {
        Video video = Video.fromJson(videoJson);

        final userResponse = await SupabaseServices.supabaseClient
            .from('users')
            .select()
            .eq('user_id', userId)
            .maybeSingle();

        if (userResponse != null) {
          video.user = UserModel.fromJson(userResponse);
        }

        fetchedVideos.add(video);
      }

      shortsList.value = fetchedVideos;

      isGettingShorts.value = false;
    } on AuthException catch (e) {
      print("Auth Error: ${e.message}");
      isGettingShorts.value = false;
    } catch (e) {
      print("General Error: $e");
      isGettingShorts.value = false;
    }
  }



}

