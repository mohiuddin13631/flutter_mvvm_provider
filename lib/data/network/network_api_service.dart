import 'dart:convert';
import 'dart:html';
import 'dart:io';

import 'package:mvvm/data/app_exception.dart';
import 'package:mvvm/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiServices{

  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try{
      final response = await http.get(Uri.parse(url));

      responseJson = returnResponse(response);
    }on SocketException { //its throw when network related problem
      throw FetchDataException("No internet connection");
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, data) async {
    dynamic responseJson;
    try{
      final response = await http.post(
        Uri.parse(url),
        body: data
      );
      responseJson = returnResponse(response);
    }on SocketException {
      throw FetchDataException("No internet connection");
    }

    return responseJson;
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