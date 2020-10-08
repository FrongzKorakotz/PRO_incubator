import 'package:flutter/material.dart';
import 'package:incubator/screen/control.dart';
import 'package:incubator/screen/Alertchick.dart';
import 'package:incubator/screen/Alertth.dart';
import 'package:incubator/screen/Chickdata.dart';
import 'package:incubator/screen/Status.dart';
import 'package:incubator/screen/Log.dart';

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
            margin: EdgeInsets.only(left: 90.0), child: Text("คู่มือการใช้งาน",style: TextStyle(color: Colors.blueGrey[400]),)),
            backgroundColor: Colors.yellow[300]
      ),
      drawer: showDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/img/bgx.png"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(children: <Widget>[
            SizedBox(height: 30,),
            Text('การแนะนำการใช้งานแอพลิเคชั่น',textAlign: TextAlign.center,style: TextStyle(fontSize: 25,color: Colors.black)),
            SizedBox(height: 20,),
             Text('1.ผู้ใช้สามารถเลือกการฟักไข่ได้ทั้งแบบกำหนดเองและแบบอัตโนมัติ',textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color: Colors.black)),
             SizedBox(height: 20,),
              Text('การเลือกแบบอัติโนมัติ',textAlign: TextAlign.center,style: TextStyle(fontSize: 25,color: Colors.black)),
              SizedBox(height: 20,),
              Text('- ผู้ใช้จะต้องเลือกตู้ที่จะฟักและเลือกสายพันธุ์ที่จะฟัก',textAlign: TextAlign.center,style: TextStyle(fontSize: 18,color: Colors.black)),
              SizedBox(height: 20,),
              Text('- ผู้ใช้จะต้องกดตกลงเพื่อทำการยืนยันที่จะฟักในตู้ฟักไข่',textAlign: TextAlign.center,style: TextStyle(fontSize: 17,color: Colors.black)),
             
          ],),
        ),
      ),
    );
  }
    Drawer showDrawer() => Drawer(
          child: ListView(
        children: <Widget>[
          showIndata(),
          showCONTROL(),
          showalertchick(),
          showLogdata(),
          showalertTH(),
          showChickdata(),
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
      title: Text("ข้อมูลของสายพันธุ์"),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route = 
          MaterialPageRoute(builder: (value)=>Chickdata());
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