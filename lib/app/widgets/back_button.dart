import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ratibni_user/app/core/constants/app_colors.dart';
import 'package:ratibni_user/app/core/constants/assest_path.dart';

class AppBackButton extends StatefulWidget {
  final bool shouldShow;
  final Color backButtonColor;
  final customRoute;

  const AppBackButton(
      {Key key,
      @required this.shouldShow,
      this.backButtonColor,
      this.customRoute})
      : super(key: key);

  @override
  _AppBackButtonState createState() => _AppBackButtonState();
}

class _AppBackButtonState extends State<AppBackButton> {
  double actualBottomPosition = 15;
  double leftPosition = -100;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      setState(() {
        leftPosition = 15;
      });
    });
    super.initState();
  }

  showButton() {
    leftPosition = actualBottomPosition;
  }

  hideButton() {
    leftPosition = -100;
  }

  @override
  void didUpdateWidget(covariant AppBackButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.shouldShow != widget.shouldShow) {
      widget.shouldShow ? showButton() : hideButton();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          left: leftPosition,
          bottom: actualBottomPosition,
          child: InkWell(
            onTap: () {
              widget.customRoute == null
                  ? Get.back()
                  : Get.offNamed(widget.customRoute);
            },
            child: CircleAvatar(
              backgroundColor: widget.backButtonColor ?? AppColors.blueButton,
              radius: 35,
              child: ImageIcon(
                AssetImage("${AppImages.back}"),
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
