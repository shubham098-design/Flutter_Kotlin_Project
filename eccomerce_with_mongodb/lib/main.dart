import 'package:eccomerce_with_mongodb/common/widget/bottom_bar.dart';
import 'package:eccomerce_with_mongodb/features/admine/screens/add_product_screen.dart';
import 'package:eccomerce_with_mongodb/features/admine/screens/admine_screen.dart';
import 'package:eccomerce_with_mongodb/features/order/provider/order_provider.dart';
import 'package:eccomerce_with_mongodb/route/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/auth/provider/user_provider.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/services/user_service.dart';
import 'features/cart/provider/cart_provider.dart';
import 'features/home/screens/home_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
       ChangeNotifierProvider(create: (_) => CartProvider()),
       ChangeNotifierProvider(create: (_) => OrderProvider()),
       ChangeNotifierProvider(create: (_) => UserProvider()),
    ],
  child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
final UserService userService = UserService();
  @override
  void initState() {
    userService.getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amazon Clone',
      theme: ThemeData(
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      onGenerateRoute: (setting) => generateRoute(setting),
      home:  const LoginScreen(),
      // home: AdminScreen(),

    );
  }
}