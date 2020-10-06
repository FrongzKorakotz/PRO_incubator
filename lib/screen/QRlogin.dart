import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:incubator/data/firebase.dart';
import 'package:incubator/screen/Status.dart';
import 'package:incubator/screen/Status2.dart';
import 'package:incubator/screen/Status3.dart';

String qrCode = "";
String qrCodex;
class QRlogin extends StatefulWidget {
  @override
  _QRloginState createState() => _QRloginState();
}



class _QRloginState extends State<QRlogin> {
  final passQrInput = TextEditingController();
  final passQrInput2 = TextEditingController();
  final passQrInput3 = TextEditingController();
  void checkQr(){
  if(qrCodex == qrFormatdata1){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0)), 
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ยืนยันรหัสผ่านเพื่อเข้าใช้งานแอพลิเคชัน",textAlign: TextAlign.center,style: TextStyle(fontSize: 17,color: Colors.blueGrey[400])),
                    SizedBox(height: 20,),
                    TextField(
                      controller: passQrInput,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'กรอกพาสเวิสด์ ของตู้ฟักไข่'),
                    ),SizedBox(height: 20,),
                    SizedBox(
                      width: 120.0,
                      child: RaisedButton(
                        onPressed: () {
                            if(passQrInput.text == passQr){
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Status()),  );
                            }
                            else{
                              showDialog(
                                context: context,
                                builder: (BuildContext context){
                                    return AlertDialog(
                                    title: Text("รหัสผ่านผิด"),
                                      content: Text("กรุณกรอกใหม่อีกครั้ง"),
                                      );});
                            }
                            
                        },
                        child: Text(
                          "ยืนยัน",textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xFF1BC0C5),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
    // Navigator.push(context,
    //   MaterialPageRoute(builder: (context) => Status()),  );
  }
  else if(qrCodex == qrFormatdata2){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ยืนยันรหัสผ่านเพื่อเข้าใช้งานแอพลิเคชัน",textAlign: TextAlign.center,style: TextStyle(fontSize: 17,color: Colors.blueGrey[400])),
                    SizedBox(height: 20,),
                    TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'กรอกพาสเวิส ของตู้ฟักไข่'),
                    ),SizedBox(height: 20,),
                    SizedBox(
                      width: 120.0,
                      child: RaisedButton(
                        onPressed: () {
                          if(passQrInput2.text == passQr2){
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Status2()),  );
                            }
                            else{
                              showDialog(
                                context: context,
                                builder: (BuildContext context){
                                    return AlertDialog(
                                    title: Text("รหัสผ่านผิด"),
                                      content: Text("กรุณกรอกใหม่อีกครั้ง"),
                                      );});
                            }
                        },
                        child: Text(
                          "ยืนยัน",textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xFF1BC0C5),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
    // Navigator.push(context,
    //   MaterialPageRoute(builder: (context) => Status2()),  );
  }
  else if(qrCodex == qrFormatdata3){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ยืนยันรหัสผ่านเพื่อเข้าใช้งานแอพลิเคชัน",textAlign: TextAlign.center,style: TextStyle(fontSize: 17,color: Colors.blueGrey[400])),
                    SizedBox(height: 20,),
                    TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'กรอกพาสเวิส ของตู้ฟักไข่'),
                    ),SizedBox(height: 20,),
                    SizedBox(
                      width: 120.0,
                      child: RaisedButton(
                        onPressed: () {
                         if(passQrInput3.text == passQr3){
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Status3()),  );
                            }
                            else{
                              showDialog(
                                context: context,
                                builder: (BuildContext context){
                                    return AlertDialog(
                                    title: Text("รหัสผ่านผิด"),
                                      content: Text("กรุณกรอกใหม่อีกครั้ง"),
                                      );});
                            }
                        },
                        child: Text(
                          "ยืนยัน",textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xFF1BC0C5),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
    // Navigator.push(context,
    //   MaterialPageRoute(builder: (context) => Status3()),  );
  }
  else{
    print(qrCodex + " else");
  }
}
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/img/bg.JPG"),
            fit: BoxFit.cover
          ),
        ),
        child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  
            children: <Widget>[
         Stack( 
           children:<Widget>[
           Text("สแกน QRCode",style: TextStyle(fontSize: 30,foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5
          ..color = Colors.black87,),
        ),
            Text("สแกน QRCode",style: TextStyle(fontSize: 30, color: Colors.grey[300],
      ),
    ),
          ],),
           Stack( 
           children:<Widget>[
           Text("เพื่อเข้าใช้งานแอพพลิเคชัน",style: TextStyle(fontSize: 30,foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5
          ..color = Colors.black87,),
        ),
            Text("เพื่อเข้าใช้งานแอพพลิเคชัน",style: TextStyle(fontSize: 30, color: Colors.grey[300],
      ),
    ),
          ],),
              Container(
                width: 320.0,
                child: Image.asset("lib/img/logom.png"),
              ),
              Container(width: 220.0,
              child: ClipRRect(
                //ลดเหลี่ยมปุ่ม
                borderRadius: BorderRadius.circular(50),
                child: 
                  RaisedButton(color: Colors.teal[400],
                  child: Text("Scan QR-CODE",style: TextStyle(color: Colors.white),),
                  onPressed: () => scanQrCode(),
                    
                ), 
              )
              )
            ],
          )
        ),
      ),
    );
  }

  Future scanQrCode() async {
    try{
      String qrCode = await BarcodeScanner.scan();
      setState((){
       qrCodex = qrCode;
       checkQr();
       print(qrCodex);
      });
    }catch(e){
      print(e);
    }
  }
}




