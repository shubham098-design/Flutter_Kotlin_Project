import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_stream/features/home/controller/home_controller.dart';
import 'package:v_stream/features/home/widget/short_container.dart';
import 'package:v_stream/features/home/widget/top_section.dart';
import '../../../route/routes_name.dart';
import '../widget/shimmer_video_item.dart';
import '../widget/video_items.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    homeController.getVideos();
    homeController.getShorts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "V-Stream",
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const Spacer(),
                Row(
                  children:  [
                    GestureDetector(
                        onTap: (){
                          Get.toNamed(RoutesName.search_screen_route);
                        },
                        child: Icon(Icons.search, size: 28)),
                    SizedBox(width: 10),
                    GestureDetector(
                        onTap: (){
                          Get.snackbar(
                            "Notification",
                            "No notification found",
                            snackPosition: SnackPosition.BOTTOM, // OR SnackPosition.TOP
                          );
                        },
                        child: Icon(Icons.notifications, size: 28)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          padding: const EdgeInsets.all(10),
          physics: const BouncingScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TopSection(text: "All",containerColor: Colors.grey,textColor: Colors.white),
                GestureDetector(
                    onTap: (){
                      Get.toNamed(RoutesName.category_screen_route,arguments: "Music");
                    },child: TopSection(text: "Music")
                ),
                 GestureDetector(
                   onTap: (){
                     Get.toNamed(RoutesName.category_screen_route,arguments: "News");
                   },
                     child: TopSection(text: "News")
                 ),
                 GestureDetector(onTap: (){
                   Get.toNamed(RoutesName.category_screen_route,arguments: "Explore");

                 },child: TopSection(text: "Explore")),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "Shorts",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Obx(
              ()=> homeController.isGettingShorts.value ?
              const CircularProgressIndicator()
                  : SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                  itemCount: homeController.shortList.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final video = homeController.shortList[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          RoutesName.short_screen_route,
                          arguments: {
                            'shorts': homeController.shortList,
                            'initialIndex': index,
                          },
                        );
                      },
                      child: ShortContainer(video: video),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Videos",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Obx(
              () =>
                  homeController.isGettingVideos.value
                      ? ListView.builder(
                        itemCount: homeController.videosList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return const ShimmerVideoItem();
                        },
                      )
                      : ListView.builder(
                        itemCount: homeController.videosList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final video = homeController.videosList[index];
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                RoutesName.video_playing_screen_route,
                                arguments: video,
                              );
                            },
                            child: VideoItem(video: video),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
