import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:v_stream/features/auth/model/user_model.dart';
import 'package:v_stream/features/home/model/comment_model.dart';

import '../../../services/supabase_services.dart';
import '../model/video_model.dart';

class HomeController extends GetxController {
  var videosList = <Video>[].obs;
  var isGettingVideos = false.obs;
  final Rxn<Video> selectedVideo = Rxn<Video>();


  Future<void> getVideos() async {
    try {
      isGettingVideos.value = true;

      final response = await SupabaseServices.supabaseClient
          .from('videos')
          .select()
          .eq('video_type', 'video')
          .order('created_at', ascending: false);

      print("Videos Response: $response");

      List<Video> fetchedVideos = [];

      for (var videoJson in response) {
        Video video = Video.fromJson(videoJson);

        //  User ka data fetch karo using video.userId
        final userResponse = await SupabaseServices.supabaseClient
            .from('users')
            .select()
            .eq('user_id', video.userId)
            .maybeSingle();

        if (userResponse != null) {
          video.user = UserModel.fromJson(userResponse);
        }

        fetchedVideos.add(video);
      }

      videosList.value = fetchedVideos;

      isGettingVideos.value = false;
    } on AuthException catch (e) {
      print("Auth Error: ${e.message}");
      isGettingVideos.value = false;
    } catch (e) {
      print("General Error: $e");
      isGettingVideos.value = false;
    }
  }

  var shortList = <Video>[].obs;
  var isGettingShorts = false.obs;

  Future<void> getShorts() async {
    try {
      isGettingShorts.value = true;

      final response = await SupabaseServices.supabaseClient
          .from('videos')
          .select()
          .eq('video_type', 'short')
          .order('created_at', ascending: false);

      List<Video> fetchedVideos = [];

      for (var videoJson in response) {
        Video video = Video.fromJson(videoJson);

        //  User ka data fetch karo using video.userId
        final userResponse = await SupabaseServices.supabaseClient
            .from('users')
            .select()
            .eq('user_id', video.userId)
            .maybeSingle();

        if (userResponse != null) {
          video.user = UserModel.fromJson(userResponse);
        }

        fetchedVideos.add(video);
      }

      shortList.value = fetchedVideos;
      isGettingShorts.value = false;
    } on AuthException catch (e) {
      print("Auth Error: ${e.message}");
      isGettingShorts.value = false;
    } catch (e) {
      print("General Error: $e");
      isGettingShorts.value = false;
    }
  }



  var specificUserChannelVideosList = <Video>[].obs;
  var isSpecificUserChannelGettingVideos = false.obs;
  Future<void> getSpecificUserChannelVideos(String userId) async {
    try {
      isSpecificUserChannelGettingVideos.value = true;

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
            .eq('user_id', userId)
            .maybeSingle();

        if (userResponse != null) {
          video.user = UserModel.fromJson(userResponse);
        }

        fetchedVideos.add(video);
      }

      specificUserChannelVideosList.value = fetchedVideos;

      isSpecificUserChannelGettingVideos.value = false;
    } on AuthException catch (e) {
      print("Auth Error: ${e.message}");
      isSpecificUserChannelGettingVideos.value = false;
    } catch (e) {
      print("General Error: $e");
      isSpecificUserChannelGettingVideos.value = false;
    }
  }

  var specificUserChannelShortsList = <Video>[].obs;
  var isSpecificUserChannelGettingShorts = false.obs;

  Future<void> getSpecificUserChannelShorts(String userId) async {
    try {
      isSpecificUserChannelGettingShorts.value = true;

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

      specificUserChannelShortsList.value = fetchedVideos;

      isSpecificUserChannelGettingShorts.value = false;
    } on AuthException catch (e) {
      print("Auth Error: ${e.message}");
      isSpecificUserChannelGettingShorts.value = false;
    } catch (e) {
      print("General Error: $e");
      isSpecificUserChannelGettingShorts.value = false;
    }
  }


  RxBool isCommentLoading = false.obs;

  Future<void> commentOnVideo(String videoId, String userId,String comment) async {
    try {
      isCommentLoading.value = true;

      final response = await SupabaseServices.supabaseClient
          .from('comment')
          .insert({'video_id': videoId, 'user_id': userId,'comment_text':comment});

      print("Comment Response: $response");
      isCommentLoading.value = false;
    }catch (e) {
      print("General Error: $e");
      isCommentLoading.value = false;
    }
  }


  RxBool isGettingComments = false.obs;
  RxList<CommentModel> comments = <CommentModel>[].obs;

  Future<void> getComments(String videoId) async {
    try {
      isGettingComments.value = true;

      final response = await SupabaseServices.supabaseClient
          .from('comment')
          .select()
          .eq('video_id', videoId);
      print("Comments Response: $response");

      comments.assignAll(
          (response as List).map((json) => CommentModel.fromJson(json)).toList()
      );

    } catch (e) {
      print("General Error: $e");
    } finally {
      isGettingComments.value = false;
    }
  }

}

