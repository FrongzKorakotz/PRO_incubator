import 'package:firebase_database/firebase_database.dart';

String tempupdat = '0';
String humupdat = '0';
final tempRef = FirebaseDatabase.instance.reference().child('DHT').child('Temp');
final humRef = FirebaseDatabase.instance.reference().child('DHT').child('Humidity');



void readatatemp(){
    tempRef.once().then((DataSnapshot dataSnapshot){
      var tempupd = dataSnapshot.value.toString();
      tempupdat = tempupd;
      print(tempupdat);
    });
}
void readatahum(){
  humRef.once().then((DataSnapshot dataSnapshot){
    var humupd = dataSnapshot.value.toString();
    humupdat = humupd;
    print(humupdat);
  });
}



