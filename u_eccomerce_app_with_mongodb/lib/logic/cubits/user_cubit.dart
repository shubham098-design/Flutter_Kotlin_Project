import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_eccomerce_app_with_mongodb/data/model/user_model.dart';
import 'package:u_eccomerce_app_with_mongodb/logic/cubits/user_state.dart';

import '../../data/repository/user_repository.dart';

class UserCubit extends Cubit<UserState> {

  UserCubit() : super(UserIntitialState());

  final UserRepository _userRepository = UserRepository();

  void signIn({required String email, required String password}) async{
    try{
      emit(UserLoadingState());
      UserModel userModel = await _userRepository.signIn(email: email, password: password);
      emit(UserLoggedInState(userModel));
    }catch(ex){
      emit(UserErrorState(ex.toString()));
    }
  }

  void createUser({required String email, required String password}) async{
    try{
      emit(UserLoadingState());
      UserModel userModel = await _userRepository.createAccount(email: email, password: password);
      emit(UserLoggedInState(userModel));
    }catch(ex){
      emit(UserErrorState(ex.toString()));
    }
  }
}