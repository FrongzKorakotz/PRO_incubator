import 'package:flutter/material.dart';
import 'package:incubator/screen/control.dart';
import 'package:incubator/screen/Alertchick.dart';
import 'package:incubator/screen/Chickdata.dart';
import 'package:incubator/screen/Manual.dart';

class Alertth extends StatefulWidget {
  @override
  _AlertthState createState() => _AlertthState();
}

class _AlertthState extends State<Alertth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.only(left: 90.0), child: Text("ALERTTH")),
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
          showChickdata(),
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