import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:v_stream/features/auth/controller/auth_controller.dart';
import 'package:v_stream/features/channel/screens/main_screen.dart';
import 'package:v_stream/features/home/controller/home_controller.dart';
import 'package:v_stream/route/routes_name.dart';

import '../widget/history_container.dart';
import '../widget/playlist_container.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  AuthController authController = Get.put(AuthController());
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: (){
                Get.snackbar(
                  "Notification",
                  "This feature is not available yet",
                  snackPosition: SnackPosition.BOTTOM, // OR SnackPosition.TOP
                );
              },
              child: Icon(Icons.notifications, size: 28)),
          GestureDetector(
              onTap: (){
                Get.toNamed(RoutesName.search_screen_route);
              },
              child: Icon(Icons.search, size: 28)),
          GestureDetector(
              onTap: (){
                Get.snackbar(
                  "Settings",
                  "This feature is not available yet",
                  snackPosition: SnackPosition.BOTTOM, // OR SnackPosition.TOP
                );
              },
              child: Icon(Icons.settings, size: 28)),
        ],
      ),
      body: Obx(
          ()=> authController.isGettingUser.value ?
          const Center(child: CircularProgressIndicator()) : SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            padding: EdgeInsets.all(10),
            physics: BouncingScrollPhysics(),
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(),));
                },
                child: Row(
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
                          authController.userModel!.username,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        Text(authController.userModel!.email),

                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "History",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Colors.black54),
                    ),
                    child: Center(
                      child: Text(
                        "view all",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 200 , // 16 for padding
                child: ListView.builder(
                  itemCount: homeController.videosList.length,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final video = homeController.videosList[index];
                    return HistoryContainer(video: video,);
                  },
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Playlist",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Row(
                    children: [
                      Icon(Icons.add),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: 25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.black54),
                        ),
                        child: Center(
                          child: Text(
                            "view all",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: 1,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return PlaylistContainer(title: "Playlist Title", subtitle: "Playlist Subtitle" );
                  },
                ),
              ),

              Divider(color: Colors.black54,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(),));
                },
                child: ListTile(
                  leading: Icon(Icons.video_collection_outlined),
                  title: Text("Your videos"),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Get.snackbar(
                    "Notification",
                    "This feature is not available yet",
                    snackPosition: SnackPosition.BOTTOM, // OR SnackPosition.TOP
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.download_outlined),
                  title: Text("Downloads"),
                  trailing: Icon(Icons.check_circle),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HelpScreen(),));

                },
                child: ListTile(
                  leading: Icon(Icons.help_outline_outlined),
                  title: Text("Help and feedback"),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(" My Name is Shubham",style: TextStyle(fontWeight: FontWeight.bold),),
              Text(" And I am a Flutter Developer ",style: TextStyle(fontWeight: FontWeight.bold),),
              Text(" if you have any query please  ",style: TextStyle(fontWeight: FontWeight.bold),),
              Text("  contact me at shubhamdhaniyan09@gmail.com ",style: TextStyle(fontWeight: FontWeight.bold),),
              Text(" Thank you",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
            ],
          ),
        ),
      ),
    );
  }
}
