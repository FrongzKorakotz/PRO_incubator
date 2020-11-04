import 'package:flutter/material.dart';
import 'package:incubator/screen/Control.dart';
import 'package:incubator/screen/ControlM.dart';
import 'package:incubator/screen/Status.dart';
import 'package:incubator/screen/control.dart';
import 'package:incubator/screen/Alertth.dart';
import 'package:incubator/screen/Manual.dart';
import 'package:incubator/screen/Chickdata.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class Log extends StatefulWidget {
  @override
  _LogState createState() => _LogState();
}

class _LogState extends State<Log> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.only(left: 30.0), child: Text("บันทึกย้อนหลังของตู้ฟักไข่",style: TextStyle(color: Colors.blueGrey[400]),)),
            backgroundColor: Colors.yellow[300]
      ),
      drawer: showDrawer(),
      body: 
      JsonListView(),
      
   
    );
  }
    Drawer showDrawer() => Drawer(
          child: ListView(
        children: <Widget>[
          showIndata(),
          showCONTROL(),
          showChickdata(),
          showalertTH(),
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
          MaterialPageRoute(builder: (value)=>ControlM());
        Navigator.push(context, route);
      },
    );
  }



  ListTile showalertTH() {
    return ListTile(
      leading: Icon(MdiIcons.thermometerAlert),
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
            MaterialPageRoute(builder: (value) => Chickdata());
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
}

class Logdata {
 String id;
 String tTemp;
 String hHum;
 String dDate;
 String dTime;
  Logdata({
    this.id,
    this.tTemp,
    this.hHum,
    this.dDate,
    this.dTime
  });
 
  factory Logdata.fromJson(Map<String, dynamic> json) {
    return Logdata(
      id: json['id'],
      tTemp: json['Temp'],
      hHum: json['Humidity'],
      dDate: json['Datetable'],
      dTime: json['Timetable']

 
    );
  }
}


class JsonListView extends StatefulWidget {

  JsonListViewWidget createState() => JsonListViewWidget();

}

class JsonListViewWidget extends State<JsonListView> {

  final String uri = 'http://192.168.2.36/nodemcu/esp8266mysql/log.php';

  Future<List<Logdata>> fetchFruits() async {

    var response = await http.get(uri);

    if (response.statusCode == 200) {

      final items = json.decode(response.body).cast<Map<String, dynamic>>();

      List<Logdata> listOfFruits = items.map<Logdata>((json) {
        return Logdata.fromJson(json);
      }).toList();

      return listOfFruits;
      }
     else {
      throw Exception('Failed to load data.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Logdata>>(
        future: fetchFruits(),
        builder: (context, snapshot) {

          if (!snapshot.hasData) return Center(
            child: CircularProgressIndicator()
            );

          return ListView(
            
            children: snapshot.data
                .map((data) => ListTile(
                      title: Text("   "+data.dDate+"     "+data.dTime+"          "+data.tTemp+"                "+data.hHum),
                      
                    ))
                .toList(),
          );
        },
    );
  }
}