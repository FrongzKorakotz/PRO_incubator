import 'package:flutter/material.dart';
import 'package:incubator/screen/Log.dart';
import 'package:incubator/screen/Status.dart';
import 'package:incubator/screen/control.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:incubator/screen/Chickdata.dart';
import 'package:incubator/screen/Manual.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:incubator/main.dart';
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
class Alertth extends StatefulWidget {
  @override
  _AlertthState createState() => _AlertthState();
}

class _AlertthState extends State<Alertth> {

  @override
  void initState() {
    super.initState();
     _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        _printMsg(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        _printMsg(message);
      },
      onResume: (Map<String, dynamic> message) async {
        _printMsg(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {});
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print(token);
    });
    _firebaseMessaging.subscribeToTopic('info_topic');
  }
   void _printMsg(Map<String, dynamic> message) {
    print(message.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.only(left: 15.0), child: Text("แจ้งเตือนอุณหภูมิ และ ความชื้น",style: TextStyle(color: Colors.blueGrey[400]),)),
            backgroundColor: Colors.yellow[300]
      ),
      drawer: showDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/img/bgx.png"), fit: BoxFit.cover),
        ),
        child: Center(child: Column(children: <Widget>[
  
        ],),),
    ),
    );
  }
    Drawer showDrawer() => Drawer(
          child: ListView(
        children: <Widget>[
          showIndata(),
          showCONTROL(),
          showLogdata(),
          showChickdata(),
          showManual()
        ],
      ));

  ListTile showCONTROL() {
    return ListTile(
      leading: Icon(Icons.settings),
      title: Text("ตั้งค่าตู้ฟักไข่"),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route = 
          MaterialPageRoute(builder: (value)=>Control());
        Navigator.push(context, route);
      },
    );
  }


  ListTile showChickdata() {
    return ListTile(
      leading: Icon(Icons.info),
      title: Text("ข้อมูลของสายพันธุ์"),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route = 
          MaterialPageRoute(builder: (value)=>Chickdata());
        Navigator.push(context, route);
      },
    );
  }

  ListTile showManual() {
    return ListTile(
      leading: Icon(Icons.help),
      title: Text("คู่มือการใช้งาน"),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route = 
          MaterialPageRoute(builder: (value)=>Manual());
        Navigator.push(context, route);
      },
    );
  }
    ListTile showIndata() {
    return ListTile(
      leading: Icon(Icons.show_chart),
      title: Text("อุณหภูมิและความชื้น"),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Status());
        Navigator.push(context, route);
      },
    );
  }
  ListTile showLogdata() {
    return ListTile(
      leading: Icon(Icons.swap_vertical_circle),
      title: Text("ดูบันทึกอุณหภูมิและความชื้น"),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Log());
        Navigator.push(context, route);
      },
    );
  }
}