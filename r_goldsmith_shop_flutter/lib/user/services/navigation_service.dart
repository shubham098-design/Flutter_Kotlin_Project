import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:r_goldsmith_shop_flutter/user/pages/f_explore_page.dart';
import 'package:r_goldsmith_shop_flutter/user/pages/h_home_screen.dart';

import '../pages/d_profile_page.dart';
import '../pages/g_mycart_page.dart';

class NavigationService extends GetxService{
  var currentIndex = 0.obs;
  var previousIndex = 0.obs;

  List<Widget> pages(){
    return[
      HomeScreen(),
      ExploreScreen(),
      MyCartPage(),
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