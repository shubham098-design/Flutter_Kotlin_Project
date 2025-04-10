

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:r_goldsmith_shop_flutter/user/pages/a_onboarding_page.dart';
import 'package:r_goldsmith_shop_flutter/user/pages/e_product_detail_page.dart';
import 'package:r_goldsmith_shop_flutter/user/pages/f_explore_page.dart';
import 'package:r_goldsmith_shop_flutter/user/pages/h_home_screen.dart';
import 'package:r_goldsmith_shop_flutter/user/pages/i_my_profile.dart';
import 'package:r_goldsmith_shop_flutter/user/pages/j_show_earing_category.dart';
import 'package:r_goldsmith_shop_flutter/user/pages/n_my_order_screen.dart';
import 'package:r_goldsmith_shop_flutter/user/route/routes.dart';

import '../pages/b_login_page.dart';
import '../pages/bottom_navigation.dart';
import '../pages/c_signup_page.dart';
import '../pages/d_profile_page.dart';
import '../pages/k_show_braclet_category.dart';
import '../pages/l_show_bangles_category.dart';
import '../pages/m_search_product_detail_screen.dart';

class UserRoute{
  static final page = [
    GetPage(name: RoutesName.onBoarding, page: () => OnboardingPage(),transition: Transition.circularReveal),
    GetPage(name: RoutesName.login, page: () => LoginPage(),transition: Transition.leftToRight),
    GetPage(name: RoutesName.signup, page: () => SignupPage(),transition: Transition.leftToRight),
    GetPage(name: RoutesName.home, page: () => HomeScreen(),transition: Transition.leftToRight),
    GetPage(name: RoutesName.explore, page: () => ExploreScreen(),transition: Transition.leftToRight),
    GetPage(name: RoutesName.profile, page: () => ProfilePage(),transition: Transition.leftToRight),
    GetPage(name: RoutesName.productDetail, page: () => ProductDetailScreen(),transition: Transition.leftToRight),
    GetPage(name: RoutesName.bottomNavigation, page: () => BottomNavigation(),transition: Transition.leftToRight),
    GetPage(name: RoutesName.myProfile, page: () => MyProfile(),transition: Transition.leftToRight),
    GetPage(name: RoutesName.show_earing_category, page: () => ShowEaringCategory(),transition: Transition.leftToRight),
    GetPage(name: RoutesName.show_braclet_category, page: () => ShowBracletCategory(),transition: Transition.leftToRight),
    GetPage(name: RoutesName.show_bangles_category, page: () => ShowBanglesCategory(),transition: Transition.leftToRight),
    GetPage(name: RoutesName.search_product_detail_screen, page: () => SearchProductDetailScreen(),transition: Transition.leftToRight),
    GetPage(name: RoutesName.order_screen, page: () => MyOrderScreen(),transition: Transition.leftToRight),
  ];
}