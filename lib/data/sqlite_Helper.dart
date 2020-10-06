import 'package:incubator/data/Log_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:path/path.dart';

class SQLiteHelper{
  final String nameDatabase = 'temphumlog.db';
  final String tableDatabase = 'Timetemphum';
  int version = 1;
  final  String idColumn = 'ID';
  final  String timeColumn = 'Time';
  final  String tempColumn = 'Temp';
  final  String humidityColumn = 'Humidity';
  static Database _database;

  SQLiteHelper(){
    initDatabase();
  }
   Future<Null> initDatabase() async{
     await openDatabase(join(await getDatabasesPath(), nameDatabase), 
     onCreate: (db, version)=>db.execute('CREATE TABLE $tableDatabase ($idColumn INTEGER PRIMARY KEY, $timeColumn TEXT, $tempColumn TEXT, $humidityColumn TEXT)'),version: version);
   } 
  Future<Database> connectedDatabase() async{
    return openDatabase(join(await getDatabasesPath(), nameDatabase));
  }
  Future<Null> insertDatabaseToSQLite(Logmodel logmodel)async{
    Database database = await connectedDatabase();
    try {
      database.insert(tableDatabase, logmodel.toJson(),conflictAlgorithm: ConflictAlgorithm.replace,);
    } catch (e) {
      print('e insertData ==>> ${e.toString()}');
    }
  }
}


