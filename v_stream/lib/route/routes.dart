import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:v_stream/features/bottom_bar/bottom_navigation.dart';
import 'package:v_stream/features/channel/screens/main_screen.dart';
import 'package:v_stream/features/channel/screens/shorts_screen.dart';
import 'package:v_stream/features/home/screens/channel/channel_main_screen.dart';
import 'package:v_stream/features/home/screens/search_screen.dart';
import 'package:v_stream/features/home/screens/video_playing_screen.dart';
import 'package:v_stream/features/shorts/screen/shorts_screen.dart';
import 'package:v_stream/route/routes_name.dart';

import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/signup_screen.dart';
import '../features/channel/screens/home_screen.dart';
import '../features/home/screens/category_screen.dart';
import '../features/splash_screen.dart';

class Routes {
  static final page =[
    GetPage(
      name: RoutesName.splash_screen_route,
      page: () => const SplashScreen(),
    ),
    GetPage(name: RoutesName.login_screen_route, page: ()=> LoginScreen()),
    GetPage(name: RoutesName.siginup_screen_route, page: ()=> SignUpScreen()),
    GetPage(name: RoutesName.bottom_navigation_bar_route, page: ()=> BottomNavigation()),
    GetPage(name: RoutesName.video_playing_screen_route, page: ()=>VideoPlayingScreen()),
    GetPage(name: RoutesName.channel_main_screen_route, page: ()=> MainScreen()),
    GetPage(name: RoutesName.channel2_main_screen_route, page: ()=> ChannelMainScreen()),
    GetPage(name: RoutesName.short_screen_route, page: ()=> ShortsScreen()),
    GetPage(name: RoutesName.search_screen_route, page: ()=> SearchScreen()),
    GetPage(name: RoutesName.category_screen_route, page: ()=> CategoryScreen()),

  ];
}