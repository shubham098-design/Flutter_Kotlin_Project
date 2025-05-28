import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../route/routes_name.dart';
import '../../controller/home_controller.dart';
import '../../widget/short_container.dart';

class ChannelShortScreen extends StatefulWidget {
  const ChannelShortScreen({super.key});

  @override
  State<ChannelShortScreen> createState() => _ChannelShortScreenState();
}

class _ChannelShortScreenState extends State<ChannelShortScreen> {
  late HomeController homeController;

  @override
  void initState() {
    super.initState();
    homeController = Get.find<HomeController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => homeController.isSpecificUserChannelGettingShorts.value
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: homeController.specificUserChannelShortsList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.75, // Adjust according to your ShortContainer layout
          ),
          itemBuilder: (context, index) {
            final video = homeController.specificUserChannelShortsList[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed(
                  RoutesName.short_screen_route,
                  arguments: {
                    'shorts': homeController.specificUserChannelShortsList,
                    'initialIndex': index,
                  },
                );
              },
              child: ShortContainer(video: video),
            );
          },
        ),
      ),
    );
  }
}
