import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.home);
              Utils.flushBarErrorMessage("Showing error message", context);
              // Utils.toastMessage("Showing toast message");
            },
            child: Text("Login Screen")),
      ),
    );
  }
}
