import 'package:flutter/material.dart';
import 'package:leamapp/common/models/app_colors.dart';

class Loading extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final EdgeInsets padding;
  final Color backgroundColor;

  const Loading(
      {Key key,
      this.color = MyColors.appMain100,
      this.height,
      this.width,
      this.padding,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      alignment: Alignment.center,
      child: Center(
          child: CircularProgressIndicator(
        backgroundColor: backgroundColor ?? Colors.white,
        valueColor: new AlwaysStoppedAnimation<Color>(color),
      )),
    );
  }
}
