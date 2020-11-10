import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:incubator/data/firebase.dart';
import 'package:incubator/screen/Alertth.dart';
import 'package:incubator/screen/Chickdata.dart';
import 'package:incubator/screen/Log.dart';
import 'package:incubator/screen/Manual.dart';
import 'package:incubator/screen/SaveChick.dart';
import 'package:incubator/screen/Status.dart';
import 'package:incubator/screen/Control.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
final dbref = FirebaseDatabase.instance.reference();
var now = DateTime.now();
var afteraccept;
String chick_id;
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


  var day;
  var temp;
  var hum;
  var picchick;
class AcceptChick extends StatefulWidget {
 @override
  _AcceptChickState createState() => _AcceptChickState();
}

class _AcceptChickState extends State<AcceptChick> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.only(left: 90.0), child: Text("สายพันธุ์ที่เลือก",style: TextStyle(color: Colors.blueGrey[400]),)),
            backgroundColor: Colors.yellow[300]
      ),
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
          const SizedBox(height: 20),
          RaisedButton(
            color: Colors.blue,
            onPressed: () {
              
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
                          SizedBox(height: 30),
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
            Text(chickIdTT,style: TextStyle(fontSize: 40),),
            SizedBox(height: 20,),
            Text(afteraccept.toString(),style: TextStyle(fontSize: 40),)],
            
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
      leading: Icon(MdiIcons.thermometerAlert),
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
      leading: Icon(MdiIcons.thermometerLines),
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
TextEditingController daysController = new TextEditingController();
TextEditingController tempsController = new TextEditingController();
TextEditingController humsController = new TextEditingController();
TextEditingController flipController = new TextEditingController();
