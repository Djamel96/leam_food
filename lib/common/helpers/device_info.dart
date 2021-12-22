import 'package:flutter/material.dart';

double getScreenWidth(BuildContext context, double percentage) {
  return MediaQuery.of(context).size.width * percentage;
}

double getScreenHeight(BuildContext context, double percentage) {
  return MediaQuery.of(context).size.height * percentage;
}
