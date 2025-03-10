import 'dart:convert';

import 'package:get/get.dart';
import 'package:t_thread_clone_with_superbase_flutter/services/supabase_service.dart';

import '../models/NotificationModel.dart';
import '../utils/helper.dart';

class NotificationController extends GetxController {
  var loading = false.obs;
  RxList<NotificationModel> notifications = RxList<NotificationModel>();

  void fetchNotifications(String userId) async {
    try {
      loading.value = true;
      final List<dynamic> responce = await SupabaseServices.client.from("notifications").select('''
        id, post_id, notification,created_at, user_id,user:user_id (email , metadata)
        ''').eq("to_user_id", userId).order("id", ascending: false);

      if (responce.isNotEmpty) {
        notifications.value = [for (var item in responce) NotificationModel.fromJson(item)];
      }

      loading.value = false;
      print("The notification responce is ${jsonEncode(responce)}");
    }catch (e) {
      loading.value = false;
      showSnackBar("Error fetching notifications", e.toString());
    }
  }

}