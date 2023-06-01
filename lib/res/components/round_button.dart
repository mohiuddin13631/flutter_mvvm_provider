import 'package:flutter/material.dart';
import 'package:mvvm/res/colors.dart';

class RoundButton extends StatelessWidget {
  RoundButton({Key? key,required this.title,this.loading = false,required this.onPress}) : super(key: key);

  final String title;
  final bool loading;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 150,
        decoration: BoxDecoration(
          color: AppColors.greenColor,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Center(child: Text(title,style: TextStyle(color: AppColors.whiteColor,fontSize: 16),)),
      ),
    );
  }
}
