import 'package:flutter/material.dart';
import 'package:incubator/screen/control.dart';
import 'package:incubator/screen/Alertchick.dart';
import 'package:incubator/screen/Alertth.dart';
import 'package:incubator/screen/Chickdata.dart';

class Manual extends StatefulWidget {
  @override
  _ManualState createState() => _ManualState();
}

class _ManualState extends State<Manual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.only(left: 90.0), child: Text("MANUAL")),
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
          showChickdata(),
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
}