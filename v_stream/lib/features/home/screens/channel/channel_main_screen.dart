import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:v_stream/features/channel/screens/channel_setting.dart';
import 'package:v_stream/features/home/controller/home_controller.dart';

import 'package:v_stream/features/home/screens/channel/channel_home_screen.dart';
import 'package:v_stream/features/home/screens/channel/channel_playlist_screen.dart';
import 'package:v_stream/features/home/screens/channel/channel_post_screen.dart';
import 'package:v_stream/features/home/screens/channel/channel_shorts_screen.dart';
import 'package:v_stream/features/home/screens/channel/channel_video_screen.dart';

import '../../model/video_model.dart';


class ChannelMainScreen extends StatefulWidget {
  const ChannelMainScreen({super.key});

  @override
  State<ChannelMainScreen> createState() => _ChannelMainScreenState();
}

class _ChannelMainScreenState extends State<ChannelMainScreen> {

  HomeController homeController = Get.put(HomeController());



  @override
  void initState() {
    super.initState();
    final video = Get.arguments as Video;
    homeController.getSpecificUserChannelVideos(video.userId);
    homeController.getSpecificUserChannelShorts(video.userId);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.search, size: 28),
          Icon(Icons.more_vert, size: 28),
        ],
      ),
      body: Obx(
            ()=>homeController.isSpecificUserChannelGettingVideos.value ? CircularProgressIndicator()
            : SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            padding: EdgeInsets.all(10),
            physics: BouncingScrollPhysics(),
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.shade300,
                    child: (homeController.specificUserChannelVideosList.first.user?.profilePic != null &&
                        homeController.specificUserChannelVideosList.first.user!.profilePic!.isNotEmpty)
                        ? ClipOval(
                      child: Image.network(
                        homeController.specificUserChannelVideosList.first.user!.profilePic!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    )
                        : Icon(Icons.person, size: 50, color: Colors.grey.shade700),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(homeController.specificUserChannelVideosList.first.user?.username ?? "Username not found",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Text(homeController.specificUserChannelVideosList.first.user?.email ??"Email not found"),
                      Row(
                        children: [
                          Text("1 Subscribers"),
                          SizedBox(width: 10),
                          Text("6 Videos"),
                        ],
                      )
                    ],
                  ),
                ],
              ),

              Text("More about this channel...more"),
              SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: DefaultTabController(
                  length: 5,
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        labelColor: Colors.lightBlueAccent,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Colors.lightBlueAccent,
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.lightBlueAccent.shade100,
                        indicatorWeight: 3,
                        tabs: const [
                          Tab(text: "Home",),
                          Tab(text: "Video"),
                          Tab(text: "Short"),
                          Tab(text: "Playlist"),
                          Tab(text: "Post"),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: const [
                            ChannelHomeScreen(),
                            ChannelVideoScreen(),
                            ChannelShortScreen(),
                            ChannelPlaylistScreen(),
                            ChannelPostScreen(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}