import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:incubator/data/firebase.dart';
String tempupdat = '0';
String humupdat = '0';
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
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,          
            children: <Widget>[
              Column(
          children: [
            Text('Temputarure:',style: TextStyle(fontSize: 50,color: Colors.red[300])),
            Text(tempupdat.toString(),style: TextStyle(fontSize: 50)),
              ],
           ),
              Column(
                
          children: [
            Text('Humudity:',style: TextStyle(fontSize: 50,color: Colors.blue[300])),
            Text(humupdat.toString(),style: TextStyle(fontSize: 50)),
              ],
           ),
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
      leading: Icon(Icons.settings),
      title: Text("CONTROL"),
    );
  }

  ListTile showalertchick() {
    return ListTile(
      leading: Icon(Icons.alarm),
      title: Text("แจ้งเตือนเมื่อลูกไก่เกิด"),
    );
  }

  ListTile showalertTH() {
    return ListTile(
      leading: Icon(Icons.add_alert),
      title: Text("แจ้งเตือนอุณหภูมิและความชื้น"),
    );
  }

  ListTile showChickdata() {
    return ListTile(
      leading: Icon(Icons.info),
      title: Text("ข้อมูลไก่"),
    );
  }

  ListTile showManual() {
    return ListTile(
      leading: Icon(Icons.help),
      title: Text("คู่มือการใช้งาน"),
    );
  }
}


void readatatemp(){
    tempRef.once().then((DataSnapshot dataSnapshot){
      var tempupd = dataSnapshot.value.toString();
      tempupdat = tempupd;
      print(tempupdat);
    });
}
void readatahum(){
  humRef.once().then((DataSnapshot dataSnapshot){
    var humupd = dataSnapshot.value.toString();
    humupdat = humupd;
    print(humupdat);
  });
}
