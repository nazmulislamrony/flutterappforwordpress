import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterandroidappforwordpress/Provider/category_provider.dart';
import 'package:flutterandroidappforwordpress/Provider/post_provider.dart';
import 'package:flutterandroidappforwordpress/helper/utils.dart';
import 'package:flutterandroidappforwordpress/listcategory_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static String name = "SplashScreenPage2";

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
    Provider.of<Postprovider>(context, listen: false).getvoltagelablatestpost();
    Provider.of<CategoryProvider>(context, listen: false)
        .get_bn_vl_free_category();
    return Timer(const Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    // Navigator.pop(context);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => const ListcategoryPage ()));
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
            const  Text(
                Utils.appame,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 150,
                  child: const LinearProgressIndicator(
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
