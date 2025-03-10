import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_thread_clone_with_superbase_flutter/routes/routes_name.dart';
import 'package:t_thread_clone_with_superbase_flutter/widget/image_circle.dart';

import '../models/user_model.dart';
import '../utils/helper.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  const UserTile({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: ImageCircle(url: user.metadata?.image),
      ),
      title: Text(user.metadata!.name!),
      titleAlignment: ListTileTitleAlignment.top,
      trailing: OutlinedButton(
        onPressed: () {
          Get.toNamed(RouteName.showProfile, arguments: user.id!);
        },
        child: const Text("View profile"),
      ),
      subtitle: Text(formatDate(user.createdAt!)),
    );
  }
}