import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:v_stream/features/channel/screens/channel_setting.dart';
import 'package:v_stream/features/channel/screens/home_screen.dart';
import 'package:v_stream/features/channel/screens/playlist_screen.dart';
import 'package:v_stream/features/channel/screens/post_screen.dart';
import 'package:v_stream/features/channel/screens/shorts_screen.dart';
import 'package:v_stream/features/channel/screens/video_screen.dart';

import '../../auth/controller/auth_controller.dart';
import '../../shorts/screen/shorts_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [
          Icon(Icons.search, size: 28),
          Icon(Icons.more_vert, size: 28),
        ],
      ),
      body: SizedBox(
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
                  child: (authController.userModel?.profilePic != null &&
                      authController.userModel!.profilePic!.isNotEmpty)
                      ? ClipOval(
                    child: Image.network(
                      authController.userModel!.profilePic!,
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
                    Text(
                      authController.userModel?.username ?? "Name not found",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Text(authController.userModel?.email ?? "Email not found"),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
                  Get.snackbar("Manage videos", "This feature is under development");
                },style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlueAccent), child: Text("Manage videos"),),
                Row(
                  children: [
                    GestureDetector(onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ChannelSetting(),));
                    },child: Icon(Icons.edit_outlined)),
                  ],
                )
              ],
            ),
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
                          HomeScreen(),
                          VideoScreen(),
                          ShortScreen(),
                          PlaylistScreen(),
                          PostScreen(),
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
    );
  }
}
