import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:mvvm/model/movie_list_model.dart';
import '../data/network/base_api_services.dart';
import '../data/network/network_api_service.dart';
import '../res/components/api_urls.dart';

class HomeRepository{

  BaseApiServices _apiServices = NetworkApiService();

  Future<MovieListModel?>fetchMoviesList()async{
    try{

      MovieListModel movieListModel;
      dynamic response = await _apiServices.getGetApiResponse(ApiUrls.movieListEndPoint); //if success stored decode data
      movieListModel = MovieListModel.fromJson(response);
      return movieListModel;//return data

    }catch(exception){
      if(kDebugMode){
        print(exception);
      }
    }
  }

}