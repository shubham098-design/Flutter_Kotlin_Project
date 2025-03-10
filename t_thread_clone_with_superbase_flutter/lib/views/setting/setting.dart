import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/setting_controller.dart';
import '../../utils/helper.dart';

class Setting extends StatelessWidget {
  Setting({super.key});

  final SettingController settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              onTap: (){
                confirmDialog("Are you sure?", "This action logout you from app.",(){
                  settingController.logout();
                });
              },
              title: Text("Logout"),
              leading: Icon(Icons.logout),
              trailing: Icon(Icons.arrow_forward),
            )
          ],
        ),
      ),
    );
  }
}
