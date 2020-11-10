import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:incubator/screen/Alertth.dart';
import 'package:incubator/screen/Chickdata.dart';
import 'package:incubator/screen/Log.dart';
import 'package:incubator/screen/Manual.dart';
import 'package:incubator/screen/QRlogin.dart';
import 'package:incubator/screen/Status.dart';

class SaveChick extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new _SaveChick(),
    );
  }
}

class _SaveChick extends StatefulWidget {
  @override
  Sell createState() => Sell();
}

class Sell extends State<_SaveChick> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() => null);
  }

  File file;
  String name;
  String detail;
  String urlPicture;

  String uniqueCode = 'chick';
  QRlogin a;

  Future<void> uploadPictureToStorage() async {
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    StorageReference storageReference =
        firebaseStorage.ref().child('Chicken//Chicken$uniqueCode.jpg');
    StorageUploadTask storageUploadTask = storageReference.putFile(file);
    print(storageReference);
    urlPicture =
        await (await storageUploadTask.onComplete).ref.getDownloadURL();
    print('urlPicture = $urlPicture');
    addUser();
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        cameraButton(),
        galleryButton(),
      ],
    );
  }

  Widget galleryButton() {
    return IconButton(
        icon: Icon(
          Icons.add_photo_alternate,
          size: 40.0,
          color: Colors.lightBlueAccent,
        ),
        onPressed: () {
          chooseImage(ImageSource.gallery);
        });
  }

  Widget cameraButton() {
    return IconButton(
        icon:
            Icon(Icons.add_a_photo, size: 40.0, color: Colors.lightBlueAccent),
        onPressed: () {
          chooseImage(ImageSource.camera);
        });
  }

  Future<void> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker.pickImage(
        source: imageSource,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );

      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Widget names() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: TextField(
          onChanged: (String string) {
            name = string.trim();
          },
          decoration: InputDecoration(
            helperText: 'โปรดระบุชื่อ',
            labelText: 'ชื่อ',
          ),
        ));
  }

  Widget details() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: TextField(
          onChanged: (String string) {
            detail = string.trim();
          },
          decoration: InputDecoration(
            helperText: 'โปรดระบุรายละเอียด',
            labelText: 'รายละเอียด',
          ),
        ));
  }

  Future<void> showAlert(String title, String messages) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(messages),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('success'))
            ],
          );
        });
  }

  Future<Null> confirm() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('คุณต้องการส่งรายงานใช่หรือไม่'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlineButton(
                onPressed: () {
                  var rount = MaterialPageRoute(
                      builder: (BuildContext contex) => Chickdata());
                  Navigator.pop(context);
                  cond();
                },
                child: Text('ใช่'),
              ),
              OutlineButton(
                onPressed: () => Navigator.pop(context),
                child: Text('ไม่'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget submit() {
    return Container(
      child: OutlineButton(
        onPressed: () {
          print('You Click Upload');
          if (file == null) {
            showAlert('กรุณาใส่รูปภาพ', 'ถ่ายรูป หรือ อัพโหลดรูปภาพ');
          } else if (detail == null ||
              detail.isEmpty ||
              name == null ||
              name.isEmpty) {
            showAlert('กรุณากรอกข้อมูลให้ครบ', '');
          } else if (file != null ||
              detail == null ||
              detail.isEmpty ||
              name == null ||
              name.isEmpty) {
            confirm();
            // uploadPictureToStorage();
          }
          // else {
          //   // Upload

          //   // insertValueToFireStore2();
          // }
        },
        textColor: Colors.lightBlueAccent,
        borderSide: BorderSide(
            color: Colors.blue, width: 1.0, style: BorderStyle.solid),
        child: Text(
          'ยืนยัน',
        ),
      ),
    );
  }

  Widget showImage() {
    return Container(
      // color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: file == null ? Image.asset('images/pick.png') : Image.file(file),
    );
  }

  Widget showContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          showImage(),
          showButton(),
          names(),
          details(),
          submit(),
        ],
      ),
    );
  }

  Future<void> addUser() {
    CollectionReference users = FirebaseFirestore.instance.collection('H0DEJ');
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'name': name, // John Doe
          'detail': detail, // Stokes and Sons
          'image': urlPicture, // 42
          'time': DateTime.now(),
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Container(
            margin: EdgeInsets.only(left: 70.0), child: Text("บันทึกข้อมูลสายพันธุ์",style: TextStyle(color: Colors.blueGrey[400]),)),
            backgroundColor: Colors.yellow[300]
        ),
        drawer: showDrawer(),
        body: Container(
          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: Stack(
            children: <Widget>[
              showContent(),
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> cond() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('อัพโหลดข้อมูลเรียบร้อยแล้ว'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlineButton(
                onPressed: () {
                  uploadPictureToStorage();
                  MaterialPageRoute materialPageRoute = MaterialPageRoute(
                      builder: (BuildContext context) => Chickdata());
                  Navigator.of(context).pushAndRemoveUntil(
                      materialPageRoute, (Route<dynamic> route) => false);
                },
                child: Text('รับทราบ'),
              )
            ],
          )
        ],
      ),
    );
  }

  Drawer showDrawer() => Drawer(
          child: ListView(
        children: <Widget>[
          showIndata(),
          showalertTH(),
          showLogdata(),
          // saveChickdata(),
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

  // ListTile saveChickdata() {
  //   return ListTile(
  //     leading: Icon(Icons.info),
  //     title: Text("บันทึกข้อมูลของสายพันธุ์"),
  //     onTap: () {
  //       Navigator.pop(context);
  //       MaterialPageRoute route =
  //           MaterialPageRoute(builder: (value) => SaveChick());
  //       Navigator.push(context, route);
  //     },
  //   );
  // }

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
}
