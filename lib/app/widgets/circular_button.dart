import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';

class CircularButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final Alignment textAlignment;
  final double padding;
  final double size;
  final ButtonType buttonType;
  final bool isOrange;
  final String keyFrontBottom = "frontBottom";
  final String keyFrontLeft = "frontLeft";
  final String keyBackLeft = "backLeft";
  final String keyBackTop = "backTop";
  final String keyFrontHeight = "frontHeight";
  final String keyBackHeight = "frontBack";

  CircularButton(
    this.text, {
    this.onTap,
    this.textAlignment = Alignment.center,
    this.padding = 0,
    this.size = 180,
    this.buttonType = ButtonType.RIGHT,
    this.isOrange = true,
  });

  HashMap<String, double> setPositions() {
    switch (buttonType) {
      case ButtonType.LEFT:
        {
          return HashMap<String, double>.from({
            keyFrontBottom: size * 0.05,
            keyFrontLeft: size * 0.02,
            keyBackTop: size * 0.09,
            keyBackLeft: size * 0.01,
            keyFrontHeight: size * 0.925,
            keyBackHeight: size * 0.875,
          });
        }
        break;
      case ButtonType.RIGHT:
        return HashMap<String, double>.from({
          keyFrontBottom: size * 0.05,
          keyFrontLeft: size * 0.01,
          keyBackTop: size * 0.08,
          keyBackLeft: size * 0.05,
          keyFrontHeight: size * 0.89,
          keyBackHeight: size * 0.875,
        });
        break;
      case ButtonType.TOP:
        return HashMap<String, double>.from({
          keyFrontBottom: size * 0.05,
          keyFrontLeft: size * 0.04,
          keyBackTop: size * 0.02,
          keyBackLeft: size * 0.02,
          keyFrontHeight: size * 0.89,
          keyBackHeight: size * 0.875,
        });
        break;
      case ButtonType.BOTTOM:
        return HashMap<String, double>.from({
          keyFrontBottom: size * 0.0,
          keyFrontLeft: size * 0.0,
          keyBackTop: size * 0.07,
          keyBackLeft: size * 0.05,
          keyFrontHeight: size * 0.89,
          keyBackHeight: size * 0.875,
        });
        break;
    }
    return HashMap();
  }

  @override
  Widget build(BuildContext context) {
    HashMap<String, double> positions = setPositions();

    return Container(
      height: size * 0.98,
      width: size * 0.98,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Positioned(
            top: positions[keyBackTop],
            left: positions[keyBackLeft],
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: padding),
              alignment: textAlignment,
              child: Text(
                text.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              height: positions[keyBackHeight],
              width: positions[keyBackHeight],
              decoration: BoxDecoration(
                color: isOrange ? AppColors.lightOrange : AppColors.blueButton,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: positions[keyFrontBottom],
            left: positions[keyFrontLeft],
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(80),
              child: Container(
                height: positions[keyFrontHeight],
                width: positions[keyFrontHeight],
                decoration: BoxDecoration(
                  border: Border.all(
                      color: isOrange
                          ? AppColors.blueButton
                          : AppColors.lightOrange),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum ButtonType {
  LEFT,
  RIGHT,
  TOP,
  BOTTOM,
}
