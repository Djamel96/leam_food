import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:renovation_core/core.dart';
import 'app_boot.dart';
import 'common/api.dart';
import 'common/models/app_colors.dart';
import 'main_store.dart';

void main() async {
  final renovationInstance = Renovation();

  await renovationInstance.init(Apis.root, useJWT: true);
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => MainStore()),
    ], child: const MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MainStore>(builder: (context, MainStore mainStore, _) {
      return GetMaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English
        ],
        debugShowCheckedModeBanner: true,
        title: "OFood",
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: MyColors.appMain100,
          backgroundColor: Colors.white,
        ),
        home: const AppBoot(),
      );
    });
  }
}
