import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v_stream/features/home/widget/video_items.dart';

import '../../../route/routes_name.dart';
import '../controller/search_controller.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchingController controller = Get.put(SearchingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            onChanged: controller.search,
            decoration: InputDecoration(
              hintText: 'Search video...',
              // border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              hintStyle: TextStyle(color: Colors.grey),
            ),
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.searchResults.isEmpty) {
          return const Center(child: Text("No results found"));
        } else {
          return ListView.builder(
            itemCount: controller.searchResults.length,
            itemBuilder: (context, index) {
              final video = controller.searchResults[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        RoutesName.video_playing_screen_route,
                        arguments: video,
                      );
                    },
                    child: VideoItem(video: video)
                ),
              );
            },
          );
        }
      }),
    );
  }
}
