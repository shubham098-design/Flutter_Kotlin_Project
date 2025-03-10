import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:p_grocery_app/pages/profile_page.dart';
import 'package:p_grocery_app/pages/search_item.dart';
import 'package:p_grocery_app/pages/wallet_page.dart';

import 'order_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

  late List<Widget> pages;
  late SearchItemPage searchItemPage;
  late OrderPage orderPage;
  late ProfilePage profilePage;
  late WalletPage walletPage;
  int currentTabIndex = 0;

  @override
  void initState() {
    searchItemPage = SearchItemPage();
    orderPage = OrderPage();
    profilePage = ProfilePage();
    walletPage = WalletPage();
    pages = [searchItemPage, orderPage, walletPage, profilePage];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(height: 65,
          backgroundColor: Colors.white,
          color: Colors.black,
          animationDuration: Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          items: [
            Icon(Icons.home_outlined,color: Colors.white,),
            Icon(Icons.shopping_cart_outlined,color: Colors.white,),
            Icon(Icons.wallet_outlined,color: Colors.white,),
            Icon(Icons.person_outline,color: Colors.white,),
          ],
        ),
    );
  }
}
