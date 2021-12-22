import 'package:flutter/material.dart';
import 'package:leamapp/common/models/app_colors.dart';

import 'default_loading.dart';

class RoundedButton extends StatelessWidget {
  final double width;
  final double height;
  final Widget content;
  final Color backgroundColor;
  final Color splashColor;
  final Function onPressed;
  final Border border;
  final List<BoxShadow> shadow;
  final EdgeInsets contentPadding;
  final double marginHorizontal;
  final bool isLoading;
  final bool active;

  RoundedButton({
    this.width,
    this.height,
    this.content,
    this.onPressed,
    this.backgroundColor = MyColors.appMain100,
    this.splashColor = MyColors.buttonSplash,
    this.shadow,
    this.border,
    this.contentPadding,
    this.marginHorizontal = 0,
    this.isLoading = false,
    this.active = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
          decoration: BoxDecoration(
              color: active
                  ? (backgroundColor ?? MyColors.appMain100)
                  : MyColors.appMain50,
              border: border,
              borderRadius: BorderRadius.circular(32),
              boxShadow: !active
                  ? null
                  : (shadow ??
                      [
                        BoxShadow(
                            color: MyColors.buttonShadow1,
                            offset: Offset(0, 6),
                            blurRadius: 6,
                            spreadRadius: -1),
                        BoxShadow(
                            color: MyColors.buttonShadow1,
                            offset: Offset(0, 0),
                            blurRadius: 1,
                            spreadRadius: 0)
                      ])),
          child: Material(
            color: Colors.transparent,
            child: SizedBox(
              height: height ?? 62,
              width: width ?? double.infinity,
              child: InkWell(
                splashColor: splashColor,
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Center(
                  child: Padding(
                    padding:
                        contentPadding ?? EdgeInsets.all(isLoading ? 0 : 20.0),
                    child: isLoading
                        ? const Loading(
                            height: 20,
                            width: 20,
                          )
                        : content,
                  ),
                ),
                onTap: () {
                  onPressed();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
