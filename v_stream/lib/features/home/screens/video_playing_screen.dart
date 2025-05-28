
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:get/get.dart';
import 'package:v_stream/services/supabase_services.dart';

import '../../../route/routes_name.dart';
import '../controller/home_controller.dart';
import '../helper/home_helper.dart';
import '../model/video_model.dart';
import '../model/video_model.dart' as my_model;
import '../widget/shimmer_video_item.dart';
import '../widget/video_items.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart' as mkit;
import 'package:media_kit_video/media_kit_video.dart';

class VideoPlayingScreen extends StatefulWidget {
  const VideoPlayingScreen({super.key});

  @override
  State<VideoPlayingScreen> createState() => _VideoPlayingScreenState();
}

class _VideoPlayingScreenState extends State<VideoPlayingScreen> {
  final HomeController homeController = Get.find<HomeController>();
  TextEditingController commentController = TextEditingController();
  late final Player player;
  late final VideoController videoController;

  @override
  void initState() {
    super.initState();
    player = Player();
    videoController = VideoController(player);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final my_model.Video video = Get.arguments as my_model.Video;
      homeController.selectedVideo.value = video;
    });
  }

  @override
  void dispose() {
    player.dispose(); // Dispose player
    super.dispose();
  }

  // String? currentVideoUrl;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   player = Player();
  //   videoController = VideoController(player);
  //
  //   // Agar navigate se aya hai to set selected video
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (Get.arguments != null && Get.arguments is my_model.Video) {
  //       final video = Get.arguments as my_model.Video;
  //       homeController.selectedVideo.value = video;
  //     }
  //   });
  //
  //   // Jab selected video change ho, to naya video load karo
  //   ever<my_model.Video?>(homeController.selectedVideo, (newVideo) {
  //     if (newVideo != null && newVideo.videoUrl != currentVideoUrl) {
  //       currentVideoUrl = newVideo.videoUrl;
  //       player.open(Media(newVideo.videoUrl), play: true);
  //     }
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   player.dispose();
  //   super.dispose();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final video = homeController.selectedVideo.value;
        if (video == null) {
          return const Center(child: CircularProgressIndicator());
        }
        player.open(Media(video.videoUrl)); // Load video into player
        return Column(
          children: [
            SizedBox(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: mkit.Video(controller: videoController),
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(10),
                physics: const BouncingScrollPhysics(),
                children: [
                  Text(
                    video.title,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        "${video.viewCount} views",
                        style: const TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        getTimeAgoText(video.createdAt),
                        style: const TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            isScrollControlled: true,
                            builder: (context) {
                              return DraggableScrollableSheet(
                                expand: false,
                                initialChildSize: 0.8,
                                minChildSize: 0.5,
                                maxChildSize: 0.95,
                                builder: (context, scrollController) {
                                  return SingleChildScrollView(
                                    controller: scrollController,
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Container(
                                            width: 50,
                                            height: 5,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[400],
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        const Text(
                                          "Description",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Divider(color: Colors.black54),
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Text("${video.likeCount}", style: const TextStyle(fontSize: 17, color: Colors.black)),
                                                const Text("Likes", style: TextStyle(fontSize: 14, color: Colors.black54)),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text("${video.viewCount}", style: const TextStyle(fontSize: 17, color: Colors.black)),
                                                const Text("Views", style: TextStyle(fontSize: 14, color: Colors.black54)),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(getTimeAgoText(video.createdAt), style: const TextStyle(fontSize: 17, color: Colors.black)),
                                                const Text("Time", style: TextStyle(fontSize: 14, color: Colors.black54)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Text(video.description, style: const TextStyle(fontSize: 16)),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: const Text(
                          "...more",
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                   ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: GestureDetector(
                        onTap: () {
                          player.pause();          // ✅ Pause current video
                          player.dispose();        // ✅ Dispose player (optional, if you're not coming back)

                          Get.toNamed(RoutesName.channel2_main_screen_route,arguments: video);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          child: (video.user?.profilePic != null &&
                             video.user!.profilePic!.isNotEmpty)
                              ? ClipOval(
                            child: Image.network(
                              video.user!.profilePic!,
                              fit: BoxFit.cover,
                            ),
                          )
                              : Icon(Icons.person, size: 50, color: Colors.grey.shade700),
                        ),
                      ),
                      title: GestureDetector(
                        onTap: () {
                          Get.toNamed(RoutesName.channel2_main_screen_route,arguments: video);
                        },
                        child: Row(
                          children: [
                            Text(video.user?.channelName ?? "no name", style: const TextStyle(color: Colors.black, fontSize: 18)),
                            const SizedBox(width: 8),
                            const Text("1", style: TextStyle(color: Colors.grey, fontSize: 14)),
                          ],
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          elevation: 0,
                        ),
                        child: const Text("Subscribe", style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      homeController.getComments(video.id.toString());

                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        isScrollControlled: true,
                        builder: (context) {
                          return DraggableScrollableSheet(
                            expand: false,
                            initialChildSize: 0.8,
                            minChildSize: 0.5,
                            maxChildSize: 0.95,
                            builder: (context, scrollController) {
                              return Column(
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      controller: scrollController,
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Container(
                                              width: 50,
                                              height: 5,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[400],
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            "Comments",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          const Divider(color: Colors.black54),

                                          // Comments List (Optional)

                                          Obx(() => homeController.isGettingComments.value
                                              ? const Center(child: CircularProgressIndicator())
                                              : ListView.builder(
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            itemCount: homeController.comments.length,
                                            itemBuilder: (context, index) {
                                              final comment = homeController.comments[index];

                                              return Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                                                child: Container(
                                                  padding: const EdgeInsets.all(12.0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade200,
                                                    borderRadius: BorderRadius.circular(12.0),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      // Optional: Show userId or username if available
                                                      Text(
                                                        'User: ${comment.userId}',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 14,
                                                        ),
                                                      ),

                                                      SizedBox(height: 4),

                                                      Text(
                                                        comment.commentText,
                                                        style: TextStyle(fontSize: 16),
                                                      ),

                                                      SizedBox(height: 6),

                                                      Text(
                                                        formatDate(comment.createdAt),
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey[600],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          )

                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                  SafeArea(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        border: Border(top: BorderSide(color: Colors.grey[300]!)),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: commentController,
                                              decoration: InputDecoration(
                                                hintText: 'Add a comment...',
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(30),
                                                  borderSide: BorderSide.none,
                                                ),
                                                filled: true,
                                                fillColor: Colors.grey[200],
                                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Obx(
                                            ()=> IconButton(
                                              icon: homeController.isCommentLoading.value
                                                  ? CircularProgressIndicator()
                                                  : Icon(Icons.send, color: Colors.black),
                                              onPressed: () {
                                                homeController.commentOnVideo(video.id.toString(), SupabaseServices.supabaseClient.auth.currentUser!.id, commentController.text);
                                                homeController.getComments(video.id.toString());
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Comments", style: TextStyle(fontSize: 18, color: Colors.black)),
                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Icon(Icons.account_circle, color: Colors.black, size: 25),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  "Add a comment...",
                                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    if (homeController.isGettingVideos.value) {
                      return ListView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return const ShimmerVideoItem();
                        },
                      );
                    } else {
                      return ListView.builder(
                        itemCount: homeController.videosList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final videoItem = homeController.videosList[index];
                          return GestureDetector(
                            onTap: () {
                              homeController.selectedVideo.value = videoItem;
                            },
                            child: VideoItem(video: videoItem),
                          );
                        },
                      );
                    }
                  }),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
