import 'package:firebase_database/firebase_database.dart';
import 'package:incubator/data/Log_model.dart';
import 'package:incubator/data/sqlite_Helper.dart';

String tempupdat = '0';
String humupdat = '0';
String tempupdat2 = '0';
String humupdat2 = '0';
String tempupdat3 = '0';
String humupdat3 = '0';
var chickIdT = '';
var chickIdTT = '';
final tempRef = FirebaseDatabase.instance.reference().child('DHT').child('Temp');
final humRef = FirebaseDatabase.instance.reference().child('DHT').child('Humidity');
final tempRef2 = FirebaseDatabase.instance.reference().child('DHT2').child('Temp');
final humRef2 = FirebaseDatabase.instance.reference().child('DHT2').child('Humidity');
final tempRef3 = FirebaseDatabase.instance.reference().child('DHT3').child('Temp');
final humRef3 = FirebaseDatabase.instance.reference().child('DHT3').child('Humidity');

final chickId = FirebaseDatabase.instance.reference().child('ChickID').child('data');

final qrFire1 = FirebaseDatabase.instance.reference().child('Qrcode').child('ID1');
final qrFire2 = FirebaseDatabase.instance.reference().child('Qrcode').child('ID2');
final qrFire3 = FirebaseDatabase.instance.reference().child('Qrcode').child('ID3');

final passFire1 = FirebaseDatabase.instance.reference().child('Qrcode').child('PASS1');
final passFire2 = FirebaseDatabase.instance.reference().child('Qrcode').child('PASS2');
final passFire3 = FirebaseDatabase.instance.reference().child('Qrcode').child('PASS3');

final datenow = FirebaseDatabase.instance.reference().child('Date').child('DateNow');
final dateend = FirebaseDatabase.instance.reference().child('Date').child('DateEnd');

final datenow2 = FirebaseDatabase.instance.reference().child('Date2').child('DateNow');
final dateend2 = FirebaseDatabase.instance.reference().child('Date2').child('DateEnd');

final datenow3 = FirebaseDatabase.instance.reference().child('Date3').child('DateNow');
final dateend3 = FirebaseDatabase.instance.reference().child('Date3').child('DateEnd');

String qrFormatdata1;
String qrFormatdata2;
String qrFormatdata3;

String passQr;
String passQr2;
String passQr3;

String dateNow;
String dateEnd;
String dateNow2;
String dateEnd2;
String dateNow3;
String dateEnd3;

void readatatemp(){
    tempRef.once().then((DataSnapshot dataSnapshot){
      var tempupd = dataSnapshot.value.toString();
      tempupdat = tempupd;
      //print(tempupdat);
    });
}
void readatahum(){
  humRef.once().then((DataSnapshot dataSnapshot){
    var humupd = dataSnapshot.value.toString();
    humupdat = humupd;
    //print(humupdat);
  });
}
void readatatemp2(){
    tempRef2.once().then((DataSnapshot dataSnapshot){
      var tempupd2 = dataSnapshot.value.toString();
      tempupdat2 = tempupd2;
      //print(tempupdat);
    });
}
void readatahum2(){
  humRef2.once().then((DataSnapshot dataSnapshot){
    var humupd2 = dataSnapshot.value.toString();
    humupdat2 = humupd2;
    //print(humupdat);
  });
}
void readatatemp3(){
    tempRef3.once().then((DataSnapshot dataSnapshot){
      var tempupd3 = dataSnapshot.value.toString();
      tempupdat3 = tempupd3;
      //print(tempupdat);
    });
}
void readatahum3(){
  humRef3.once().then((DataSnapshot dataSnapshot){
    var humupd3 = dataSnapshot.value.toString();
    humupdat3 = humupd3;
    //print(humupdat);
  });
}


void showchickselect(){
  chickId.once().then((DataSnapshot dataSnapshot){
      var chickIdT = dataSnapshot.value.toString();
      chickIdTT = chickIdT;
      //print(chickIdTT);
    });
}

void qrFormat1(){
  qrFire1.once().then((DataSnapshot dataSnapshot){
      var qrFormadata1 = dataSnapshot.value.toString();
      qrFormatdata1 = qrFormadata1;
      //print(qrFormatdata1);
    });
}
void qrFormat2(){
  qrFire2.once().then((DataSnapshot dataSnapshot){
      var qrFormadata2 = dataSnapshot.value.toString();
      qrFormatdata2 = qrFormadata2;
      //print(qrFormatdata2);
    });
}
void qrFormat3(){
  qrFire3.once().then((DataSnapshot dataSnapshot){
      var qrFormadata3 = dataSnapshot.value.toString();
      qrFormatdata3 = qrFormadata3;
      //print(qrFormatdata3);
         });
}

void dateNowR(){
  datenow.once().then((DataSnapshot dataSnapshot){
      var datenow11 = dataSnapshot.value.toString();
      dateNow = datenow11;
      //print(qrFormatdata3);
         });
}

void deteEndR(){
  dateend.once().then((DataSnapshot dataSnapshot){
      var dateend11 = dataSnapshot.value.toString();
      dateEnd = dateend11;
      //print(qrFormatdata3);
         });
}

void dateNowR2(){
  datenow2.once().then((DataSnapshot dataSnapshot){
      var datenow22 = dataSnapshot.value.toString();
      dateNow2 = datenow22;
      //print(qrFormatdata3);
         });
}

void deteEndR2(){
  dateend2.once().then((DataSnapshot dataSnapshot){
      var dateend22 = dataSnapshot.value.toString();
      dateEnd2 = dateend22;
      //print(qrFormatdata3);
         });
}

void dateNowR3(){
  datenow3.once().then((DataSnapshot dataSnapshot){
      var datenow33 = dataSnapshot.value.toString();
      dateNow3 = datenow33;
      //print(qrFormatdata3);
         });
}

void deteEndR3(){
  dateend3.once().then((DataSnapshot dataSnapshot){
      var dateend33 = dataSnapshot.value.toString();
      dateEnd3 = dateend33;
      //print(qrFormatdata3);
         });
}

void passQrR(){
  passFire1.once().then((DataSnapshot dataSnapshot){
      var passFire11 = dataSnapshot.value.toString();
      passQr = passFire11;
      //print(qrFormatdata1);
    });
}
void passQrR2(){
  passFire2.once().then((DataSnapshot dataSnapshot){
      var passFire22 = dataSnapshot.value.toString();
      passQr2 = passFire22;
      //print(qrFormatdata1);
    });
}
void passQrR3(){
  passFire3.once().then((DataSnapshot dataSnapshot){
      var passFire33 = dataSnapshot.value.toString();
      passQr3 = passFire33;
      //print(qrFormatdata1);
    });
}