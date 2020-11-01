import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:incubator/data/firebase.dart';
import 'package:incubator/screen/Alertth.dart';
import 'package:incubator/screen/Chickdata.dart';
import 'package:incubator/screen/ControlM.dart';
import 'package:incubator/screen/Log.dart';
import 'package:incubator/screen/Manual.dart';
import 'package:incubator/screen/SaveChick.dart';
import 'package:incubator/screen/Status.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

var beforedateformat = '';
var afterdateformat = '';
final dbref = FirebaseDatabase.instance.reference();
var now = DateTime.now();
var formatter = DateFormat.yMMMd('th');
DateTime beforeaccept;
DateTime afteraccept;
String chick_id;
String inCu_id;
  List<String> chick = [
    "ไก่ดำ , ไก่แจ้ , ไก่ชน",
    "ไก่งวง",
    "นกฟินซ์",
    "นกแก้วพันธุ์เล็ก",
    "นกแก้วอเมซอน",
    "นกแก้วมาคอร์",
    "นกเลิฟเบิร์ด",
    "เป็ดทุกสายพันธุ์",
    "ห่านทุกสายพันธุ์",
    "นกกระทา",
    "นกยูง"
  ];
  List<String> incu = [
    "ตู้ที่ 1",
    "ตู้ที่ 2",
    "ตู้ที่ 3"
  ];


  var day;
  var temp;
  var hum;
  var picchick;
  
class Control extends StatefulWidget {
 @override
  _ControlState createState() => _ControlState();
}

