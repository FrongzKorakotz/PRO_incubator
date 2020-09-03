import 'package:flutter/material.dart';
import 'package:incubator/screen/Alertchick.dart';
import 'package:incubator/screen/Alertth.dart';
import 'package:incubator/screen/Chickdata.dart';
import 'package:incubator/screen/Manual.dart';

class Control extends StatefulWidget {
  @override
  _ControlState createState() => _ControlState();
}

class _ControlState extends State<Control> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.only(left: 90.0), child: Text("CONTROL")),
      ),
      drawer: showDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/img/bg.JPG"), fit: BoxFit.cover),
        ),  
    ),
    );
  }
Drawer showDrawer() => Drawer(
         child: ListView(
       children: <Widget>[
         showalertchick(),
         showalertTH(),
         showChickdata(),
         showManual()
        ],
     ));

  ListTile showalertchick() {
   return ListTile(
     leading: Icon(Icons.alarm),
     title: Text("แจ้งเตือนเมื่อลูกไก่เกิด"),
     onTap: () {
       Navigator.pop(context);
       MaterialPageRoute route = 
         MaterialPageRoute(builder: (value)=>Alertchick());
       Navigator.push(context, route);
     },
   );
 }

 ListTile showalertTH() {
   return ListTile(
     leading: Icon(Icons.add_alert),
     title: Text("แจ้งเตือนอุณหภูมิและความชื้น"),
     onTap: () {
       Navigator.pop(context);
       MaterialPageRoute route = 
         MaterialPageRoute(builder: (value)=>Alertth());
       Navigator.push(context, route);
     },
   );
 }

 ListTile showChickdata() {
   return ListTile(
     leading: Icon(Icons.info),
     title: Text("ข้อมูลไก่"),
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
}