import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/utils/routes/routes_name.dart';

import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier {

  bool _loading = false;
  bool get loading => _loading;

  bool _signupLoading = false;
  bool get signupLoading => _signupLoading;

  void setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  setSignupLoading(bool value){
    _signupLoading = value;
    notifyListeners();
  }

  final _myRepo = AuthRepository();

  Future<void> loginApi(dynamic data,BuildContext context)async{

    setLoading(true);
    _myRepo.loginApi(data).then((value) {//value = response

      setLoading(false);
      Utils.flushBarErrorMessage("Login successful", context);
      Navigator.pushNamed(context, RoutesName.home);

      if(kDebugMode){
        print("success response ${value.toString()}");
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      print("Error response ${error.toString()}");
    });

  }


  Future<void> signUpApi(dynamic data,BuildContext context)async{

    setLoading(true);
    _myRepo.signUpApi(data).then((value) { //value = response
      setLoading(false);
      Utils.flushBarErrorMessage("Signup successful", context);
      Navigator.pushNamed(context, RoutesName.home);
      //
      if(kDebugMode){
        print("success response ${value.toString()}");
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      print("Error response ${error.toString()}");
    });
  }

}