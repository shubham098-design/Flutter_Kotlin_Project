import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:u_eccomerce_app_with_mongodb/presentation/screen/auth/signup_screen.dart';

import '../presentation/screen/auth/login_screen.dart';
import '../presentation/screen/auth/providers/login_provider.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
                  create: (context) => LoginProvider(context),
                  child: const LoginScreen()),
        );
      case SignupScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const SignupScreen());
      default:
        return null;
    }
  }
}
