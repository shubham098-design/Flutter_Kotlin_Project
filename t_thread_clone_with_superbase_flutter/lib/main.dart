import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_thread_clone_with_superbase_flutter/routes/route.dart';
import 'package:t_thread_clone_with_superbase_flutter/routes/routes_name.dart';
import 'package:t_thread_clone_with_superbase_flutter/services/storage_services.dart';
import 'package:t_thread_clone_with_superbase_flutter/services/supabase_service.dart';
import 'package:t_thread_clone_with_superbase_flutter/theme/theme.dart';
import 'package:t_thread_clone_with_superbase_flutter/views/HomePage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  Get.put(SupabaseServices());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Thread App',
      theme:theme,
      getPages: Routes.pages,
      initialRoute: StorageServices.userSession !=null ? RouteName.home : RouteName.login,
      defaultTransition: Transition.noTransition,

    );
  }
}

