import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:t_thread_clone_with_superbase_flutter/services/supabase_service.dart';
import 'package:t_thread_clone_with_superbase_flutter/utils/helper.dart';

class ReplyController extends GetxController{
  final TextEditingController replyController = TextEditingController(text: "");
  var loading = false.obs;
  var reply = "".obs;

  @override
  void onClose() {
    replyController.dispose();
        super.onClose();
  }
  
  void addReply(String userId,int postId,String postUserId) async {
    try{
      loading.value = true;
      // * increase the post comment count
      await SupabaseServices.client.rpc("comment_increment",params: {"count" :1, "row_id" : postId});

      // * Add Notification
      await SupabaseServices.client.from("notifications").insert({
        "user_id" :userId,
        "notification" : "commented on your post",
        "to_user_id" : postUserId,
        "post_id" : postId
      });

      // * Add comment in table
      await SupabaseServices.client.from("comments").insert({
        "post_id" : postId,
        "user_id" : userId,
        "reply" : replyController.text
      });

      loading.value = false;
      showSnackBar("Success", "Replied successfully");
      Get.back();
    }catch(e){
      loading.value = false;
      print(e.toString());
      showSnackBar("Error", e.toString());

    }
  }

}