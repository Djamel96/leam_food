import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:leamapp/common/models/app_colors.dart';

toastSucces(BuildContext context, String message) {
  Flushbar(
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.fromLTRB(40, 80, 40, 0),
    animationDuration: const Duration(milliseconds: 500),
    borderRadius: BorderRadius.circular(32),
    backgroundColor: MyColors.aquamarine,
    messageText: Text(
      message,
      style: const TextStyle(
          color: MyColors.white_two,
          fontWeight: FontWeight.w500,
          fontFamily: "Metropolis",
          fontStyle: FontStyle.normal,
          fontSize: 16.0),
    ),
    flushbarPosition: FlushbarPosition.TOP,
    shouldIconPulse: false,
    icon: const Icon(
      Icons.check_circle,
      color: Colors.white,
    ),
    flushbarStyle: FlushbarStyle.FLOATING,
    duration: const Duration(seconds: 2),
  ).show(context);
}

Future toastAlert(BuildContext context, String message,
    {int duration = 3, double horizal = 40}) async {
  Flushbar(
    padding: const EdgeInsets.all(16),
    margin: EdgeInsets.fromLTRB(horizal, 80, horizal, 0),
    animationDuration: const Duration(milliseconds: 500),
    borderRadius: BorderRadius.circular(32),
    backgroundColor: MyColors.orange_pink,
    // message: "hellooooooooooo fdfjd oid fdf ",
    messageText: Text(
      message,
      style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontFamily: "Metropolis",
          fontStyle: FontStyle.normal,
          fontSize: 16.0),
    ),
    flushbarPosition: FlushbarPosition.TOP,
    shouldIconPulse: true,
    icon: const Icon(
      Icons.info,
      color: Colors.white,
    ),
    flushbarStyle: FlushbarStyle.FLOATING,
    duration: Duration(seconds: duration),
  ).show(context);
}

toastError(BuildContext context,
    {String message = "An error occured, try again"}) {
  Flushbar(
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.fromLTRB(30, 80, 30, 0),
    animationDuration: const Duration(milliseconds: 500),
    borderRadius: BorderRadius.circular(32),
    backgroundColor: MyColors.red235,
    // message: "hellooooooooooo fdfjd oid fdf ",
    messageText: Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Text(
        message,
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontFamily: "Metropolis",
            fontStyle: FontStyle.normal,
            fontSize: 16.0),
      ),
    ),
    flushbarPosition: FlushbarPosition.TOP,
    shouldIconPulse: true,
    icon: const Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: Icon(
        Icons.error,
        color: Colors.white,
      ),
    ),

    flushbarStyle: FlushbarStyle.FLOATING,
    duration: const Duration(seconds: 2),
  ).show(context);
}
