import 'package:flutter/material.dart';

import 'common/models/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/icons/logo.png",
                color: MyColors.appMain100,
                height: 150,
              ),
              const SizedBox(height: 20),
              const Text(
                "Leam Food",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'PlayfairDisplay',
                  letterSpacing: 1.4,
                  color: MyColors.appMain100,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ));
  }
}
