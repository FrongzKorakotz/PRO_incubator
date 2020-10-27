import 'package:flutter/material.dart';
import 'package:incubator/screen/Chickdata.dart';
import 'package:incubator/screen/Control.dart';
import 'package:incubator/screen/ControlM.dart';
import 'package:incubator/screen/QRlogin.dart';
import 'package:incubator/screen/SaveChick.dart';
import 'package:incubator/screen/Status.dart';
import 'package:incubator/data/firebase.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  const fiveSeconds = const Duration(seconds: 1);
  const threeMin = const Duration(seconds: 180);
  Timer.periodic(fiveSeconds, (Timer t) => readatatemp());
  Timer.periodic(fiveSeconds, (Timer t) => readatahum());
  Timer.periodic(fiveSeconds, (Timer t) => readatatemp2());
  Timer.periodic(fiveSeconds, (Timer t) => readatahum2());
  Timer.periodic(fiveSeconds, (Timer t) => readatatemp3());
  Timer.periodic(fiveSeconds, (Timer t) => readatahum3());
  Timer.periodic(fiveSeconds, (Timer t) => showchickselect());
  Timer.periodic(fiveSeconds, (Timer t) => qrFormat1());
  Timer.periodic(fiveSeconds, (Timer t) => qrFormat2());
  Timer.periodic(fiveSeconds, (Timer t) => qrFormat3());
  Timer.periodic(fiveSeconds, (Timer t) => dateNowR());
  Timer.periodic(fiveSeconds, (Timer t) => dateNowR2());
  Timer.periodic(fiveSeconds, (Timer t) => dateNowR3());
  Timer.periodic(fiveSeconds, (Timer t) => deteEndR());
  Timer.periodic(fiveSeconds, (Timer t) => deteEndR2());
  Timer.periodic(fiveSeconds, (Timer t) => deteEndR3());
  Timer.periodic(fiveSeconds, (Timer t) => passQrR());
  Timer.periodic(fiveSeconds, (Timer t) => passQrR2());
  Timer.periodic(fiveSeconds, (Timer t) => passQrR3());
  Intl.defaultLocale = 'th';
  initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue[900]),
      debugShowCheckedModeBanner: false,
      title: "incubator",
      home: SaveChick(),
    );
  }
}
