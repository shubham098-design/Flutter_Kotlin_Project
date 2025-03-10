import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:t_thread_clone_with_superbase_flutter/controller/thread_controller.dart';
import 'package:t_thread_clone_with_superbase_flutter/widget/loading.dart';
import 'package:t_thread_clone_with_superbase_flutter/widget/post_card.dart';
import 'package:t_thread_clone_with_superbase_flutter/widget/reply_card.dart';

class ShowThread extends StatefulWidget {
  const ShowThread({super.key});

  @override
  State<ShowThread> createState() => _ShowThreadState();
}

class _ShowThreadState extends State<ShowThread> {
  final int postId = Get.arguments;
  final ThreadController threadController = Get.put(ThreadController());

  @override
  void initState() {
    threadController.show(postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Show Thread ")),
      body: Obx(
        () =>
            threadController.showThreadLoading.value
                ? const Loading()
                : SingleChildScrollView(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      PostCard(post: threadController.post.value),
                      const SizedBox(height: 20),

                      // * Load post replies
                      if (threadController.showReplyLoading.value)
                        const Loading()
                      else if (threadController.replies.isNotEmpty)
                        ListView.builder(
                          itemCount: threadController.replies.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            ReplyCard(replay: threadController.replies[index]);
                          },
                        ),
                    ],
                  ),
                ),
      ),
    );
  }
}
