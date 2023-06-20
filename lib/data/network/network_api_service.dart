import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:mvvm/data/app_exception.dart';
import 'package:mvvm/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiServices{

  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try{

      final response = await http.get(Uri.parse(url));

      responseJson = returnResponse(response); //if success return decode data
      print("Executed 201");
    }on SocketException { //its throw when network related problem
      throw FetchDataException("No internet connection");
    }

    return responseJson; //if success return decode data
  }

  @override
  Future getPostApiResponse(String url, data) async {
    dynamic responseJson;
    try{
      final response = await http.post(
        Uri.parse(url),
        body: data
      ).timeout(Duration(seconds: 20));
      // Response response = await post(
      //   Uri.parse(url),
      //   body: data
      // ).timeout(Duration(seconds: 10));

      // print("response: ${response.body}");

      responseJson = returnResponse(response);
    }on SocketException {
      throw FetchDataException("No internet connection");
    }

    return responseJson; //its return response body
  }

  dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException("Error occure while communication with server${response.statusCode}");
    }
  }

}