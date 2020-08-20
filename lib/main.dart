import 'package:flutter/material.dart';
import 'package:incubator/screen/QRlogin.dart';
import 'package:incubator/screen/Status.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(primaryColor: Colors.blue[900]),
    debugShowCheckedModeBanner: false,
      title: "incubator",
      home: QRlogin(),
    );
  }
}
