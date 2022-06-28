import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterandroidappforwordpress/provider/category_provider.dart';
import 'package:flutterandroidappforwordpress/provider/post_provider.dart';
import 'package:flutterandroidappforwordpress/utils/utils.dart';
import 'package:flutterandroidappforwordpress/listcategory_page.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static String name = "SplashScreenPage2";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    Provider.of<Postprovider>(context, listen: false).getlatestpost();
    Provider.of<CategoryProvider>(context, listen: false)
        .getCategory();
    return Timer(const Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    // Navigator.pop(context);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const ListcategoryPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.white70],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                Utils.splashicon,
                scale: 3,
              ),
              const Text(
                Utils.appame,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 150,
                  child: LinearProgressIndicator(
                    minHeight: 10,
                    backgroundColor: Colors.black,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
