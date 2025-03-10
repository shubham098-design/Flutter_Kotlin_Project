import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_thread_clone_with_superbase_flutter/widget/loading.dart';
import 'package:t_thread_clone_with_superbase_flutter/widget/post_card.dart';

import '../../controller/home_controller.dart';

class HomePage2 extends StatelessWidget {
  HomePage2({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: const EdgeInsets.all(10.0),
          child: RefreshIndicator(
            onRefresh: ()=>homeController.fetchTreads(),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Padding(padding: const EdgeInsets.only(top: 10),
                    child: Image.asset("assets/images/logo.png",width: 40,height: 40,),
                  ),
                  centerTitle: true,
                ),
                SliverToBoxAdapter(
                  child: Obx(()=> homeController.loading.value ? const Loading() :
                      PostCard(post: homeController.posts.first)
                  // ListView.builder(
                  //     shrinkWrap: true,
                  //     padding: EdgeInsets.zero,
                  //     physics: const BouncingScrollPhysics(),
                  //     itemCount : homeController.posts.length,itemBuilder: (context , index){
                  //   PostCard(post: homeController.posts[index]);
                  // }
                  // ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
