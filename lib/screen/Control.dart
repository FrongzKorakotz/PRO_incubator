import 'package:flutter/material.dart';
import 'package:incubator/screen/Alertchick.dart';
import 'package:incubator/screen/Alertth.dart';
import 'package:incubator/screen/Chickdata.dart';
import 'package:incubator/screen/Manual.dart';

class Control extends StatefulWidget {
 @override
  _ControlState createState() => _ControlState();
}

class _ControlState extends State<Control> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Container(
            margin: EdgeInsets.only(left: 90.0), child: Text("CONTROL")),
      ),
      drawer: showDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("lib/img/bg.JPG"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
              children: <Widget>[
                new Text("",style: TextStyle(fontSize: 20,color: Colors.black)),
                new Text("จำนวนวันที่ฟัก",style: TextStyle(fontSize: 20,color: Colors.black)),
                new TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width:3.0 ) ,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width:3.0) ,
                      borderRadius: BorderRadius.all(Radius.circular(30)
                      ) 
                      ),
                    prefixIcon: Icon(Icons.date_range) ,
                    hintText: ""
                  ),
                ),
                new Text("",style: TextStyle(fontSize: 20,color: Colors.black)),
                new Text("อุณหภูมิ",style: TextStyle(fontSize: 20,color: Colors.black)),
                new TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black,width:3.0) ,
                      borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green,width:3.0) ,
                      borderRadius: BorderRadius.all(Radius.circular(30)) 
                      ),
                    prefixIcon: Icon(Icons.confirmation_number) ,
                    hintText: ""
                  ),
                ),
                new Text("",style: TextStyle(fontSize: 20,color: Colors.black)),
                new Text("ความชื้น",style: TextStyle(fontSize: 20,color: Colors.black)),
                new TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black,width:3.0) ,
                      borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green,width:3.0) ,
                      borderRadius: BorderRadius.all(Radius.circular(30)) 
                      ),
                    prefixIcon: Icon(Icons.spa) ,
                    hintText: ""
                  ),
                ),
                new Text("",style: TextStyle(fontSize: 20,color: Colors.black)),
                new Text("จำนวนพลิก รอบต่อวัน",style: TextStyle(fontSize: 20,color: Colors.black)),
                new TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black,width:3.0) ,
                      borderRadius: BorderRadius.all(Radius.circular(30))
                      ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green,width:3.0) ,
                      borderRadius: BorderRadius.all(Radius.circular(30)) 
                      ),
                    prefixIcon: Icon(Icons.hourglass_empty) ,
                    hintText: ""
                  ),
                ),
          const SizedBox(height: 20),
          RaisedButton(
            onPressed: () {},
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(10.0),
              child:
                  const Text('  ยืนยัน  ', style: TextStyle(fontSize: 20)),
            ),),],
          ),
        ),
      ),
    );
  }

  //Widget selectdropdown() => Row(
    //    mainAxisAlignment: MainAxisAlignment.start,
      //  children: [
        //  Container(
          //  margin: EdgeInsets.only(top: 25, left: 25, right: 25),
           // child: DropdownButton(
             // items: _modetype.map((value) {
               // var dropdownMenuItem = DropdownMenuItem(
                 // child: Text(
                  //  value,
                  //),
                  //value: value,
                //);
                //return dropdownMenuItem;
              //}).toList(),
              //onChanged: (selectedmodetype) {
                //setState(() {
                  //selectedmode = selectedmodetype;
                //});
              //},
              //value: selectedmode,
              //hint: Text("กรุณาเลือก", style: TextStyle(fontSize: 20)),
            //),
          //),
        //],
      //);

  Drawer showDrawer() => Drawer(
          child: ListView(
        children: <Widget>[
          showalertchick(),
          showalertTH(),
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
      title: Text("ข้อมูลไก่"),
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
            MaterialPageRoute(builder: (value) => Manual());
        Navigator.push(context, route);
      },
    );
  }
}
