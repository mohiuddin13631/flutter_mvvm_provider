import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{

  static void fieldFocusChange(
      BuildContext context,
      FocusNode current,
      FocusNode nextFocus
      ){
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
    );
  }

  static void flushBarErrorMessage(String message, BuildContext context){
    showFlushbar(context: context,
        flushbar: Flushbar(
          message: message,
          padding: EdgeInsets.all(15),
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.TOP,
          borderRadius: BorderRadius.circular(12),
          backgroundColor: Colors.red,
          margin: EdgeInsets.all(15),
          reverseAnimationCurve: Curves.easeInOut,
          icon: Icon(Icons.error_rounded,color: Colors.white,size: 25,),
        )..show(context),
    );
  }

}