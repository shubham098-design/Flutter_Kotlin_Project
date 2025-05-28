import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_stream/features/channel/controller/channel_controller.dart';
import 'package:v_stream/features/home/widget/short_container.dart';
import 'package:v_stream/features/channel/widget/channel_video_item.dart';
import '../../../route/routes_name.dart';
import '../../../services/supabase_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ChannelController channelController = Get.put(ChannelController());

  @override
  void initState() {
    final userId = SupabaseServices.supabaseClient.auth.currentUser?.id;
    if (userId != null) {
      channelController.getUserByIdShort(userId);
      channelController.getUserByIdVideos(userId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (channelController.isGettingShorts.value || channelController.isGettingVideos.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Fallback to empty lists if the lists are null
        final shortsList = channelController.shortsList ?? [];
        final videosList = channelController.videosList ?? [];

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // SHORTS SECTION
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Shorts",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 220, // adjust according to ShortContainer height
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  itemCount: shortsList.length,
                  itemBuilder: (context, index) {
                    final video = shortsList[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          RoutesName.short_screen_route,
                          arguments: {
                            'shorts': channelController.shortsList,
                            'initialIndex': index,
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ShortContainer(video: video),
                      ),
                    );
                  },
                ),
              ),

              // VIDEOS SECTION
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Videos",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                itemCount: videosList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final video = videosList[index];
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(RoutesName.video_playing_screen_route, arguments: video);
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
