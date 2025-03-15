import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_eccomerce_app_with_mongodb/logic/cubits/user_cubit.dart';
import 'package:u_eccomerce_app_with_mongodb/logic/cubits/user_state.dart';

import '../auth/login_screen.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = "splash";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void gotoNextScreen() async{
    UserState userState = BlocProvider.of<UserCubit>(context).state;

    if(userState is UserLoggedInState){
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }else if(userState is UserLoggedOutState){
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }else if(userState is UserErrorState){
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }

  }

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      gotoNextScreen();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        gotoNextScreen();
      },
      child: const Scaffold(
        body: CircularProgressIndicator(),
      ),
    );
  }
}
