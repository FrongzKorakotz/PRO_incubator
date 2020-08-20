import 'package:flutter/material.dart';
import 'package:incubator/screen/QRlogin.dart';
import 'package:incubator/screen/Status.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "incubator",
      home: Status(),
    );
  }
}
