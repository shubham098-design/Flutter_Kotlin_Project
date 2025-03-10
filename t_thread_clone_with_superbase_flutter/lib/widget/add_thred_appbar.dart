import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:t_thread_clone_with_superbase_flutter/services/supabase_service.dart';

import '../controller/thread_controller.dart';
import '../services/navigation_service.dart';

class AddThredAppbar extends StatelessWidget {
  AddThredAppbar({super.key});

  final ThreadController threadController = Get.find<ThreadController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xff242424))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.find<NavigationService>().backToPrevPage();
                },
                icon: Icon(Icons.close),
              ),
              SizedBox(width: 10),
              Text("New Thread", style: TextStyle(fontSize: 20)),
            ],
          ),
          Obx(
            () => TextButton(
              onPressed: () {
                if (threadController.content.value.isNotEmpty) {
                  threadController.store(
                    Get.find<SupabaseServices>().currentUser.value!.id,
                  );
                }
              },
              child:
                  threadController.loading.value
                      ? SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(),
                      )
                      : Text(
                        "Post",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                              threadController.content.value.isNotEmpty
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
