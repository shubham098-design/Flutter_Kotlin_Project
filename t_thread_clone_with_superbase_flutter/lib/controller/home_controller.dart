
import 'package:get/get.dart';
import 'package:t_thread_clone_with_superbase_flutter/services/supabase_service.dart';

import '../models/post_model.dart';
import '../models/user_model.dart';

class HomeController extends GetxController{
  var loading = false.obs;

  RxList<PostModel> posts = RxList<PostModel>();

  @override
  void onInit() async{
    await fetchTreads();
    listenPostChange();
    super.onInit();
  }

  Future<void> fetchTreads() async {
    try{
      loading.value = true;
      final List<dynamic> responce = await SupabaseServices.client.from("posts").select('''
      id ,content , image ,created_at ,comment_count , like_count,user_id,
      user:user_id (email , metadata) , likes:likes (user_id ,post_id)
      ''').order("id", ascending: false);

      print(responce);

      if(responce.isNotEmpty){
        posts.value = [for(var item in responce) PostModel.fromJson(item)];
      }
      loading.value = false;

    }catch(e){
      loading.value = false;
      print("Error fetching threads: $e");
    }
  }

// * Listen post changes
  void listenPostChange() {
    // SupabaseServices.client.channel('public:posts').on(
    //   RealtimeListenTypes.postgresChanges,
    //   ChannelFilter(event: 'INSERT', schema: 'public', table: 'posts'),
    //       (payload, [ref]) {
    //     final PostModel post = PostModel.fromJson(payload["new"]);
    //     updateFeed(post);
    //   },
    // ).on(
    //   RealtimeListenTypes.postgresChanges,
    //   ChannelFilter(event: 'DELETE', schema: 'public', table: 'posts'),
    //       (payload, [ref]) {
    //     posts.removeWhere((element) => element.id == payload["old"]["id"]);
    //   },
    // ).subscribe();
  }

  // * update the home feed
  void updateFeed(PostModel post) async {
    var user = await SupabaseServices.client
        .from("users")
        .select("*")
        .eq("id", post.userId!)
        .single();

    // * Fetch likes
    post.likes = [];
    post.user = UserModel.fromJson(user);
    posts.insert(0, post);
  }

}