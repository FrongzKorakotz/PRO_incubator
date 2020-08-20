import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

class QRlogin extends StatefulWidget {
  @override
  _QRloginState createState() => _QRloginState();
}



class _QRloginState extends State<QRlogin> {

  String code = "";

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
              Container(
                width: 320.0,
                child: Image.asset("lib/img/logom.png"),
              ),
              Container(width: 220.0,
              child: ClipRRect(
                //ลดเหลี่ยมปุ่ม
                borderRadius: BorderRadius.circular(50),
                child: RaisedButton(color: Colors.teal[400],
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

  scanQrCode()async {
    try{
      final result = await BarcodeScanner.scan();
      setState((){
        code = result as String;
      });
    }catch(e){
      print(e);
    }
  }
}


