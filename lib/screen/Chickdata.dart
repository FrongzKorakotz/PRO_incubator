import 'package:flutter/material.dart';
import 'package:incubator/screen/control.dart';
import 'package:incubator/screen/Alertchick.dart';
import 'package:incubator/screen/Alertth.dart';
import 'package:incubator/screen/Manual.dart';

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
            margin: EdgeInsets.only(left: 90.0), child: Text("CHICKDATA")),
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
          showCONTROL(),
          showalertchick(),
          showalertTH(),
          showManual()
        ],
      ));

  ListTile showCONTROL() {
    return ListTile(
      leading: Icon(Icons.settings),
      title: Text("CONTROL"),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route = 
          MaterialPageRoute(builder: (value)=>Control());
        Navigator.push(context, route);
      },
    );
  }

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