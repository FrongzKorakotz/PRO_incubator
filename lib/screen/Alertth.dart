import 'package:flutter/material.dart';
import 'package:incubator/screen/Log.dart';
import 'package:incubator/screen/SaveChick.dart';
import 'package:incubator/screen/Status.dart';
import 'package:incubator/screen/control.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:incubator/screen/Chickdata.dart';
import 'package:incubator/screen/Manual.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:incubator/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class Alertth extends StatefulWidget {
  @override
  _AlertthState createState() => _AlertthState();
}

class _AlertthState extends State<Alertth> {
  Query _ref;
  @override
  void initState() {
    super.initState();
     _ref = FirebaseDatabase.instance
        .reference()
        .child('Notification')
        .orderByChild('Date');
     _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        _printMsg(message);
        showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
          content: ListTile(
              title: Text(message['notification']['title']),
           subtitle: Text(message['notification']['body']),
          ),
          actions: <Widget>[
            FlatButton(child: Text('Ok'),onPressed: ()=> Navigator.of(context).pop(),),
          ],
          
        ),);
      },
      onLaunch: (Map<String, dynamic> message) async {
        _printMsg(message);
         showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
          content: ListTile(
              title: Text(message['notification']['title']),
           subtitle: Text(message['notification']['body']),
          ),
          actions: <Widget>[
            FlatButton(child: Text('Ok'),onPressed: ()=> Navigator.of(context).pop(),),
          ],
          
        ),);
   
      },
      onResume: (Map<String, dynamic> message) async {
        _printMsg(message);
         showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
          content: ListTile(
              title: Text(message['notification']['title']),
           subtitle: Text(message['notification']['body']),
          ),
          actions: <Widget>[
            FlatButton(child: Text('Ok'),onPressed: ()=> Navigator.of(context).pop(),),
          ],
          
        ),);
   
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
  Widget _buildContactItem({Map contact}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(10),
      height: 120,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.date_range,
                color: Colors.red,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                contact['Date'],
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600),
              ),SizedBox(
                width: 10,
              ),
              Icon(
                Icons.timer,
                color: Colors.red,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                contact['Time'],
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [Text(
                "อุณหภูมิ",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                    fontWeight: FontWeight.w600),
              ),SizedBox(
                width: 10,
              ),
              Icon(
                Icons.terrain,
                color: Colors.redAccent[200],
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                contact['Temp'],
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w600),
              ),
              
            ],
          ), SizedBox(
            height: 10,
          ), Row(
            children: [
               Text(
                "ความชื้น",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.green,
                    fontWeight: FontWeight.w600),
              ),SizedBox(
                width: 10,
              ),
              Icon(
                Icons.group_work,
                color: Colors.greenAccent,
                size: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                contact['Humidity'],
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.greenAccent[200],
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Color getTypeColor(String type) {
    Color color = Theme.of(context).accentColor;

    if (type == 'Date') {
      color = Colors.green;
    }
    return color;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.only(left: 0.0), child: Text("บันทึก แจ้งเตือนอุณหภูมิ และ ความชื้น",style: TextStyle(color: Colors.blueGrey[400]),)),
            backgroundColor: Colors.yellow[300]
      ),
      drawer: showDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/img/bgx.png"), fit: BoxFit.cover),
        ),
        height: double.infinity,
        child: FirebaseAnimatedList(query: _ref, itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map contact = snapshot.value;
            return _buildContactItem(contact: contact);
          },
    ),
    ),floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          dbref.child("Notification").remove();
        },
        label: Text('Clear'),
        icon: Icon(MdiIcons.deleteCircle),
        backgroundColor: Colors.red,
      ),
    );
  }
    Drawer showDrawer() => Drawer(
          child: ListView(
        children: <Widget>[
          showIndata(),
          showCONTROL(),
          showLogdata(),
          saveChickdata(),
          showChickdata(),
          showManual()
        ],
      ));

  ListTile showCONTROL() {
    return ListTile(
      leading: Icon(MdiIcons.tableSettings),
      title: Text("ตั้งค่าตู้ฟักไข่"),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route = 
          MaterialPageRoute(builder: (value)=>Control());
        Navigator.push(context, route);
      },
    );
  }


  ListTile saveChickdata() {
    return ListTile(
      leading: Icon(Icons.info),
      title: Text("บันทึกข้อมูลของสายพันธุ์"),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SaveChick());
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
      leading: Icon(MdiIcons.temperatureCelsius),
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
      leading: Icon(MdiIcons.thermometerLines),
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