import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/cubits/user_cubit.dart';
import '../../../../logic/cubits/user_state.dart';

class LoginProvider with ChangeNotifier{
  final BuildContext context;
  LoginProvider(this.context){
    listenToUserCubit();
  }

  bool isLoading = false;
  String error = "";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  StreamSubscription? _userSubscription;

  void listenToUserCubit() {

    print("----------------------------listenToUserCubit----------------------------");
    _userSubscription = BlocProvider.of<UserCubit>(context).stream.listen((userState) {
      if(userState is UserLoadingState) {
        isLoading = true;
        error = "";
        notifyListeners();
      }
      else if(userState is UserErrorState) {
        isLoading = false;
        error = userState.message;
        notifyListeners();
      }else {
        isLoading = false;
        error = "";
        notifyListeners();
      }
    });
  }


  void login() async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    BlocProvider.of<UserCubit>(context).signIn(email: email, password: password);

  }

  @override
  void dispose() {
    _userSubscription?.cancel();
    super.dispose();
  }
}