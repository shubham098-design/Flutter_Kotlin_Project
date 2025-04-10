
import 'package:eccomerce_with_mongodb/features/account/screens/account_screen.dart';
import 'package:eccomerce_with_mongodb/features/cart/screens/cart_screen.dart';
import 'package:eccomerce_with_mongodb/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  int _page = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
     CartScreen(),
    const Center(child: Text('Menu'),),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },

        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        iconSize: 28,
        items:  [
          BottomNavigationBarItem(icon: Container(width : bottomBarWidth,
              decoration: BoxDecoration(border: Border(top: BorderSide(width: bottomBarBorderWidth,color: _page == 0 ? Colors.amber : Colors.transparent)))
              ,child: Icon(Icons.home_outlined)), label: ''),
          BottomNavigationBarItem(icon: Container(width : bottomBarWidth,
              decoration: BoxDecoration(border: Border(top: BorderSide(width: bottomBarBorderWidth,color: _page == 1 ? Colors.amber : Colors.transparent)))
              ,child: Icon(Icons.person_outline)), label: ''),

          BottomNavigationBarItem(icon: Container(width : bottomBarWidth,
              decoration: BoxDecoration(border: Border(top: BorderSide(width: bottomBarBorderWidth,color: _page == 2 ? Colors.amber : Colors.transparent)))
              ,child: Icon(Icons.shopping_cart_outlined)), label: ''),
          BottomNavigationBarItem(icon: Container(width : bottomBarWidth,
              decoration: BoxDecoration(border: Border(top: BorderSide(width: bottomBarBorderWidth,color: _page == 4 ? Colors.amber : Colors.transparent)))
              ,child: Icon(Icons.menu)), label: ''),
        ],
      ),
    );
  }
}
