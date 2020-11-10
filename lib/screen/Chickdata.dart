import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:incubator/Model.dart';
import 'package:incubator/screen/Alertth.dart';
import 'package:incubator/screen/Log.dart';
import 'package:incubator/screen/Manual.dart';
import 'package:incubator/screen/QRlogin.dart';
import 'package:incubator/screen/SaveChick.dart';
import 'package:incubator/screen/Status.dart';

var kay;

class _Chickdata extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Chickdata(),
    );
  }
}

class Chickdata extends StatefulWidget {
  @override
  Chickdata({Key key, this.title}) : super(key: key);

  final String title;

  Chick createState() => Chick();
}

class Chick extends State<Chickdata> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(margin: EdgeInsets.only(left: 90.0), child: Text("ข้อมูลสายพันธุ์",style: TextStyle(color: Colors.blueGrey[400]),)),
            backgroundColor: Colors.yellow[300]
      ),
      drawer: showDrawer(),
      body: Container(
        padding: EdgeInsets.all(10),
        color: Colors.yellow[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 500,
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('H0DEJ').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> querySnapshot) {
                if (querySnapshot.hasError) return Text('Error');
                if (querySnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  final list = querySnapshot.data.docs;
                  return ListView.builder(
                    itemBuilder: (Context, index) {
                      return ListTile(
                        leading: Image.network(list[index]["image"],
                            width: 100, height: 200, fit: BoxFit.fill),
                        title: Text(list[index]["name"]),
                        subtitle: Text(list[index]["detail"]),
                      );
                    },
                    itemCount: list.length,
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }

  Drawer showDrawer() => Drawer(
          child: ListView(
        children: <Widget>[
          showIndata(),
          showalertTH(),
          showLogdata(),
          saveChickdata(),
          showChickdata(),
          showManual()
        ],
      ));

  ListTile showalertTH() {
    return ListTile(
      leading: Icon(Icons.add_alert),
      title: Text("บันทึกแจ้งเตือนอุณหภูมิและความชื้น"),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Alertth());
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

  // Widget fsa(BuildContext context) {
  //   CollectionReference users = FirebaseFirestore.instance.collection('H0DEJ');

  //   return StreamBuilder<QuerySnapshot>(
  //     stream: users.snapshots(),
  //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //       if (snapshot.hasError) {
  //         return Text('Something went wrong');
  //       }

  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Text("Loading");
  //       }
  //       return new ListView(
  //         children: snapshot.data.docs.map((DocumentSnapshot document) {
  //           return new ListTile(
  //             leading: new Image.network(document.data()['image']),
  //             title: new Text(document.data()['name']),
  //             subtitle: new Text(document.data()['detail']),
  //           );
  //         }).toList(),
  //       );
  //     },
  //   );
  // }
}
