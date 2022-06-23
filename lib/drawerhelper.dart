import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DrawerHelper {
  static final defaultColor = Color.fromRGBO(0, 116, 255, 1);
  static final textColor = Colors.black;

  static final items = <Widget> [
    const Icon(Icons.home, size: 30,),
    const Icon(Icons.add, size: 30),
    const Icon(Icons.compare_arrows, size: 30),
    const Icon(Icons.list, size: 30),
    const Icon(Icons.compare_arrows, size: 30),
  ];
}
