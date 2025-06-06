import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:u_eccomerce_app_with_mongodb/core/api.dart';
import 'package:u_eccomerce_app_with_mongodb/data/model/user_model.dart';

class UserRepository {
  
  
  final _api = Api();
  
  Future<UserModel> createAccount({
    required String email,
    required String password,
  }) async{
    try{
      Response response = await _api.sendRequest.post("/user/createAccount",data: jsonEncode({
        "email": email,
        "password": password,
      }));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if(!apiResponse.success){
        throw apiResponse.message.toString();
      }

      // convert raw data to model

      return UserModel.fromJson(apiResponse.data);

    }catch (ex){
      rethrow;
    }
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async{
    try{
      Response response = await _api.sendRequest.post("/user/signIn",data: jsonEncode({
        "email": email,
        "password": password,
      }));

      ApiResponse apiResponse = ApiResponse.fromResponse(response);
      if(!apiResponse.success){
        throw apiResponse.message.toString();
      }
      // convert raw data to model

      return UserModel.fromJson(apiResponse.data);

    }catch (ex){
      rethrow;
    }
  }

  Future<UserModel> updateUser(UserModel userModel) async {
    try {
      Response response = await _api.sendRequest.put(
          "/user/${userModel.sId}",
          data: jsonEncode(userModel.toJson())
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if(!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return UserModel.fromJson(apiResponse.data);
    }
    catch(ex) {
      rethrow;
    }
  }

}
