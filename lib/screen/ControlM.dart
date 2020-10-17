import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:incubator/data/firebase.dart';
import 'package:incubator/screen/Alertchick.dart';
import 'package:incubator/screen/Alertth.dart';
import 'package:incubator/screen/Chickdata.dart';
import 'package:incubator/screen/Control.dart';
import 'package:incubator/screen/Log.dart';
import 'package:incubator/screen/Manual.dart';
import 'package:incubator/screen/Status.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'dart:async';
import 'package:intl/intl.dart';

final dbref = FirebaseDatabase.instance.reference();
var now = DateTime.now();
var formatter = DateFormat.yMMMd('th');
DateTime beforeaccept;
DateTime afteraccept;
String timeEgg_id;
String tempEgg_id;
String humEgg_id;
String turnEgg_id;
  List<String> timeE = [
    "14",
    "18",
    "21",
    "22",
    "24",
    "28",
    "30",
    "32"
  ];
  List<String> tempE = [
    "37.3",
    "37.5"
  ];
  List<String> humE = [
    "45-50",
    "50-60",
  ];
  List<String> turnE = [
    "3",
    "4",
    "5"
  ];  


  var day;
  var temp;
  var hum;
  var picchick;
class ControlM extends StatefulWidget {
 @override
  _ControlMState createState() => _ControlMState();
}

class _ControlMState extends State<ControlM> {
String _now;
Timer _everySecond;
@override
  void initState() {
    super.initState();

    // sets first value
    _now = DateTime.now().second.toString();

    // defines a timer 
    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        _now = DateTime.now().second.toString();
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.only(left: 0), child: Text("ตั้งค่าตู้ฟักไข่ แบบกำหนดเอง",style: TextStyle(fontSize: 19,color: Colors.blueGrey[400]),)),
        backgroundColor: Colors.yellow[300],
        actions: <Widget>[
          FlatButton(
          onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Control()),  );
          }, 
          child: Text("อัตโนมัติ")
          )
        ],),
      drawer: showDrawer(),
      body: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/img/bgx.png"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
           DropDownField(
                onValueChanged: (dynamic value) {
                  inCu_id = value;
                },
                value: inCu_id,
                required: false,
                hintText: 'ตู้ที่จะฟัก',
                labelText: 'เลือกตู้ที่จะฟัก',
                items: incu,
              ),SizedBox(height: 20,),
              DropDownField(
                onValueChanged: (dynamic value) {
                  timeEgg_id = value;
                },
                value: timeEgg_id,
                required: false,
                hintText: 'เลือกจำนวนวันที่ฟักไข่',
                labelText: 'วันที่ฟัก',
                items: timeE,
              ),
              SizedBox(height: 20),
               DropDownField(
                onValueChanged: (dynamic value) {
                  tempEgg_id = value;
                },
                value: tempEgg_id,
                required: false,
                hintText: 'เลือกอุณหภูมิเพื่อฟักไข่',
                labelText: 'อุณหภูมิ',
                items: tempE,
              ),SizedBox(height: 20),
               DropDownField(
                onValueChanged: (dynamic value) {
                  humEgg_id = value;
                },
                value: humEgg_id,
                required: false,
                hintText: 'เลือกความชื้นเพื่อฟักไข่',
                labelText: 'ความชื้น',
                items: humE,
              ),SizedBox(height: 20),
               DropDownField(
                onValueChanged: (dynamic value) {
                  turnEgg_id = value;
                },
                value: turnEgg_id,
                required: false,
                hintText: 'เลือกจำนวนการกลับไข่ ต่อวัน',
                labelText: 'รอบการกลับไข่ ต่อวัน',
                items: turnE,
              ),
          const SizedBox(height: 20),
          RaisedButton(
            color: Colors.blue,
            onPressed: () {
              checkchick();
              showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                barrierColor: Colors.black45,
                transitionDuration: const Duration(milliseconds: 200),
                pageBuilder: (BuildContext buildContext,
                    Animation animation,
                    Animation secondaryAnimation) {
                  return Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 10,
                      height: MediaQuery.of(context).size.height -  80,
                      padding: EdgeInsets.all(20),
                      color: Colors.white,
                      child: Column(
                        
                        children: [
                          Text("การตั้งค่าแบบกำหนดเอง",style:TextStyle(color:Colors.black,fontSize: 25),),
                          SizedBox(height: 50), 
                          Text(inCu_id,style: TextStyle(color:Colors.black,fontSize: 20),),
                          SizedBox(height: 40),
                          Text('ระยะเวลาการฟักไข่ =  '+timeEgg_id+" วัน",style: TextStyle(color:Colors.black,fontSize: 20),),
                          SizedBox(height: 40),
                          Text('อุณหภูมิในการฟัก =  '+tempEgg_id+" องศา",style: TextStyle(color:Colors.black,fontSize: 20),),
                          SizedBox(height: 40),
                          Text('ความชื้นในการฟัก =  '+humEgg_id+" %",style: TextStyle(color:Colors.black,fontSize: 20),),
                          SizedBox(height: 40),
                          Text('จำนวนรอบการกลับไข่ =  '+turnEgg_id+" รอบต่อวัน",style: TextStyle(color:Colors.black,fontSize: 20),),
                           SizedBox(height: 40),
                          RaisedButton(
                            color: Colors.green[600],
                            onPressed: () {
                              writedata();
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "ตกลง",
                              style: TextStyle(color: Colors.white),
                            ),
                            
                          ),SizedBox(height: 10),
                            RaisedButton(
                            color: Colors.red[400],    
                            onPressed: () {
                              
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "ยกเลิก",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
            },
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: const BoxDecoration(
              ),
              padding: const EdgeInsets.all(10.0),
              child:
                  const Text('  ยืนยัน  ', style: TextStyle(fontSize: 20)),
              ),
            ),
           ]
            
         ),
        ),
      ),
    );
  }

  Drawer showDrawer() => Drawer(
          child: ListView(
        children: <Widget>[
          showIndata(),
          showalertchick(),
          showalertTH(),
          showLogdata(),
          showChickdata(),
          showManual()
        ],
      ));

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
        MaterialPageRoute route =
            MaterialPageRoute(builder: (value) => Log());
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

