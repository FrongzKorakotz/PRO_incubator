import 'package:flutter/material.dart';
import 'package:incubator/screen/Log.dart';
import 'package:incubator/screen/Status.dart';
import 'package:incubator/screen/control.dart';
import 'package:incubator/screen/Alertth.dart';
import 'package:incubator/screen/Manual.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Chickdata extends StatefulWidget {
  @override
  _ChickdataState createState() => _ChickdataState();
}

class _ChickdataState extends State<Chickdata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.only(left: 60.0), child: Text("ข้อมูลของสายพันธุ์",style: TextStyle(color: Colors.blueGrey[400]),)),
            backgroundColor: Colors.yellow[300]
      ),
      drawer: showDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/img/bgx.png"), fit: BoxFit.cover),
        ),
    ),
    );
  }
    Drawer showDrawer() => Drawer(
          child: ListView(
        children: <Widget>[
          SizedBox(height: 20,),
          showIndata(),
          SizedBox(height: 20,),
          showCONTROL(),
          SizedBox(height: 20,),
          showalertTH(),
          SizedBox(height: 20,),  
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