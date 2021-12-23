import 'package:flutter/material.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function onTap;

  const AppButton({Key key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: BorderSide(color: AppColors.blueButton),
        padding: const EdgeInsets.all(15.0),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.lightOrange,
        ),
      ),
    );
  }
}
