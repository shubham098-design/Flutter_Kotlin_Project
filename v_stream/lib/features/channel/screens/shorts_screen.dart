import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:v_stream/features/home/widget/short_container.dart';

import '../../../route/routes_name.dart';
import '../../../services/supabase_services.dart';
import '../controller/channel_controller.dart';

class ShortScreen extends StatefulWidget {
  const ShortScreen({super.key});

  @override
  State<ShortScreen> createState() => _ShortScreenState();
}

class _ShortScreenState extends State<ShortScreen> {
  final ChannelController channelController = Get.put(ChannelController());

  @override
  void initState() {
    final userId = SupabaseServices.supabaseClient.auth.currentUser?.id;
    channelController.getUserByIdShort(userId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => channelController.isGettingShorts.value
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: channelController.shortsList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final video = channelController.shortsList[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed(
                  RoutesName.short_screen_route,
                  arguments: {
                    "shorts": channelController.shortsList,
                    "initialIndex": index,
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
