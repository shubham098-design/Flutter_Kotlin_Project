import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_stream/features/channel/controller/channel_controller.dart';
import '../../../route/routes_name.dart';
import '../../../services/supabase_services.dart';
import '../widget/channel_video_item.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final ChannelController channelController = Get.find<ChannelController>();

  @override
  void initState() {
    final userId = SupabaseServices.supabaseClient.auth.currentUser?.id;
    channelController.getUserByIdVideos(userId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () =>
        channelController.isGettingVideos.value
            ? const Center(
            child: CircularProgressIndicator()
        )
            : ListView.builder(
          itemCount: channelController.videosList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final video = channelController.videosList[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed(
                  RoutesName.video_playing_screen_route,
                  arguments: video,
                );
              },
              child: ChannelVideoItem(video: video),
            );
          },
        ),
      ),
    );
  }
}
