import 'package:flutter/material.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';

class LanguageButton extends StatelessWidget {
  final whiteStyle = TextStyle(color: Colors.white);
  final Function onSelect;

  LanguageButton({@required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 150,
      decoration: BoxDecoration(
        color: AppColors.blueButton,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                onSelect?.call("Ar");
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "ع",
                  textAlign: TextAlign.center,
                  style: whiteStyle,
                ),
              ),
            ),
          ),
          VerticalDivider(
            indent: 6,
            endIndent: 6,
            width: 1,
            thickness: 1,
            color: Colors.white,
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                onSelect?.call("En");
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "En",
                  textAlign: TextAlign.center,
                  style: whiteStyle,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
