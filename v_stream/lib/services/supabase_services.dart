import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseServices extends GetxService{

  String SUPABASE_URL = "https://gvdcgiceycxjhvodjveq.supabase.co";
  String SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd2ZGNnaWNleWN4amh2b2RqdmVxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUyNDQ0MTIsImV4cCI6MjA2MDgyMDQxMn0.E1oYNFi2Peo7L_5xICiUpSM1stQY11kLxGKl7Swqg-c";


  Rx<User?> currentUser = Rx<User?>(null);
  static final SupabaseClient supabaseClient = Supabase.instance.client;

  @override
  void onInit() async{
    await Supabase.initialize(url: SUPABASE_URL, anonKey: SUPABASE_KEY);
    currentUser.value = supabaseClient.auth.currentUser;
    listenAuthChanges();
    super.onInit();
  }

  void listenAuthChanges() => supabaseClient.auth.onAuthStateChange.listen((data) {
    final AuthChangeEvent event = data.event;
    if(event == AuthChangeEvent.userUpdated){
      currentUser.value = data.session?.user;
    }else if(event == AuthChangeEvent.signedIn){
      currentUser.value = data.session?.user;
    }
  });


}