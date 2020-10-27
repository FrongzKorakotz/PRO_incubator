import 'dart:ffi';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:incubator/models/Chicken.model.dart';
import 'package:incubator/screen/Log.dart';
import 'package:incubator/screen/Status.dart';
import 'package:incubator/screen/control.dart';
import 'package:incubator/screen/Alertchick.dart';
import 'package:incubator/screen/Alertth.dart';
import 'package:incubator/screen/Manual.dart';
import 'package:incubator/screen/SaveChick.dart';
import 'dart:io';

class Chickdata extends StatefulWidget {
  @override
  _ChickdataState createState() => _ChickdataState();
}

class _ChickdataState extends State<Chickdata> {
  List<ChickenModel> chickModels = List();

  @override
  void initState() {
    super.initState();
    readAllData();
  }

  Future<void> readAllData() async {
    Firestore firestore = Firestore.instance;
    CollectionReference collectionReference = firestore.collection('Chicken');
    await collectionReference.snapshots().listen((response) {
      List<DocumentSnapshot> snapshots = response.documents;
      for (var snapshot in snapshots) {
        print('snapshot = $snapshot');
        print('Name = ${snapshot.data()['Name']}');
        ChickenModel chickenModel = ChickenModel.fromMap(snapshot.data());
        setState(() {
          chickModels.add(chickenModel);
        });
      }
    });
  }

  Widget showImage(int index) {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: NetworkImage(chickModels[index].pathpic),
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget showName(int index) {
    return Row(
      children: <Widget>[
        Text(
          chickModels[index].name,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget showDetail(int index) {
    String string = chickModels[index].detail;
    if (string.length > 100) {
      string = string.substring(0, 99);
      string = '$string ...';
    }
    return Text(
      string,
      style: TextStyle(
        fontSize: 14.0,
        fontStyle: FontStyle.italic,
        color: Colors.grey.shade700,
      ),
    );
  }

  Widget showText(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        children: <Widget>[
          showName(index),
          showDetail(index),
        ],
      ),
    );
  }

  Widget showListView(int index) {
    return Row(
      children: <Widget>[
        showImage(index),
        showText(index),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
              margin: EdgeInsets.only(left: 60.0),
              child: Text(
                "ข้อมูลของสายพันธุ์",
                style: TextStyle(color: Colors.blueGrey[400]),
              )),
          backgroundColor: Colors.yellow[300]),
      drawer: showDrawer(),
      body: Container(
        child: ListView.builder(
          itemCount: chickModels.length,
          itemBuilder: (BuildContext buildContext, int index) {
            return Text(chickModels[index].name);
          },
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
          showalertTH(),
          showManual(),
          saveChickdata()
        ],
      ));

  ListTile showCONTROL() {
    return ListTile(
      leading: Icon(Icons.settings),
      title: Text("ตั้งค่าตู้ฟักไข่"),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Control());
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
            MaterialPageRoute(builder: (value) => Alertchick());
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
            MaterialPageRoute(builder: (value) => Alertth());
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
            MaterialPageRoute(builder: (value) => Manual());
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
        MaterialPageRoute route = MaterialPageRoute(builder: (value) => Log());
        Navigator.push(context, route);
      },
    );
  }

  ListTile saveChickdata() {
    return ListTile(
      leading: Icon(Icons.info),
      title: Text("บันทึกข้อมูลของสายพันธุ์"),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => SaveChick());
        Navigator.push(context, route);
      },
    );
  }
}
