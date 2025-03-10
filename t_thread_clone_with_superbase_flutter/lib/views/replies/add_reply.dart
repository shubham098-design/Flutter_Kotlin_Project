import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_thread_clone_with_superbase_flutter/controller/reply_controller.dart';
import 'package:t_thread_clone_with_superbase_flutter/models/post_model.dart';
import 'package:t_thread_clone_with_superbase_flutter/services/supabase_service.dart';

import '../../widget/image_circle.dart';
import '../../widget/post_card_image.dart';

class AddReply extends StatelessWidget {
  AddReply({super.key});

  final PostModel post = Get.arguments;
  final ReplyController replyController = Get.put(ReplyController());
  final SupabaseServices supabaseServices = Get.find<SupabaseServices>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Reply"),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.close),
        ),
        actions: [
          Obx(
            () => TextButton(
              onPressed: () {
                if (replyController.reply.isNotEmpty) {
                  replyController.addReply(
                    supabaseServices.currentUser.value!.id,
                    post.id!,
                    post.userId!,
                  );
                }
              },
              child:
                  replyController.loading.value
                      ? SizedBox(height : 16, width: 16,child: CircularProgressIndicator())
                      : Text(
                        "Reply",
                        style: TextStyle(
                          fontWeight:
                              replyController.reply.isNotEmpty
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                        ),
                      ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: context.width * 0.12,
                  child: ImageCircle(url: post.user?.metadata?.image),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: context.width * 0.80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.user!.metadata!.name!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(post.content!),
                      const SizedBox(height: 10),
                      if (post.image != null) PostCardImage(url: post.image!),

                      // Reply Text field
                      TextField(
                        autofocus: true,
                        onChanged: (value) {
                          replyController.reply.value = value;
                        },
                        controller: replyController.replyController,
                        decoration: InputDecoration(
                          hintText: "type a reply",
                          border: InputBorder.none,
                        ),
                        maxLines: 10,
                        minLines: 1,
                        maxLength: 1000,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
