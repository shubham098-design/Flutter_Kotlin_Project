import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:r_goldsmith_shop_flutter/admine/route/route.dart';
import 'package:r_goldsmith_shop_flutter/admine/route/routes.dart';
import 'package:r_goldsmith_shop_flutter/user/pages/bottom_navigation.dart';
import 'package:r_goldsmith_shop_flutter/user/pages/h_home_screen.dart';
import 'package:r_goldsmith_shop_flutter/user/route/route.dart';
import 'package:r_goldsmith_shop_flutter/user/route/routes.dart';
import 'package:r_goldsmith_shop_flutter/user/services/shared_pref_services.dart';
import 'package:r_goldsmith_shop_flutter/user/services/storage_service.dart';
import 'package:r_goldsmith_shop_flutter/user/services/supabase_services.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  await SharedPrefServices.init();
  Get.put(SupabaseServices());
  runApp(const MyAppUser());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      getPages: AdmineRoute.page,
      initialRoute:StorageService.userSession !=null ? AdmineRouteNames.mob_dashboard_screen : AdmineRouteNames.mob_onboarding_screen,
      defaultTransition: Transition.noTransition,
    );
  }
}

class MyAppUser extends StatelessWidget {
  const MyAppUser({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Jewellery App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      getPages: UserRoute.page,
      initialRoute:StorageService.userSession !=null ? RoutesName.bottomNavigation : RoutesName.onBoarding,
    );
  }
}


