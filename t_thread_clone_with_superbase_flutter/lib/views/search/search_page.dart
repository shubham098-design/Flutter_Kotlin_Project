import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/platform/platform.dart';

import '../../controller/search_controller.dart';
import '../../widget/loading.dart';
import '../../widget/search_input.dart';
import '../../widget/user_tiles.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final TextEditingController textEditingController =
  TextEditingController(text: "");
  final SearchUserController controller = Get.put(SearchUserController());

  void searchUser(String? name) async {
    if (name != null) {
      await controller.searchUser(name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            centerTitle: false,
            title: const Text(
              "Search",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            expandedHeight: GetPlatform.isIOS ? 110 : 105,
            collapsedHeight: GetPlatform.isIOS ? 90 : 80,
            flexibleSpace: Padding(
              padding: EdgeInsets.only(
                  top: GetPlatform.isIOS ? 105.0 : 80, left: 10, right: 10),
              child: SearchInput(
                textController: textEditingController,
                hintText: "Search",
                callback: searchUser,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(
                  () => controller.loading.value
                  ? const Loading()
                  : Column(
                children: [
                  if (controller.users.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: controller.users.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          UserTile(user: controller.users[index]!),
                    )
                  else if (controller.users.isEmpty &&
                      controller.notFound.value == true)
                    const Text("No user found")
                  else
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text("Search users with their names"),
                      ),
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
