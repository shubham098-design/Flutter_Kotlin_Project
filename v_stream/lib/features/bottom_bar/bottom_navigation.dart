import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:v_stream/features/add/screen/add_screen.dart';
import 'package:v_stream/features/home/screens/home_screen.dart';

import '../profile/screen/profile_screen.dart';
import '../shorts/screen/shorts_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  late List<Widget> pages;
  late HomeScreen homeScreen;
  late ShortsScreen shortsScreen;
  late AddScreen addScreen;
  late ProfileScreen profileScreen;
  int currentTabIndex = 0;

  @override
  void initState() {
    homeScreen = HomeScreen();
    shortsScreen = ShortsScreen();
    addScreen = AddScreen();
    profileScreen = ProfileScreen();
    pages = [homeScreen,shortsScreen,addScreen,profileScreen];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentTabIndex],
      bottomNavigationBar: CurvedNavigationBar(height: 55,
        backgroundColor: Colors.transparent,
        color: Colors.black,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          Icon(Icons.home_outlined,color: Colors.white,),
          Icon(Icons.shop_rounded,color: Colors.white,),
          Icon(Icons.add,color: Colors.white,),
          Icon(Icons.person_outline,color: Colors.white,),
        ],
      ),
    );
  }
}
