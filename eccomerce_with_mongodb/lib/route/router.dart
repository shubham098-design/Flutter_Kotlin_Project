import 'package:eccomerce_with_mongodb/features/auth/screens/login_screen.dart';
import 'package:eccomerce_with_mongodb/features/home/screens/home_product_detail_screen.dart';
import 'package:eccomerce_with_mongodb/features/order/screens/order_screen.dart';
import 'package:eccomerce_with_mongodb/models/product_model.dart';
import 'package:flutter/material.dart';

import '../common/widget/bottom_bar.dart';
import '../features/account/screens/edit_profile_screen.dart';
import '../features/admine/screens/add_product_screen.dart';
import '../features/admine/screens/product_detail_screen.dart';
import '../features/auth/screens/signup_screen.dart';
import '../features/home/screens/category_detail_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/search/screens/search_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );

    case SignupScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignupScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProductScreen(),
      );

    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );

    case ProductDetailScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(),
      );

    case HomeProductDetailScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => HomeProductDetailScreen(),
      );

    case OrderScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OrderScreen(),
      );

      case EditProfileScreen.routeName:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const EditProfileScreen(),
        );

    // case OrderDetailScreen.routeName:
    //   var order = routeSettings.arguments as Order;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => OrderDetailScreen(
    //       order: order,
    //     ),
    //   );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}