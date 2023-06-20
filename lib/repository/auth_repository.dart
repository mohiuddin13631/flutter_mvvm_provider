import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:mvvm/data/network/network_api_service.dart';
import 'package:mvvm/res/components/api_urls.dart';

import '../data/network/base_api_services.dart';

class AuthRepository{

  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginApi(dynamic data)async{
    try{

      dynamic response =  _apiServices.getPostApiResponse(ApiUrls.loginUrl, data);

      return response;
    }catch(exception){
      if(kDebugMode){
        print(exception);
      }
    }
  }

  Future<dynamic> signUpApi(dynamic data)async{
    try{

      dynamic response =  _apiServices.getPostApiResponse(ApiUrls.signupUrl, data);

      return response;
    }catch(exception){
      if(kDebugMode){
        print(exception);
      }
    }

  }

}