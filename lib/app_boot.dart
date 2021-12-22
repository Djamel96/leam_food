import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leamapp/splash_screen.dart';
import 'package:leamapp/tab_view_main.dart';

import 'package:provider/provider.dart';
import 'package:renovation_core/core.dart';

import 'auth/screens/login_sc.dart';
import 'main_store.dart';
import 'onboarding/onboarding_screen.dart';

class AppBoot extends StatefulWidget {
  final int awaitSec;

  const AppBoot({Key key, this.awaitSec = 2}) : super(key: key);
  @override
  _AppBootState createState() => _AppBootState();
}

class _AppBootState extends State<AppBoot> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _firstLoad();
    });
  }

  _firstLoad() async {
    final mainStore = Provider.of<MainStore>(context, listen: false);
    // await SharedPreferencesHelper.restoreUserDataFromSheredPrefs(mainStore)
    //     .then((result) {
    //   if (result) {
    onDoneLoading(context, true);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}

Future onDoneLoading(BuildContext context, bool checkAppVersion,
    {int awaitSec = 2, bool checkTokenStatus = true}) async {
  final mainStore = Provider.of<MainStore>(context, listen: false);

  final session =
      await getFrappeAuthController().checkLogin(shouldUpdateSession: false);

  if (session.isSuccess) {
    print('Logged In: ${session.data.loggedIn}');
  } else {
    print('Not logged in');
  }

  if (session.isSuccess) {
    Get.offAll(() => const TabViewMain());
  } else {
    //SharedPreferencesHelper.clearSharedPrefs("en");
    await Future.delayed(Duration(seconds: 2));
    //
    Get.to(() => FirstOnboardingScreen());
    // Get.to(LoginScreen());
  }
  return true;
}

_initialLoad(MainStore mainStore) {}

checkAppVersionFun() async {}
