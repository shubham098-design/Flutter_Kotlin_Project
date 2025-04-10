import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:r_goldsmith_shop_flutter/admine/pages/mobile/screen/mob_add_category_screen.dart';
import 'package:r_goldsmith_shop_flutter/admine/pages/mobile/screen/mob_add_product_screen.dart';
import 'package:r_goldsmith_shop_flutter/admine/pages/mobile/screen/mob_all_product_screen.dart';
import 'package:r_goldsmith_shop_flutter/admine/pages/mobile/screen/mob_analytics_screen.dart';
import 'package:r_goldsmith_shop_flutter/admine/pages/mobile/screen/mob_customer_screen.dart';
import 'package:r_goldsmith_shop_flutter/admine/pages/mobile/screen/mob_dashboard_screen.dart';
import 'package:r_goldsmith_shop_flutter/admine/pages/mobile/screen/mob_login_screen.dart';
import 'package:r_goldsmith_shop_flutter/admine/pages/mobile/screen/mob_onboarding_screen.dart';
import 'package:r_goldsmith_shop_flutter/admine/pages/mobile/screen/mob_order_screen.dart';
import 'package:r_goldsmith_shop_flutter/admine/pages/mobile/screen/mob_signup_screen.dart';
import 'package:r_goldsmith_shop_flutter/admine/pages/orders/desktop_orders_screen.dart';
import 'package:r_goldsmith_shop_flutter/admine/route/routes.dart';

import '../pages/responsive/responsive_layout.dart';


class AdmineRoute {
  static final page = [
    GetPage(name: AdmineRouteNames.ordersDesktopScreen, page: () => DesktopOrdersScreen(),transition: Transition.leftToRight),

    //------------------------------Mobile-------------------------------------//

    GetPage(name: AdmineRouteNames.mob_onboarding_screen, page: () => MobOnboardingScreen(),transition: Transition.leftToRight),
    GetPage(name: AdmineRouteNames.mob_login_screen, page: () => MobLoginScreen(),transition: Transition.leftToRight),
    GetPage(name: AdmineRouteNames.mob_signup_screen, page: () => MobSignupScreen(),transition: Transition.leftToRight),
    GetPage(name: AdmineRouteNames.mob_dashboard_screen, page: () => MobDashboardScreen(),transition: Transition.leftToRight),
    GetPage(name: AdmineRouteNames.mob_add_product_screen, page: () => MobAddProductScreen(),transition: Transition.leftToRight),
    GetPage(name: AdmineRouteNames.mob_all_product_screen, page: () => MobAllProductScreen(),transition: Transition.leftToRight),
    GetPage(name: AdmineRouteNames.mob_add_category_screen, page: () => MobAddCategoryScreen(),transition: Transition.leftToRight),
    GetPage(name: AdmineRouteNames.mob_orders_screen, page: () => MobOrderScreen(),transition: Transition.leftToRight),
    GetPage(name: AdmineRouteNames.mob_customer_screen, page: () => MobCustomerScreen(),transition: Transition.leftToRight),
    GetPage(name: AdmineRouteNames.mob_analytics_screen, page: () => MobAnalyticsScreen(),transition: Transition.leftToRight),
  ];
}