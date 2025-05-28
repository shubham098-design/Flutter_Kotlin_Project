import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import '../../widget/short_container.dart';
import '../../../channel/widget/channel_video_item.dart';
import '../../../../route/routes_name.dart';

class ChannelHomeScreen extends StatefulWidget {
  const ChannelHomeScreen({super.key});

  @override
  State<ChannelHomeScreen> createState() => _ChannelHomeScreenState();
}

class _ChannelHomeScreenState extends State<ChannelHomeScreen> {
  late HomeController homeController;

  @override
  void initState() {
    super.initState();
    homeController = Get.find<HomeController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (homeController.isSpecificUserChannelGettingShorts.value ||
            homeController.isSpecificUserChannelGettingVideos.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shorts Section
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Shorts",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(
                height: 200, // Adjust height as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: homeController.specificUserChannelShortsList.length,
                  itemBuilder: (context, index) {
                    final video = homeController.specificUserChannelShortsList[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          RoutesName.short_screen_route,
                          arguments: video,
                        );
                      },
                      child: ShortContainer(video: video),
                    );
                  },
                ),
              ),

              // Videos Section
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Videos",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              ListView.builder(
                itemCount: homeController.specificUserChannelVideosList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final video = homeController.specificUserChannelVideosList[index];
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        RoutesName.video_playing_screen_route,
                        arguments: {
                          'shorts': homeController.specificUserChannelShortsList,
                          'initialIndex': index,
                        },
                      );
                    },
                    child: ChannelVideoItem(video: video),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
