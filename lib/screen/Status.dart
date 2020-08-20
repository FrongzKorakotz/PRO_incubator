import 'package:flutter/material.dart';

class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}



class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("MENU"),),
      drawer: showDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/img/bg.JPG"),
            fit: BoxFit.cover
          ),
        ),
      ),
    );
    }

  Drawer showDrawer() => Drawer(
    child: ListView(
      children: <Widget>[
        showCONTROL(),showalertchick(),showalertTH(),showChickdata(),showManual()
      ],
    )
  );

  ListTile showCONTROL() {
    return ListTile(
        leading:Icon(Icons.android),
        title: Text("CONTROL"),
      );
  }
    ListTile showalertchick() {
    return ListTile(
        leading:Icon(Icons.android),
        title: Text("แจ้งเตือนเมื่อลูกไก่เกิด"),
      );
  }
    ListTile showalertTH() {
    return ListTile(
        leading:Icon(Icons.android),
        title: Text("แจ้งเตือนอุณหภูมิและความชื้น"),
      );
  }
    ListTile showChickdata() {
    return ListTile(
        leading:Icon(Icons.android),
        title: Text("ข้อมูลไก่"),
      );
  }
    ListTile showManual() {
    return ListTile(
        leading:Icon(Icons.android),
        title: Text("คู่มือการใช้งาน"),
      );
  }
  
  }