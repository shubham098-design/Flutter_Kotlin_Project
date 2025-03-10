import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../views/home/home_page.dart';
import '../views/notification/notification_page.dart';
import '../views/profile/profile_page.dart';
import '../views/search/search_page.dart';
import '../views/thread/thread_page.dart';

class NavigationService extends GetxService{
  var currentIndex = 0.obs;
  var previousIndex = 0.obs;

  List<Widget> pages(){
    return[
       HomePage2(),
       SearchPage(),
       ThreadPage(),
       NotificationPage(),
       ProfilePage(),
    ];
  }

  void updateIndex(int index){
    previousIndex.value = currentIndex.value;
    currentIndex.value = index;
  }

  // * Back to Prev page

void backToPrevPage(){
    currentIndex.value = previousIndex.value;
}

}