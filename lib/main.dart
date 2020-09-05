import 'package:flutter/material.dart';
import 'package:incubator/screen/Control.dart';
import 'package:incubator/screen/QRlogin.dart';
import 'package:incubator/screen/Status.dart';
import 'package:incubator/data/firebase.dart';
import 'dart:async';

void main() {
  const fiveSeconds = const Duration(seconds: 1);
  Timer.periodic(fiveSeconds, (Timer t) => readatatemp());
  Timer.periodic(fiveSeconds, (Timer t) => readatahum());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(primaryColor: Colors.blue[900]),
    debugShowCheckedModeBanner: false,
      title: "incubator",
      home: Status(),
    );
  }
}
