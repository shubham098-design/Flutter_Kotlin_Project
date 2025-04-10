import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/navigation_service.dart';

class BottomNavigation extends StatelessWidget {
   BottomNavigation({super.key});
  final NavigationService navigationService = Get.put(NavigationService());

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
        bottomNavigationBar: NavigationBar(
            selectedIndex: navigationService.currentIndex.value,
            onDestinationSelected: (index){
              navigationService.updateIndex(index);
            },
          destinations: [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: "home",selectedIcon: Icon(Icons.home),),
          NavigationDestination(icon: Icon(Icons.search_outlined), label: "search",selectedIcon: Icon(Icons.search),),
          NavigationDestination(icon: Icon(Icons.shopping_cart_outlined), label: "cart",selectedIcon: Icon(Icons.shopping_cart),),
          NavigationDestination(icon: Icon(Icons.person_outline), label: "person",selectedIcon: Icon(Icons.person),),
          ],
        ),
        body: AnimatedSwitcher(duration: Duration(microseconds: 500),switchInCurve: Curves.ease,switchOutCurve: Curves.easeInOut,
          child: navigationService.pages()[navigationService.currentIndex.value],)

      ),
    );
  }
}
