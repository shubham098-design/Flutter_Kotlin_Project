import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_eccomerce_app_with_mongodb/data/model/user_model.dart';
import 'package:u_eccomerce_app_with_mongodb/logic/cubits/user_state.dart';

import '../../data/repository/user_repository.dart';
import '../services/preferences.dart';



class UserCubit extends Cubit<UserState> {

  UserCubit() : super(UserIntitialState()){
    _intialize();
  }

  final UserRepository _userRepository = UserRepository();

  void _intialize() async{
    final UserDetails = await Preferences.fetchUserDetails();
    String? email = UserDetails["email"];
    String? password = UserDetails["password"];
    if(email == null || password == null){
      emit(UserLoggedOutState());
    }else{
      signIn(email: email, password: password);
    }
  }


  void _emitLoggedInState({required UserModel userModel, required String email, required String password}) async{
    await Preferences.saveUserDetails(email, password);
    emit(UserLoggedInState(userModel));
  }

  void signIn({required String email, required String password}) async{
    try{
      emit(UserLoadingState());
      UserModel userModel = await _userRepository.signIn(email: email, password: password);
      _emitLoggedInState(userModel: userModel, email: email, password: password);

    }catch(ex){
      emit(UserErrorState(ex.toString()));
    }
  }

  void createUser({required String email, required String password}) async{
    try{
      emit(UserLoadingState());
      UserModel userModel = await _userRepository.createAccount(email: email, password: password);
      _emitLoggedInState(userModel: userModel, email: email, password: password);
    }catch(ex){
      emit(UserErrorState(ex.toString()));
    }
  }

  Future<bool> updateUser(UserModel userModel) async {
    emit( UserLoadingState() );
    try {
      UserModel updatedUser = await _userRepository.updateUser(userModel);
      emit( UserLoggedInState(updatedUser) );
      return true;
    }
    catch(ex) {
      emit( UserErrorState(ex.toString()) );
      return false;
    }
  }

  void signOut() async{
    await Preferences.clear();
    emit(UserLoggedOutState());
  }


}