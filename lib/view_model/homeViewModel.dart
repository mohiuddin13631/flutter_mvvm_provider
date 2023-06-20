import 'package:flutter/cupertino.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/movie_list_model.dart';
import 'package:mvvm/repository/home_repository.dart';

class HomeViewViewModel with ChangeNotifier{

  final myRepo = HomeRepository();

  ApiResponse<MovieListModel> moviesList = ApiResponse.loading();

  setMoviesList(ApiResponse<MovieListModel> response){
    moviesList = response;
    notifyListeners();
  }

  Future<void> fetchMovesListApi() async {
    setMoviesList(ApiResponse.loading());
    myRepo.fetchMoviesList().then((value) { //if success then , value = returned data fetchMoviesList

      setMoviesList(ApiResponse.completed(value));
      print("value: $value");

    }).onError((error, stackTrace) {
      ApiResponse.error(error.toString());
    });
  }

}