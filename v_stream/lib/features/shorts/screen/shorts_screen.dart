import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/supabase_services.dart';
import '../../home/controller/home_controller.dart';
import '../../home/helper/home_helper.dart';
import '../../home/model/video_model.dart' as my_model;
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart' as mkit;
import 'package:media_kit_video/media_kit_video.dart';


class ShortsScreen extends StatefulWidget {
  const ShortsScreen({super.key});

  @override
  State<ShortsScreen> createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen> {
  final HomeController homeController = Get.find<HomeController>();
  late List<my_model.Video> shortList;
  int initialIndex = 0;
  late PageController pageController;
  TextEditingController commentController = TextEditingController();
  late final Player player;
  late final mkit.VideoController videoController;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      shortList = args['shorts'] ?? homeController.shortList;
      initialIndex = args['initialIndex'] ?? 0;
    } else {
      shortList = homeController.shortList;
      initialIndex = 0;
    }

    player = Player();
    videoController = mkit.VideoController(player);
    pageController = PageController(initialPage: initialIndex);

    // Start initial video
    if (shortList.isNotEmpty) {
      player.open(Media(shortList[initialIndex].videoUrl), play: true);
    }
  }

  @override
  void dispose() {
    player.dispose();
    pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Shorts",
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          Icon(Icons.search, color: Colors.white),
          SizedBox(width: 16),
          Icon(Icons.more_vert, color: Colors.white),
          SizedBox(width: 8),
        ],
      ),
      body: Obx(
            () => homeController.isGettingShorts.value &&
            shortList == homeController.shortList
            ? const Center(child: CircularProgressIndicator())
            : PageView.builder(
              controller: pageController,
              scrollDirection: Axis.vertical,
              itemCount: shortList.length,
              onPageChanged: (index) {
                final videoUrl = shortList[index].videoUrl;
                player.open(Media(videoUrl), play: true); // auto-play
              },
          itemBuilder: (context, index) {
            final short = shortList[index];
            return Stack(
              children: [
                SizedBox.expand(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: mkit.Video(controller: videoController),
                  ),
                ),

                // Gradient Overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Bottom content
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Left: Channel info & title
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  short.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                      Colors.grey.shade300,
                                      radius: 18,
                                      child: (short.user?.profilePic !=
                                          null &&
                                          short.user!.profilePic!
                                              .isNotEmpty)
                                          ? ClipOval(
                                        child: Image.network(
                                          short.user!.profilePic!,
                                          fit: BoxFit.cover,
                                          width: 36,
                                          height: 36,
                                        ),
                                      )
                                          : Icon(Icons.person,
                                          color:
                                          Colors.grey.shade700),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${short.user?.channelName}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Right-side vertical actions
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.thumb_up_alt,
                                  color: Colors.white),
                              const SizedBox(height: 4),
                               Text(short.likeCount.toString(),
                                  style: TextStyle(color: Colors.white)),
                              const SizedBox(height: 16),
                              const Icon(Icons.thumb_down_alt,
                                  color: Colors.white),
                              const SizedBox(height: 4),
                              const Text("Dislike",
                                  style: TextStyle(color: Colors.white)),
                              const SizedBox(height: 16),

                              const SizedBox(height: 4),
                               Text("${homeController.comments.length}",
                                  style: TextStyle(color: Colors.white)),
                              const SizedBox(height: 16),
                              GestureDetector(
                                onTap: ()  {
                                  homeController.getComments(short.id.toString());

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
                                                            homeController.commentOnVideo(short.id.toString(), SupabaseServices.supabaseClient.auth.currentUser!.id, commentController.text);
                                                            homeController.getComments(short.id.toString());
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
                                child: Icon(Icons.comment_outlined,
                                    color: Colors.white),
                              ),
                               GestureDetector(
                                   onTap: (){
                                     Get.snackbar(
                                       "Share",
                                       "This feature is not available yet",
                                       snackPosition: SnackPosition.BOTTOM, // OR SnackPosition.TOP
                                     );
                                   },
                                   child: Icon(Icons.share, color: Colors.white)),
                              const SizedBox(height: 4),
                              const Text("Share",
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}


/**
 *
 */

