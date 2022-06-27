import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutterandroidappforwordpress/provider/otherprovider.dart';
import 'package:flutterandroidappforwordpress/pages/homepage.dart';
import 'provider/category_provider.dart';

import 'provider/post_provider.dart';
import 'provider/webview_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'provider/youtube_api_provider.dart';
import 'SplashScreen.dart';

Future<void> main() async {
  configLoading();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final dir = await getApplicationDocumentsDirectory();
  await Hive.openBox("voltagelabbadge");
  Hive.init(dir.path);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ChangeNotifierProvider(create: (context) => Postprovider()),
      ChangeNotifierProvider(create: (context) => Webcontroll()),
      ChangeNotifierProvider(create: (context) => YoutubeApiprovider()),
      ChangeNotifierProvider(create: (context) => Otherprovider()),
    ],
    child: MyApp(),
  ));
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.black
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Colors.red
    ..textColor = Colors.black
    ..maskColor = Colors.black.withOpacity(0.7)
    ..userInteractions = true
    ..dismissOnTap = false;
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darktheme = Provider.of<Otherprovider>(context);
    return MaterialApp(
      // theme: ThemeData(brightness: Brightness.light),
      theme: darktheme.themeData,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}
