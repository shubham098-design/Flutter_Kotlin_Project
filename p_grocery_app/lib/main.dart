import 'package:flutter/material.dart';
import 'package:p_grocery_app/pages/bottom_nav.dart';
import 'package:p_grocery_app/pages/detail_page.dart';
import 'package:p_grocery_app/pages/onboard.dart';
import 'package:p_grocery_app/pages/search_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:BottomNav(),
    );
  }
}

