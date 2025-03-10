import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_thread_clone_with_superbase_flutter/utils/button_style.dart';
import 'package:t_thread_clone_with_superbase_flutter/widget/reply_card.dart';
import 'package:t_thread_clone_with_superbase_flutter/widget/post_card.dart';

import '../../controller/profile_controller.dart';
import '../../routes/routes_name.dart';
import '../../services/supabase_service.dart';
import '../../widget/image_circle.dart';
import '../../widget/loading.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController profileController = Get.put(ProfileController());
  final SupabaseServices supabaseServices = Get.find<SupabaseServices>();

  @override
  void initState() {
    if (supabaseServices.currentUser.value?.id != null) {
      profileController.fetchUserThreads(
        supabaseServices.currentUser.value!.id,
      );
      profileController.fetchReplies(supabaseServices.currentUser.value!.id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Icon(Icons.language),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(RouteName.setting);
            },
            icon: Icon(Icons.sort),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 160,
                collapsedHeight: 160,
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Obx(
                    () => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  supabaseServices
                                      .currentUser
                                      .value!
                                      .userMetadata?["name"],
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: context.width * 0.60,
                                  child: Text(
                                    supabaseServices
                                            .currentUser
                                            .value
                                            ?.userMetadata?["description"] ??
                                        "thread clone.",
                                  ),
                                ),
                              ],
                            ),
                            ImageCircle(
                              radius: 40,
                              url:
                                  supabaseServices
                                      .currentUser
                                      .value
                                      ?.userMetadata?["image"],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  Get.toNamed(RouteName.edit);
                                },
                                style: customOutlinedStyle(),
                                child: Text("Edit Profile"),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {},
                                style: customOutlinedStyle(),
                                child: Text("Share Profile"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                floating: true,
                pinned: true,
                delegate: SliverAppBarDelegate(
                  const TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [Tab(text: "Threads"), Tab(text: "Replies")],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              Obx(
                () => SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      if (profileController.postLoading.value) const Loading()
                      else if (profileController.posts.isNotEmpty)
                        ListView.builder(shrinkWrap: true,physics: BouncingScrollPhysics(),itemCount : profileController.posts.length,itemBuilder: (context,index){
                          PostCard(post: profileController.posts[index],isAuthCard: true,callback: profileController.deleteThread,);
                        })
                      else
                        Center(child: const Text("No Threads Found!")),
                    ]
                  )
                )
              ),

              Obx(()=>
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    if (profileController.replyLoading.value) const Loading()
                    else if (profileController.replies.isNotEmpty)
                      ListView.builder(shrinkWrap: true,physics: BouncingScrollPhysics(),itemCount : profileController.replies.length,itemBuilder: (context,index){
                        ReplyCard(replay: profileController.replies[index]);
                      })
                    else
                      Center(child: const Text("No Replies Found!")),
                  ],
                ),
              )
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  SliverAppBarDelegate(this._tabBar);

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: Colors.black, child: _tabBar);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
