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
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/services.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<dynamic> _onBackgroundMessage(Map<String, dynamic> message) async {
  debugPrint('On background message $message');
  return Future<void>.value();
}
Future<void> main() async{
  
  const fiveSeconds = const Duration(seconds: 1);
  const threeMin = const Duration(seconds: 20000);
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
  Timer.periodic(fiveSeconds, (Timer t) => fanrun());
  Timer.periodic(fiveSeconds, (Timer t) => lightrun());
  Timer.periodic(fiveSeconds, (Timer t) => pumpinrun());
  Timer.periodic(fiveSeconds, (Timer t) => pumpoutrun());

  Intl.defaultLocale = 'th';
  initializeDateFormatting();
  Timer.periodic(threeMin, (Timer t) => openapp());
  runApp(MyApp());
  var platform = MethodChannel('flutterthailand.incubator/info');
  await platform.invokeMethod('setnotificationManager');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue[900]),
      debugShowCheckedModeBanner: false,
      title: "incubator",
      home: Control(),
    );

  }
}
