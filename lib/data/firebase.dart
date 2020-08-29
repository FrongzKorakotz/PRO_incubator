import 'package:firebase_database/firebase_database.dart';


final tempRef = FirebaseDatabase.instance.reference().child('DHT').child('Temp');
final humRef = FirebaseDatabase.instance.reference().child('DHT').child('Humidity');





