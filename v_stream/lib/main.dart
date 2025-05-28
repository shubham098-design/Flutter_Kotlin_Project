
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:v_stream/route/routes.dart';
import 'package:v_stream/route/routes_name.dart';
import 'package:v_stream/services/shared_preferences.dart';
import 'package:v_stream/services/supabase_services.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(const MyApp());
  Get.put(SupabaseServices());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  SharedPreferencesService sharedPreferencesService = SharedPreferencesService();
  String? storedUuid;

  @override
  void initState() {
    super.initState();
    getUuId();
  }

  void getUuId() async {
    storedUuid = await sharedPreferencesService.getUuid();
    print("Stored UUID: $storedUuid");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (storedUuid == null) {
      return const Center(child: CircularProgressIndicator()); // ya splash screen
    }
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      getPages: Routes.page,
      initialRoute: storedUuid != null
          ? RoutesName.bottom_navigation_bar_route
          : RoutesName.login_screen_route,

    );
  }

}