void writedata(){
  if (inCu_id == 'ตู้ที่ 1'){

    afteraccept = now.add(new Duration(days: int.parse(timeEgg_id)));
    beforeaccept = now;
    dbref.child("ConFigData").child('Incu_ID1').child('อุณหภูมิ').set(tempEgg_id);
    dbref.child("ConFigData").child('Incu_ID1').child('ความชื้น').set(humEgg_id);
    dbref.child("ConFigData").child('Incu_ID1').child('การกลับรอบไข่').set(turnEgg_id);
    dbref.child("Date").child('DateNow').set(beforedateformat);
    dbref.child("Date").child('DateEnd').set(afterdateformat);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';

  }
  else if(inCu_id == 'ตู้ที่ 2'){

    afteraccept = now.add(new Duration(days: int.parse(timeEgg_id)));
    beforeaccept = now;
    dbref.child("ConFigData").child('Incu_ID2').child('อุณหภูมิ').set(tempEgg_id);
    dbref.child("ConFigData").child('Incu_ID2').child('ความชื้น').set(humEgg_id);
    dbref.child("ConFigData").child('Incu_ID2').child('การกลับรอบไข่').set(turnEgg_id);
    dbref.child("Date2").child('DateNow').set(beforedateformat);
    dbref.child("Date2").child('DateEnd').set(afterdateformat);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';

  }
    else if(inCu_id == 'ตู้ที่ 3'){

    afteraccept = now.add(new Duration(days: int.parse(timeEgg_id)));
    beforeaccept = now;
    dbref.child("ConFigData").child('Incu_ID3').child('อุณหภูมิ').set(tempEgg_id);
    dbref.child("ConFigData").child('Incu_ID3').child('ความชื้น').set(humEgg_id);
    dbref.child("ConFigData").child('Incu_ID3').child('การกลับรอบไข่').set(turnEgg_id);
    dbref.child("Date3").child('DateNow').set(beforedateformat);
    dbref.child("Date3").child('DateEnd').set(afterdateformat);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';

  }

}