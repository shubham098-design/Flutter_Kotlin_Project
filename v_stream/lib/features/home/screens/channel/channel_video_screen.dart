import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../route/routes_name.dart';
import '../../../channel/widget/channel_video_item.dart';
import '../../controller/home_controller.dart';

class ChannelVideoScreen extends StatefulWidget {
  const ChannelVideoScreen({super.key});

  @override
  State<ChannelVideoScreen> createState() => _ChannelVideoScreenState();
}

class _ChannelVideoScreenState extends State<ChannelVideoScreen> {
  late HomeController homeController;

  @override
  void initState() {
    super.initState();
    homeController = Get.find<HomeController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () =>
            homeController.isSpecificUserChannelGettingVideos.value
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                  itemCount: homeController.specificUserChannelVideosList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final video = homeController.specificUserChannelVideosList[index];
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