class _ControlState extends State<Control> {
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
            margin: EdgeInsets.only(left: 10), child: Text("ตั้งค่าตู้ฟักไข่ แบบอัตโนมัติ",style: TextStyle(fontSize: 19,color: Colors.blueGrey[400]),)),
        backgroundColor: Colors.yellow[300],
        actions: <Widget>[
          FlatButton(
          onPressed: (){
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => ControlM()),  );
          }, 
          child: Text("กำหนดเอง")
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
              ),SizedBox(height: 40,),
           DropDownField(
                onValueChanged: (dynamic value) {
                  chick_id = value;
                },
                value: chick_id,
                required: false,
                hintText: 'เลือกสายพันธ์ุ สัตว์ปีกเพื่อฟักไข่',
                labelText: 'สายพันธ์ุ',
                items: chick,
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
                          Text(chick_id,style:TextStyle(color:Colors.black,fontSize: 25),),
                          SizedBox(height: 20),
                          new Image.asset(picchick,width: 200,),
                          SizedBox(height: 10),
                          Text(inCu_id,style: TextStyle(color:Colors.black,fontSize: 20),),
                          SizedBox(height: 10),
                          Text('ระยะเวลาการฟักไข่ =  '+day+" วัน",style: TextStyle(color:Colors.black,fontSize: 20),),
                          SizedBox(height: 30),
                          Text('อุณหภูมิในการฟัก =  '+temp+" องศา",style: TextStyle(color:Colors.black,fontSize: 20),),
                          SizedBox(height: 30),
                          Text('ความชื้นในการฟัก =  '+hum+" %",style: TextStyle(color:Colors.black,fontSize: 20),),
                          SizedBox(height: 30),
                          Text('จำนวนรอบการกลับไข่ =  '+'3'+" รอบต่อวัน",style: TextStyle(color:Colors.black,fontSize: 20),),
                           SizedBox(height: 20),
                          RaisedButton(
                            color: Colors.green[600],
                            onPressed: () {
                              acceptchick();
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
            SizedBox(height: 20,),
            Text('คุณได้เลือก',style: TextStyle(fontSize: 30,)),
            SizedBox(height: 20,),
            Text(chickIdTT,style: TextStyle(fontSize: 20),),
            SizedBox(height: 20,),
            ],
            //'${formatter.format(beforeaccept)}'
         ),
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
      title: Text("แจ้งเตือนอุณหภูมิและความชื้น"),
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
TextEditingController daysController = new TextEditingController();
TextEditingController tempsController = new TextEditingController();
TextEditingController humsController = new TextEditingController();
TextEditingController flipController = new TextEditingController();

void checkchick(){
  if (chick_id == "ไก่ดำ , ไก่แจ้ , ไก่ชน" ){
    day = '21';
    temp = '37.5';
    hum = '50-60';
    picchick = "lib/img/chickjae.JPG";
    
  }
  else if(chick_id == "ไก่งวง") {
    day = '28';
    temp = '37.3';
    hum = '50-60';
    picchick = "lib/img/chickjung.JPG";
    
  }
  else if(chick_id == "นกฟินซ์") {
    day = '14';
    temp = '37.5';
    hum = '45-50';
    picchick = "lib/img/bfint.JPG";
  
  }
  else if(chick_id == "นกแก้วพันธุ์เล็ก") {
    day = '18';
    temp = '37.3';
    hum = '45-50';
    picchick = "lib/img/smallParrot.JPG";
 
  }
  else if(chick_id == "นกแก้วอเมซอน") {
    day = '24';
    temp = '37.3';
    hum = '45-50';
    picchick = "lib/img/amasonParrot.JPG";
 
  }
  else if(chick_id == "นกแก้วมาคอร์") {
    day = '28';
    temp = '37.3';
    hum = '50-60';
    picchick = "lib/img/marcorParrot.JPG";
 
  }
  else if(chick_id == "นกเลิฟเบิร์ด") {
    day = '22';
    temp = '37.3';
    hum = '45-50';
    picchick = "lib/img/lovebird.JPG";

  }
  else if(chick_id == "เป็ดทุกสายพันธุ์") {
    day = '28';
    temp = '37.5';
    hum = '45-50';
    picchick = "lib/img/duck.JPG";
 
  }
  else if(chick_id == "ห่านทุกสายพันธุ์") {
    day = '28';
    temp = '37.3';
    hum = '45-50';
    picchick = "lib/img/goose.JPG";

  }
  else if(chick_id == "นกกระทา") {
    day = '16';
    temp = '37.3';
    hum = '50-60';
    picchick = "lib/img/panbird.JPG";

  }
  else if(chick_id == "นกยูง") {
    day = '28';
    temp = '37.3';
    hum = '50-60';
    picchick = "lib/img/peacock.JPG";

  }
  else{

  }
}

void acceptchick(){
  if (chick_id == "ไก่ดำ , ไก่แจ้ , ไก่ชน" && inCu_id == "ตู้ที่ 1"){
    day = '21';
    temp = '37.5';
    hum = '50-60';
    picchick = "lib/img/chickjae.JPG";
    dbref.child("ChickID").set({'data':'ไก่ดำ , ไก่แจ้ , ไก่ชน'});
    afteraccept = now.add(new Duration(days: 21));
    beforeaccept = now;
    dbref.child("ConFigData").child('Incu_ID1').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID1').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID1').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date").child('DateNow').set(beforedateformat);
    dbref.child("Date").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "ไก่งวง" && inCu_id == "ตู้ที่ 1") {
    day = '28';
    temp = '37.3';
    hum = '50-60';
    picchick = "lib/img/chickjung.JPG";
    dbref.child("ChickID").set({'data':'ไก่งวง'});
    afteraccept = now.add(new Duration(days: 28));
    beforeaccept = now;
    dbref.child("ConFigData").child('Incu_ID1').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID1').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID1').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date").child('DateNow').set(beforedateformat);
    dbref.child("Date").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "นกฟินซ์"&& inCu_id == "ตู้ที่ 1") {
    day = '14';
    temp = '37.5';
    hum = '45-50';
    picchick = "lib/img/bfint.JPG";
    dbref.child("ChickID").set({'data':'นกฟินซ์'});
    afteraccept = now.add(new Duration(days: 14));
    beforeaccept = now;
    dbref.child("ConFigData").child('Incu_ID1').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID1').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID1').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date").child('DateNow').set(beforedateformat);
    dbref.child("Date").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "นกแก้วพันธุ์เล็ก"&& inCu_id == "ตู้ที่ 1") {
    day = '18';
    temp = '37.3';
    hum = '45-50';
    picchick = "lib/img/smallParrot.JPG";
    dbref.child("ChickID").set({'data':'นกแก้วพันธุ์เล็ก'});
    afteraccept = now.add(new Duration(days: 18));
    beforeaccept = now;
    dbref.child("ConFigData").child('Incu_ID1').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID1').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID1').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date").child('DateNow').set(beforedateformat);
    dbref.child("Date").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "นกแก้วอเมซอน"&& inCu_id == "ตู้ที่ 1") {
    day = '24';
    temp = '37.3';
    hum = '45-50';
    picchick = "lib/img/amasonParrot.JPG";
    dbref.child("ChickID").set({'data':'นกแก้วอเมซอน'});
    afteraccept = now.add(new Duration(days: 24));
    beforeaccept = now;
     dbref.child("ConFigData").child('Incu_ID1').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID1').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID1').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date").child('DateNow').set(beforedateformat);
    dbref.child("Date").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "นกแก้วมาคอร์"&& inCu_id == "ตู้ที่ 1") {
    day = '28';
    temp = '37.3';
    hum = '50-60';
    picchick = "lib/img/marcorParrot.JPG";
    dbref.child("ChickID").set({'data':'นกแก้วมาคอร์'});
    afteraccept = now.add(new Duration(days: 28));
    beforeaccept = now;
     dbref.child("ConFigData").child('Incu_ID1').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID1').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID1').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date").child('DateNow').set(beforedateformat);
    dbref.child("Date").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "นกเลิฟเบิร์ด"&& inCu_id == "ตู้ที่ 1") {
    day = '22';
    temp = '37.3';
    hum = '45-50';
    picchick = "lib/img/lovebird.JPG";
    dbref.child("ChickID").set({'data':'นกเลิฟเบิร์ด'});
    afteraccept = now.add(new Duration(days: 22));
    beforeaccept = now;
    dbref.child("ConFigData").child('Incu_ID1').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID1').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID1').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date").child('DateNow').set(beforedateformat);
    dbref.child("Date").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "เป็ดทุกสายพันธุ์"&& inCu_id == "ตู้ที่ 1") {
    day = '28';
    temp = '37.5';
    hum = '45-50';
    picchick = "lib/img/duck.JPG";
    dbref.child("ChickID").set({'data':'เป็ดทุกสายพันธุ์'});
    afteraccept = now.add(new Duration(days: 28));
    beforeaccept = now;
    dbref.child("ConFigData").child('Incu_ID1').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID1').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID1').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date").child('DateNow').set(beforedateformat);
    dbref.child("Date").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "ห่านทุกสายพันธุ์"&& inCu_id == "ตู้ที่ 1") {
    day = '28';
    temp = '37.3';
    hum = '45-50';
    picchick = "lib/img/goose.JPG";
    dbref.child("ChickID").set({'data':'ห่านทุกสายพันธุ์'});
    afteraccept = now.add(new Duration(days: 28));
    beforeaccept = now;
   dbref.child("ConFigData").child('Incu_ID1').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID1').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID1').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date").child('DateNow').set(beforedateformat);
    dbref.child("Date").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "นกกระทา"&& inCu_id == "ตู้ที่ 1") {
    day = '16';
    temp = '37.3';
    hum = '50-60';
    picchick = "lib/img/panbird.JPG";
    dbref.child("ChickID").set({'data':'นกกระทา'});
    afteraccept = now.add(new Duration(days: 16));
    beforeaccept = now;
    dbref.child("ConFigData").child('Incu_ID1').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID1').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID1').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date").child('DateNow').set(beforedateformat);
    dbref.child("Date").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "นกยูง"&& inCu_id == "ตู้ที่ 1") {
    day = '28';
    temp = '37.3';
    hum = '50-60';
    picchick = "lib/img/peacock.JPG";
    dbref.child("ChickID").set({'data':'นกยูง'});
    afteraccept = now.add(new Duration(days: 28));
    beforeaccept = now;
    dbref.child("ConFigData").child('Incu_ID1').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID1').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID1').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date").child('DateNow').set(beforedateformat);
    dbref.child("Date").child('DateEnd').set(afterdateformat);
  }
  else if (chick_id == "ไก่ดำ , ไก่แจ้ , ไก่ชน" && inCu_id == "ตู้ที่ 2"){
    day = '21';
    temp = '37.5';
    hum = '50-60';
    picchick = "lib/img/chickjae.JPG";
    dbref.child("ChickID").set({'data':'ไก่ดำ , ไก่แจ้ , ไก่ชน'});
    dbref.child("ChickID").set({'data':'ไก่ดำ , ไก่แจ้ , ไก่ชน'});
    afteraccept = now.add(new Duration(days: 21));
    beforeaccept = now;
   dbref.child("ConFigData").child('Incu_ID2').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID2').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID2').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date2").child('DateNow').set(beforedateformat);
    dbref.child("Date2").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "ไก่งวง" && inCu_id == "ตู้ที่ 2") {
    day = '28';
    temp = '37.3';
    hum = '50-60';
    picchick = "lib/img/chickjung.JPG";
    dbref.child("ChickID").set({'data':'ไก่งวง'});
    afteraccept = now.add(new Duration(days: 28));
    beforeaccept = now;
    dbref.child("ConFigData").child('Incu_ID2').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID2').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID2').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date2").child('DateNow').set(beforedateformat);
    dbref.child("Date2").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "นกฟินซ์"&& inCu_id == "ตู้ที่ 2") {
    day = '14';
    temp = '37.5';
    hum = '45-50';
    picchick = "lib/img/bfint.JPG";
    dbref.child("ChickID").set({'data':'นกฟินซ์'});
    afteraccept = now.add(new Duration(days: 14));
    beforeaccept = now;
    dbref.child("ConFigData").child('Incu_ID2').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID2').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID2').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date2").child('DateNow').set(beforedateformat);
    dbref.child("Date2").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "นกแก้วพันธุ์เล็ก"&& inCu_id == "ตู้ที่ 2") {
    day = '18';
    temp = '37.3';
    hum = '45-50';
    picchick = "lib/img/smallParrot.JPG";
    dbref.child("ChickID").set({'data':'นกแก้วพันธุ์เล็ก'});
    afteraccept = now.add(new Duration(days: 18));
    beforeaccept = now;
    dbref.child("ConFigData").child('Incu_ID2').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID2').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID2').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date2").child('DateNow').set(beforedateformat);
    dbref.child("Date2").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "นกแก้วอเมซอน"&& inCu_id == "ตู้ที่ 2") {
    day = '24';
    temp = '37.3';
    hum = '45-50';
    picchick = "lib/img/amasonParrot.JPG";
    dbref.child("ChickID").set({'data':'นกแก้วอเมซอน'});
    afteraccept = now.add(new Duration(days: 24));
    beforeaccept = now;
  dbref.child("ConFigData").child('Incu_ID2').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID2').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID2').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date2").child('DateNow').set(beforedateformat);
    dbref.child("Date2").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "นกแก้วมาคอร์"&& inCu_id == "ตู้ที่ 2") {
    day = '28';
    temp = '37.3';
    hum = '50-60';
    picchick = "lib/img/marcorParrot.JPG";
    dbref.child("ChickID").set({'data':'นกแก้วมาคอร์'});
    afteraccept = now.add(new Duration(days: 28));
    beforeaccept = now;
    dbref.child("ConFigData").child('Incu_ID2').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID2').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID2').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date2").child('DateNow').set(beforedateformat);
    dbref.child("Date2").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "นกเลิฟเบิร์ด"&& inCu_id == "ตู้ที่ 2") {
    day = '22';
    temp = '37.3';
    hum = '45-50';
    picchick = "lib/img/lovebird.JPG";
    dbref.child("ChickID").set({'data':'นกเลิฟเบิร์ด'});
    afteraccept = now.add(new Duration(days: 22));
    beforeaccept = now;
   dbref.child("ConFigData").child('Incu_ID2').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID2').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID2').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date2").child('DateNow').set(beforedateformat);
    dbref.child("Date2").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "เป็ดทุกสายพันธุ์"&& inCu_id == "ตู้ที่ 2") {
    day = '28';
    temp = '37.5';
    hum = '45-50';
    picchick = "lib/img/duck.JPG";
    dbref.child("ChickID").set({'data':'เป็ดทุกสายพันธุ์'});
    afteraccept = now.add(new Duration(days: 28));
    beforeaccept = now;
   dbref.child("ConFigData").child('Incu_ID2').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID2').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID2').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date2").child('DateNow').set(beforedateformat);
    dbref.child("Date2").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "ห่านทุกสายพันธุ์"&& inCu_id == "ตู้ที่ 2") {
    day = '28';
    temp = '37.3';
    hum = '45-50';
    picchick = "lib/img/goose.JPG";
    dbref.child("ChickID").set({'data':'ห่านทุกสายพันธุ์'});
    afteraccept = now.add(new Duration(days: 28));
    beforeaccept = now;
  dbref.child("ConFigData").child('Incu_ID2').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID2').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID2').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date2").child('DateNow').set(beforedateformat);
    dbref.child("Date2").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "นกกระทา"&& inCu_id == "ตู้ที่ 2") {
    day = '16';
    temp = '37.3';
    hum = '50-60';
    picchick = "lib/img/panbird.JPG";
    dbref.child("ChickID").set({'data':'นกกระทา'});
    afteraccept = now.add(new Duration(days: 16));
    beforeaccept = now;
  dbref.child("ConFigData").child('Incu_ID2').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID2').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID2').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date2").child('DateNow').set(beforedateformat);
    dbref.child("Date2").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "นกยูง"&& inCu_id == "ตู้ที่ 2") {
    day = '28';
    temp = '37.3';
    hum = '50-60';
    picchick = "lib/img/peacock.JPG";
    dbref.child("ChickID").set({'data':'นกยูง'});
    afteraccept = now.add(new Duration(days: 28));
    beforeaccept = now;
  dbref.child("ConFigData").child('Incu_ID2').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID2').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID2').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date2").child('DateNow').set(beforedateformat);
    dbref.child("Date2").child('DateEnd').set(afterdateformat);
  }
  else if (chick_id == "ไก่ดำ , ไก่แจ้ , ไก่ชน" && inCu_id == "ตู้ที่ 3"){
    day = '21';
    temp = '37.5';
    hum = '50-60';
    picchick = "lib/img/chickjae.JPG";
    dbref.child("ChickID").set({'data':'ไก่ดำ , ไก่แจ้ , ไก่ชน'});
    dbref.child("ChickID").set({'data':'ไก่ดำ , ไก่แจ้ , ไก่ชน'});
    afteraccept = now.add(new Duration(days: 21));
    beforeaccept = now;
    dbref.child("ConFigData").child('Incu_ID3').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID3').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID3').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date3").child('DateNow').set(beforedateformat);
    dbref.child("Date3").child('DateEnd').set(afterdateformat);
    

  }
  else if(chick_id == "ไก่งวง" && inCu_id == "ตู้ที่ 3") {
    day = '28';
    temp = '37.3';
    hum = '50-60';
    picchick = "lib/img/chickjung.JPG";
    dbref.child("ChickID").set({'data':'ไก่งวง'});
    afteraccept = now.add(new Duration(days: 28));
    beforeaccept = now;
    dbref.child("ConFigData").child('Incu_ID3').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID3').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID3').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date3").child('DateNow').set(beforedateformat);
    dbref.child("Date3").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "นกฟินซ์"&& inCu_id == "ตู้ที่ 3") {
    day = '14';
    temp = '37.5';
    hum = '45-50';
    picchick = "lib/img/bfint.JPG";
    dbref.child("ChickID").set({'data':'นกฟินซ์'});
    afteraccept = now.add(new Duration(days: 14));
    beforeaccept = now;
    dbref.child("ConFigData").child('Incu_ID3').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID3').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID3').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date3").child('DateNow').set(beforedateformat);
    dbref.child("Date3").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "นกแก้วพันธุ์เล็ก"&& inCu_id == "ตู้ที่ 3") {
    day = '18';
    temp = '37.3';
    hum = '45-50';
    picchick = "lib/img/smallParrot.JPG";
    dbref.child("ChickID").set({'data':'นกแก้วพันธุ์เล็ก'});
    afteraccept = now.add(new Duration(days: 18));
    beforeaccept = now;
    dbref.child("ConFigData").child('Incu_ID3').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID3').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID3').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date3").child('DateNow').set(beforedateformat);
    dbref.child("Date3").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "นกแก้วอเมซอน"&& inCu_id == "ตู้ที่ 3") {
    day = '24';
    temp = '37.3';
    hum = '45-50';
    picchick = "lib/img/amasonParrot.JPG";
    dbref.child("ChickID").set({'data':'นกแก้วอเมซอน'});
    afteraccept = now.add(new Duration(days: 24));
    beforeaccept = now;
   dbref.child("ConFigData").child('Incu_ID3').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID3').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID3').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date3").child('DateNow').set(beforedateformat);
    dbref.child("Date3").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "นกแก้วมาคอร์"&& inCu_id == "ตู้ที่ 3") {
    day = '28';
    temp = '37.3';
    hum = '50-60';
    picchick = "lib/img/marcorParrot.JPG";
    dbref.child("ChickID").set({'data':'นกแก้วมาคอร์'});
    afteraccept = now.add(new Duration(days: 28));
    beforeaccept = now;
     dbref.child("ConFigData").child('Incu_ID3').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID3').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID3').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date3").child('DateNow').set(beforedateformat);
    dbref.child("Date3").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "นกเลิฟเบิร์ด"&& inCu_id == "ตู้ที่ 3") {
    day = '22';
    temp = '37.3';
    hum = '45-50';
    picchick = "lib/img/lovebird.JPG";
    dbref.child("ChickID").set({'data':'นกเลิฟเบิร์ด'});
    afteraccept = now.add(new Duration(days: 22));
    beforeaccept = now;
    dbref.child("ConFigData").child('Incu_ID3').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID3').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID3').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date3").child('DateNow').set(beforedateformat);
    dbref.child("Date3").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "เป็ดทุกสายพันธุ์"&& inCu_id == "ตู้ที่ 3") {
    day = '28';
    temp = '37.5';
    hum = '45-50';
    picchick = "lib/img/duck.JPG";
    dbref.child("ChickID").set({'data':'เป็ดทุกสายพันธุ์'});
    afteraccept = now.add(new Duration(days: 28));
    beforeaccept = now;
   dbref.child("ConFigData").child('Incu_ID3').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID3').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID3').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date3").child('DateNow').set(beforedateformat);
    dbref.child("Date3").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "ห่านทุกสายพันธุ์"&& inCu_id == "ตู้ที่ 3") {
    day = '28';
    temp = '37.3';
    hum = '45-50';
    picchick = "lib/img/goose.JPG";
    dbref.child("ChickID").set({'data':'ห่านทุกสายพันธุ์'});
    afteraccept = now.add(new Duration(days: 28));
    beforeaccept = now;
   dbref.child("ConFigData").child('Incu_ID3').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID3').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID3').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date3").child('DateNow').set(beforedateformat);
    dbref.child("Date3").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "นกกระทา"&& inCu_id == "ตู้ที่ 3") {
    day = '16';
    temp = '37.3';
    hum = '50-60';
    picchick = "lib/img/panbird.JPG";
    dbref.child("ChickID").set({'data':'นกกระทา'});
    afteraccept = now.add(new Duration(days: 16));
    beforeaccept = now;
   dbref.child("ConFigData").child('Incu_ID3').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID3').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID3').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date3").child('DateNow').set(beforedateformat);
    dbref.child("Date3").child('DateEnd').set(afterdateformat);
  }
  else if(chick_id == "นกยูง"&& inCu_id == "ตู้ที่ 3") {
    day = '28';
    temp = '37.3';
    hum = '50-60';
    picchick = "lib/img/peacock.JPG";
    dbref.child("ChickID").set({'data':'นกยูง'});
    afteraccept = now.add(new Duration(days: 28));
    beforeaccept = now;
   dbref.child("ConFigData").child('Incu_ID3').child('อุณหภูมิ').set(temp);
    dbref.child("ConFigData").child('Incu_ID3').child('ความชื้น').set(hum);
    dbref.child("ConFigData").child('Incu_ID3').child('การกลับรอบไข่').set(3);
    beforedateformat = '${formatter.format(beforeaccept)}';
    afterdateformat = '${formatter.format(afteraccept)}';
    dbref.child("Date3").child('DateNow').set(beforedateformat);
    dbref.child("Date3").child('DateEnd').set(afterdateformat);
  }
  else{

  }
}

