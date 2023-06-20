import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/model/movie_list_model.dart';
import 'package:mvvm/repository/home_repository.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/homeViewModel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();

  // HomeRepository homeRepository = HomeRepository();
  @override
  void initState() {
    // TODO: implement initState
    homeViewViewModel.fetchMovesListApi();
    // Provider.of<HomeViewViewModel>(context,listen: false).fetchMovesListApi();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Movies list"),
        actions: [
          TextButton(onPressed: (){
            Navigator.pushNamed(context, RoutesName.login);
          }, child: Text("Logout",style: TextStyle(color: Colors.white),))
        ],
      ),
      body: ChangeNotifierProvider<HomeViewViewModel>(
        create: (BuildContext context) => homeViewViewModel,
        child: Consumer<HomeViewViewModel>(
          builder: (context, value, _) {
            switch(value.moviesList.status){
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Text(value.moviesList.message.toString());
              case Status.COMPLTED:
                return ListView.builder(
                  itemCount: value.moviesList.data!.movies!.length,
                  itemBuilder: (context, index) {
                    var movieList = value.moviesList.data!.movies![index];
                    return Card(
                      child: ListTile(
                        title: Text(value.moviesList.data!.movies![index].title.toString()),
                        subtitle: Text(value.moviesList.data!.movies![index].year.toString()),
                        leading: Image.network(value.moviesList.data!.movies![index].posterurl.toString(),
                        errorBuilder: (context, error, stackTrace) => Icon(Icons.error),),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(Utils.averageRating(movieList.ratings!).toString()),
                            Icon(Icons.star,color: Colors.yellow,)
                          ],
                        ),
                      ),
                    );
                  },
                );
            }
            return Container();
          },
        ),
      )
    );
    // return Scaffold(
    //   body: SafeArea(
    //     child: FutureBuilder(
    //       future: homeViewViewModel.fetchMovesListApi(),
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           return CircularProgressIndicator();
    //         } else if (snapshot.hasError) {
    //           return Text('Error: ${snapshot.error}');
    //         } else if (snapshot.hasData) {
    //           return ListView.builder(
    //             itemCount:snapshot.data.,
    //             itemBuilder: (context, index) {
    //               return ListTile(
    //                 title: Text(snapshot.data!.movies![index].title.toString()),
    //               );
    //             },
    //           );
    //         } else {
    //           return Text("No data found");
    //         }
    //       },
    //     ),
    //   ),
    // );
  }
}
