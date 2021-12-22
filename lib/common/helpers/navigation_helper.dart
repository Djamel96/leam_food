import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leamapp/tab_view_main.dart';

navigateCounselorMenu(BuildContext context, int index) {
  Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) {
            animation = Tween(begin: 0.0, end: 1.0).animate(animation);
            return FadeTransition(
                opacity: animation,
                child: TabViewMain(
                  initialPage: index,
                ));
          },
          fullscreenDialog: false,
          opaque: false));
}
