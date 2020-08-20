import 'package:flutter/material.dart';

class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.only(left: 110.0), child: Text("STATUS")),
      ),
      drawer: showDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/img/bg.JPG"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,  
            children: <Widget>[
              Container(margin: EdgeInsets.only(top: 400.0), width: 220.0,
                child: ClipRRect(
                //ลดเหลี่ยมปุ่ม
                borderRadius: BorderRadius.circular(50),
                child: RaisedButton(color: Colors.teal[400],
                  child: Text("HISTORY",style: TextStyle(color: Colors.white),),
                  onPressed: (){}  
                ), 
              )
              )
            ],
          )
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
          showManual()
        ],
      ));

  ListTile showCONTROL() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text("CONTROL"),
    );
  }

  ListTile showalertchick() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text("แจ้งเตือนเมื่อลูกไก่เกิด"),
    );
  }

  ListTile showalertTH() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text("แจ้งเตือนอุณหภูมิและความชื้น"),
    );
  }

  ListTile showChickdata() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text("ข้อมูลไก่"),
    );
  }

  ListTile showManual() {
    return ListTile(
      leading: Icon(Icons.android),
      title: Text("คู่มือการใช้งาน"),
    );
  }
}
