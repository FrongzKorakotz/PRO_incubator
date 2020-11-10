import 'package:flutter/material.dart';
import 'package:incubator/data/firebase.dart';
import 'package:incubator/screen/Log.dart';
import 'package:incubator/screen/Status.dart';
import 'package:incubator/screen/Status3.dart';
import 'package:incubator/screen/control.dart';
import 'package:incubator/screen/Alertth.dart';
import 'package:incubator/screen/SaveChick.dart';
import 'package:incubator/screen/Chickdata.dart';
import 'package:incubator/screen/Manual.dart';
import 'dart:async';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class Status2 extends StatefulWidget {
  @override
  _Status2State createState() => _Status2State();
}
class _Status2State extends State<Status2> {
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
void choiceAction(String choice){
    if(choice == ChooseStatus.Statuss1){
      Navigator.push(context,
      MaterialPageRoute(builder: (context) => Status()),  );
    }else if(choice == ChooseStatus.Statuss2){
      Navigator.push(context,
      MaterialPageRoute(builder: (context) => Status2()),  );
    }else if(choice == ChooseStatus.Statuss3){
      Navigator.push(context,
      MaterialPageRoute(builder: (context) => Status3()),  );
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.only(left: 60.0), child: Text("สถานะของตู้ฟักไข่ที่ 2",style: TextStyle(color: Colors.blueGrey[400]),)),
            backgroundColor: Colors.yellow[300],
        actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: choiceAction,
              itemBuilder: (BuildContext context){
              return ChooseStatus.choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
        ),
      drawer: showDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/img/bgx.png"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(         
            children: <Widget>[
              SizedBox(height:20),
            Row(
            children: [

              SizedBox(width:230),
              Icon(
                MdiIcons.fan,
                color: int.parse(fan1x) > 0 ? Colors.green : Colors.redAccent,
                size: 20,
              ),
            SizedBox(
                width: 10,
              ),
              Icon(
                MdiIcons.lightbulb,
                color: int.parse(light1x) > 0 ? Colors.green : Colors.redAccent,
                size: 20,
              ),SizedBox(
                width: 10,
              ), Icon(
                MdiIcons.waterPump,
                color: int.parse(pumpin1x) > 0 ? Colors.green : Colors.redAccent,
                size: 20,
              ),
              Text("in",style: TextStyle(color:Colors.black)),
            SizedBox(
                width: 10,
              ),
              Icon(
                MdiIcons.waterPump,
                color: int.parse(pumpout1x) > 0 ? Colors.green : Colors.redAccent,
                size: 20,
              ),
              Text("out",style: TextStyle(color:Colors.black))
            
            ],
          ),
              SizedBox(height: 20,),
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  
                  Text('   Temputarure:',style: TextStyle(fontSize: 50,color: Colors.red[300],shadows: [
        Shadow( // bottomLeft
          offset: Offset(-1.5, -1.5),
          color: Colors.white
        ),
        Shadow( // bottomRight
          offset: Offset(1.5, -1.5),
          color: Colors.white
        ),
        Shadow( // topRight
          offset: Offset(1.5, 1.5),
          color: Colors.white
        ),
        Shadow( // topLeft
          offset: Offset(-1.5, 1.5),
          color: Colors.white
        ),
      ])),
             Image.asset("lib/img/theometer.png",height: 70,width: 40,)
                ],
              ),
              Column(
          children: [
             Text(tempupdat2.toString()+" °C",style: TextStyle(fontSize: 50))
              ],
           ),
              SizedBox(height:20),
              Stack(
          overflow: Overflow.clip,
           alignment: Alignment.topLeft,     
          children: [
            Text('    Humudity:',style: TextStyle(fontSize: 50,color: Colors.blue[300],shadows: [
        Shadow( // bottomLeft
          offset: Offset(-1.5, -1.5),
          color: Colors.white
        ),
        Shadow( // bottomRight
          offset: Offset(1.5, -1.5),
          color: Colors.white
        ),
        Shadow( // topRight
          offset: Offset(1.5, 1.5),
          color: Colors.white
        ),
        Shadow( // topLeft
          offset: Offset(-1.5, 1.5),
          color: Colors.white
        ),
      ])),
            Image.asset("lib/img/humidity.png",height: 90,width: 40,)
              ]),
       Text(humupdat2.toString()+" %",style: TextStyle(fontSize: 50)), 
       SizedBox(height: 30,),
       Text('วันที่เริ่มฟัก',style: TextStyle(fontSize: 30),),
            SizedBox(height: 20,),
            Text(dateNow2,style: TextStyle(fontSize: 20),),
            SizedBox(height: 20,),
            Text('วันสิ้นสุดการฟัก',style: TextStyle(fontSize: 30),),
            SizedBox(height: 20,),
            Text(dateEnd2,style: TextStyle(fontSize: 20),)],
          )
        ),
        ), 
    );
  }
  
  Drawer showDrawer() => Drawer(
          child: ListView(
        children: <Widget>[
          showCONTROL(),
          showLogdata(),
          showalertTH(),
          saveChickdata(),
          showChickdata(),
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
          MaterialPageRoute(builder: (value)=>Control());
        Navigator.push(context, route);
      },
    );
  }

  ListTile showalertTH() {
    return ListTile(
      leading: Icon(MdiIcons.thermometerAlert),
      title: Text("บันทึกแจ้งเตือนอุณหภูมิและความชื้น"),
      onTap: () {
        Navigator.pop(context);
        MaterialPageRoute route = 
          MaterialPageRoute(builder: (value)=>Alertth());
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
          MaterialPageRoute(builder: (value)=>Chickdata());
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
}

class ChooseStatus{
  static const String Statuss1 = 'ตู้ที่1';
  static const String Statuss2 = 'ตู้ที่2';
  static const String Statuss3 = 'ตู้ที่3';

  static const List<String> choices = <String>[
    Statuss1,
    Statuss2,
    Statuss3
  ];
}

