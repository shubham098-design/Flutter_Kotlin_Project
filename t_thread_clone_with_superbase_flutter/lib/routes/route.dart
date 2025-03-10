import 'package:get/route_manager.dart';
import 'package:t_thread_clone_with_superbase_flutter/routes/routes_name.dart';
import 'package:t_thread_clone_with_superbase_flutter/views/profile/edit_profile.dart';
import 'package:t_thread_clone_with_superbase_flutter/views/replies/add_reply.dart';
import 'package:t_thread_clone_with_superbase_flutter/views/setting/setting.dart';
import 'package:t_thread_clone_with_superbase_flutter/views/thread/show_image.dart';
import 'package:t_thread_clone_with_superbase_flutter/views/thread/show_thread.dart';

import '../views/HomePage.dart';
import '../views/auth/login_page.dart';
import '../views/auth/register_page.dart';
import '../views/profile/show_user.dart';

class Routes {
  static final pages = [
    GetPage(name: RouteName.home, page: ()=> Homepage()),
    GetPage(name: RouteName.login, page: ()=>  LoginPage()),
    GetPage(name: RouteName.register, page: ()=>  RegisterPage()),
    GetPage(name: RouteName.edit, page: ()=>  EditProfile(),transition: Transition.leftToRight),
    GetPage(name: RouteName.setting, page: ()=>  Setting(),transition: Transition.rightToLeft),
    GetPage(name: RouteName.addReply, page: ()=>  AddReply(),transition: Transition.downToUp),
    GetPage(name: RouteName.showThread, page: ()=>  ShowThread(),transition: Transition.leftToRight),
    GetPage(name: RouteName.showImage, page: ()=>  ShowImage(),transition: Transition.leftToRight),
    GetPage(name: RouteName.showProfile, page: ()=>  ShowProfile(),transition: Transition.leftToRight),
  ];
}