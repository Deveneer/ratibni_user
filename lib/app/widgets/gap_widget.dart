import 'package:flutter/material.dart';

class VerticalGap extends StatelessWidget {
  final double gap;

  VerticalGap({this.gap = 8});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: gap,
    );
  }
}

class HorizontalGap extends StatelessWidget {
  final double gap;

  HorizontalGap({this.gap = 8});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: gap,
    );
  }
}
