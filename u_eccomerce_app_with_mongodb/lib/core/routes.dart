import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:u_eccomerce_app_with_mongodb/presentation/screen/auth/signup_screen.dart';
import 'package:u_eccomerce_app_with_mongodb/presentation/screen/home/home_screen.dart';
import 'package:u_eccomerce_app_with_mongodb/presentation/screen/order/order_placed_screen.dart';

import '../data/model/category/category_model.dart';
import '../data/model/product/product_model.dart';
import '../logic/cubits/category_product_cubit/category_product_cubit.dart';
import '../presentation/screen/auth/login_screen.dart';
import '../presentation/screen/auth/providers/login_provider.dart';
import '../presentation/screen/auth/providers/signup_provider.dart';
import '../presentation/screen/cart/cart_screen.dart';
import '../presentation/screen/order/my_order_screen.dart';
import '../presentation/screen/order/order_detail_screen.dart';
import '../presentation/screen/order/providers/order_detail_provider.dart';
import '../presentation/screen/product/category_product_screen.dart';
import '../presentation/screen/product/product_detail_screen.dart';
import '../presentation/screen/splash/splash_screen.dart';
import '../presentation/screen/user/edit_profile_screen.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {


      case LoginScreen.routeName:
        return CupertinoPageRoute(
          builder:
              (context) => ChangeNotifierProvider(
                create: (context) => LoginProvider(context),
                child: const LoginScreen(),
              ),
        );
      case SignupScreen.routeName:
        return CupertinoPageRoute(
          builder:
              (context) => ChangeNotifierProvider(
                create: (context) => SignupProvider(context),
                child: const SignupScreen(),
              ),
        );

      case HomeScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const HomeScreen());

      case SplashScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const SplashScreen());

      case ProductDetailsScreen.routeName:
        return CupertinoPageRoute(
          builder:
              (context) => ProductDetailsScreen(
                productModel: settings.arguments as ProductModel,
              ),
        );

      case CartScreen.routeName:
        return CupertinoPageRoute(builder: (context) => CartScreen());

      case CategoryProductScreen.routeName:
        return CupertinoPageRoute(
          builder:
              (context) => BlocProvider(
                create:
                    (context) => CategoryProductCubit(
                      settings.arguments as CategoryModel,
                    ),
                child: CategoryProductScreen(),
              ),
        );

      case EditProfileScreen.routeName:
        return CupertinoPageRoute(builder: (context) => EditProfileScreen());

      case OrderDetailScreen.routeName:
        return CupertinoPageRoute(builder: (context) => ChangeNotifierProvider(
            create: (context) => OrderDetailProvider(),
            child: OrderDetailScreen())
        );

      case OrderPlacedScreen.routeName:
        return CupertinoPageRoute(builder: (context) => OrderPlacedScreen());

      case MyOrderScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const MyOrderScreen());
      default:
        return null;
    }
  }
}
