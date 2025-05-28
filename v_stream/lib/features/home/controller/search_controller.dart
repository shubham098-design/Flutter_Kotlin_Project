import 'package:get/get.dart';
import 'package:v_stream/features/auth/model/user_model.dart';
import 'package:v_stream/features/home/model/video_model.dart';
import '../../../services/supabase_services.dart';

class SearchingController extends GetxController {
  var allShorts = <Video>[].obs;
  var searchResults = <Video>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchShorts(); // Load all shorts initially
  }

  Future<void> fetchShorts() async {
    try {
      isLoading.value = true;

      final response = await SupabaseServices.supabaseClient
          .from('videos')
          .select()
          .eq('video_type', 'short')
          .order('created_at', ascending: false);

      List<Video> loadedShorts = [];

      for (var videoJson in response) {
        final video = Video.fromJson(videoJson);

        final userResponse = await SupabaseServices.supabaseClient
            .from('users')
            .select()
            .eq('user_id', video.userId)
            .maybeSingle();

        if (userResponse != null) {
          video.user = UserModel.fromJson(userResponse);
        }

        loadedShorts.add(video);
      }

      allShorts.assignAll(loadedShorts);
      searchResults.assignAll(loadedShorts); // Default display
    } catch (e) {
      print('Error fetching shorts: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      searchResults.assignAll(allShorts);
    } else {
      final lowerQuery = query.toLowerCase();
      final filtered = allShorts.where((video) {
        final title = video.title?.toLowerCase() ?? '';
        final desc = video.description?.toLowerCase() ?? '';
        return title.contains(lowerQuery) || desc.contains(lowerQuery);
      }).toList();

      searchResults.assignAll(filtered);
    }
  }
}
