import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:t_thread_clone_with_superbase_flutter/routes/routes_name.dart';
import 'package:t_thread_clone_with_superbase_flutter/services/navigation_service.dart';
import 'package:t_thread_clone_with_superbase_flutter/services/supabase_service.dart';
import 'package:t_thread_clone_with_superbase_flutter/widget/image_circle.dart';
import 'package:t_thread_clone_with_superbase_flutter/widget/loading.dart';

import '../../controller/notification_controller.dart';
import '../../utils/helper.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  final NotificationController notificationController = Get.put(NotificationController());

  @override
  initState(){
    notificationController.fetchNotifications(Get.find<SupabaseServices>().currentUser.value!.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>Get.find<NavigationService>().backToPrevPage(), icon: Icon(Icons.close)),
        title: SingleChildScrollView(
          child: Obx(()=> notificationController.loading.value ? Loading() : Column(
              children: [
                if(notificationController.notifications.isNotEmpty)
                  ListView.builder(itemBuilder: (context , index){
                    ListTile(
                      onTap: (){
                        Get.toNamed(RouteName.showThread,arguments: notificationController.notifications[index].postId);
                      },
                      leading: ImageCircle(url: notificationController.notifications[index].user?.metadata?.image),
                      title: Text(notificationController.notifications[index].user!.metadata!.name!),
                      trailing: Text(formatDate(notificationController.notifications[index].createdAt!)),
                      subtitle: Text(notificationController.notifications[index].notification!),
                    );
                  },itemCount: notificationController.notifications.length,
                  shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                  )
                else
                  Text("No notifications"),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
