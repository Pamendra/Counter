import 'dart:async';
import 'dart:io';
import 'package:counter/Utils/ApploadingBar.dart';
import 'package:http/io_client.dart';
import 'package:path_provider/path_provider.dart' show getApplicationDocumentsDirectory;

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import '../Model/service_model.dart';



class TiplocDatabaseHelper{

  fetchdatalm() async{
    final response = await http.get(Uri.parse('http://192.168.137.183:8000/pcds/api/tiplocs?api_key=6afyVqs6r6bW7DzI&toc=lm,se,lo,le,ch'));

    if (response.statusCode == 200) {
      List<Train> TrainList = [];

      // Parse the JSON response and create a list of Post objects
      List<dynamic> jsonData = jsonDecode(response.body);
      for (var data in jsonData) {
        Train trains = Train.fromJson(data);
        TrainList.add(trains);
      }

      // Open the local database and store the posts
      final Database database = await openDatabase(
        join(await getDatabasesPath(), 'my_database.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE trainlist(tiploc TEXT, crs TEXT, description TEXT)',
          );
        },
        version: 4,
      );

      for (var trains in TrainList) {
        await database.insert('trainlist', trains.toMap());
      }
    } else {
      throw Exception('Failed to fetch trains');
    }
  }


  Future<List<Train>> getTrainsFromDatabase() async {
    final Database database = await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE trainlist(tiploc TEXT, crs TEXT, description TEXT)',
        );
      },
      version: 4,
    );

    final List<Map<String, dynamic>> maps = await database.query('trainlist');

    return List.generate(maps.length, (i) {
      return Train(
        tiploc: maps[i]['tiploc'],
        //crs: maps[i]['crs'],
        description: maps[i]['description'],
      );
    });
  }
}






/// Service DatabaseHelper


class DatabaseHelper {


  fetchdata(String? station) async {



      final httpClient = HttpClient();
      httpClient.connectionTimeout = const Duration(seconds: 120);
      final httpIoClient = IOClient(httpClient);

      final response = await httpIoClient.get(Uri.parse(
      'http://192.168.137.183:8000/pcds/api/manul-count-app-services?selected_dates=2023-06-02_2023-06-02&toc=CC,CH,GN,GW,GX,IL,LE,LM,LO,SE,SN,SW,TL,XR&tiploc=$station&export_type=station&api_key=6afyVqs6r6bW7DzI'));

    // final response = await http.get(Uri.parse('http://192.168.137.166:8000/pcds/api/manul-count-app-services?selected_dates=2023-06-02_2023-06-02&toc=CC,CH,GN,GW,GX,IL,LE,LM,LO,SE,SN,SW,TL,XR&tiploc=$station&export_type=station&api_key=6afyVqs6r6bW7DzI'));

      if (response.statusCode == 200) {
        List<ServiceList> TrainList = [];

        List<dynamic> jsonData = jsonDecode(response.body)['response'] as List<dynamic>;
        for (var data in jsonData) {
          ServiceList trains = ServiceList.fromJson(data);
          TrainList.add(trains);
        }


        final Database database = await openDatabase(
          join(await getDatabasesPath(), 'service_database.db'),
          onCreate: (db, version) {
            return db.execute(
              'CREATE TABLE servicelist(  origin_time TEXT, destination_time  TEXT, origin_location TEXT, destination_location TEXT , headcode  TEXT,  platform  TEXT,  arrival_time   TEXT,  departure_time   TEXT,  crs  TEXT,  joining  TEXT ,  alighting  TEXT,  otd   TEXT, train_uid   TEXT,  toc  TEXT,  date_from  TEXT,  date_to  TEXT,  stp_indicator  TEXT, cancelled INTEGER)',
            );
          },
          version: 4,
        );

        for (var trains in TrainList) {
          await database.insert('servicelist', trains.toMap());
        }
      } else {
        throw Exception('Failed to fetch trains');
      }

  }
  Future<List<ServiceList>> getTrainsFromDatabase() async {
    final Database database = await openDatabase(
      join(await getDatabasesPath(), 'service_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE servicelist(  origin_time TEXT, destination_time  TEXT, origin_location TEXT, destination_location TEXT , headcode  TEXT,  platform  TEXT,  arrival_time   TEXT,  departure_time   TEXT,  crs  TEXT,  joining  TEXT ,  alighting  TEXT,  otd   TEXT, train_uid   TEXT,  toc  TEXT,  date_from  TEXT,  date_to  TEXT,  stp_indicator  TEXT, cancelled INTEGER)',
        );
      },
      version: 4,
    );

    final List<Map<String, dynamic>> maps = await database.query('servicelist');
    // final List<Map<String, dynamic>> maps = await database.query(
    //   'servicelist',
    //   where: 'platform = ?',
    //   whereArgs: [platform],
    // );
    //  final List<Map<String, dynamic>> maps = await database.query(
    //    'servicelist',
    //    where: 'platform IN (${List.generate(platforms.length, (_) => '?').join(', ')})',
    //    whereArgs: platforms,
    //  );

    return List.generate(maps.length, (i) {
      return ServiceList(
        // schedule_id: maps[i]['schedule_id'],
        // location_id: maps[i]['location_id'],
        origin_time: maps[i]['origin_time'],
        destination_time: maps[i]['destination_time'],
        origin_location: maps[i]['origin_location'],
        destination_location: maps[i]['destination_location'],
        headcode: maps[i]['headcode'],
        platform: maps[i]['platform'],
        arrival_time: maps[i]['arrival_time'],
        departure_time: maps[i]['departure_time'],
        crs: maps[i]['crs'],
        joining: maps[i]['joining'],
        alighting: maps[i]['alighting'],
        otd: maps[i]['otd'],
        train_uid: maps[i]['train_uid'],
        toc: maps[i]['toc'],
        date_from: maps[i]['date_from'],
        date_to: maps[i]['date_to'],
        stp_indicator: maps[i]['stp_indicator'],
        cancelled: maps[i]['cancelled'] == 1,
        // destination_tiploc: maps[i]['destination_tiploc'],
        // origin_tiploc: maps[i]['origin_tiploc'],
      );
    });
  }


  Future<List<ServiceList>> getTrainsFromDatabaseplat(List<String?> platforms) async {
    final Database database = await openDatabase(
      join(await getDatabasesPath(), 'service_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE servicelist(  origin_time TEXT, destination_time  TEXT, origin_location TEXT, destination_location TEXT , headcode  TEXT,  platform  TEXT,  arrival_time   TEXT,  departure_time   TEXT,  crs  TEXT,  joining  TEXT ,  alighting  TEXT,  otd   TEXT, train_uid   TEXT,  toc  TEXT,  date_from  TEXT,  date_to  TEXT,  stp_indicator  TEXT, cancelled INTEGER)',
        );
      },
      version: 4,
    );

   // final List<Map<String, dynamic>> maps = await database.query('servicelist');
   //  final List<Map<String, dynamic>> maps = await database.query(
   //    'servicelist',
   //    where: 'platform = ?',
   //    whereArgs: [platform],
   //  );
    final List<Map<String, dynamic>> maps = await database.query(
      'servicelist',
      where: 'platform IN (${List.generate(platforms.length, (_) => '?').join(', ')})',
      whereArgs: platforms,
    );

    return List.generate(maps.length, (i) {
      return ServiceList(
        // schedule_id: maps[i]['schedule_id'],
        // location_id: maps[i]['location_id'],
        origin_time: maps[i]['origin_time'],
        destination_time: maps[i]['destination_time'],
        origin_location: maps[i]['origin_location'],
        destination_location: maps[i]['destination_location'],
        headcode: maps[i]['headcode'],
        platform: maps[i]['platform'],
        arrival_time: maps[i]['arrival_time'],
        departure_time: maps[i]['departure_time'],
        crs: maps[i]['crs'],
        joining: maps[i]['joining'],
        alighting: maps[i]['alighting'],
        otd: maps[i]['otd'],
        train_uid: maps[i]['train_uid'],
        toc: maps[i]['toc'],
        date_from: maps[i]['date_from'],
        date_to: maps[i]['date_to'],
        stp_indicator: maps[i]['stp_indicator'],
        cancelled: maps[i]['cancelled'] == 1,
        // destination_tiploc: maps[i]['destination_tiploc'],
        // origin_tiploc: maps[i]['origin_tiploc'],
      );
    });
  }
}


/// Local DataBase



class LocalDatabase {

  static final _databaseName = "savedatabase.db";
  static final _databaseVersion = 4;

    static final table = 'saveddata';


  static final columnID = 'id';
  static final columnOTD = 'otd';
  static final columnOTA = 'ota';
  static final columnJOIN = 'joining';
  static final columnALIGHT = 'alightning';
  static final columnCOMMENT = 'comment';
  static final columnOLOCATION = 'origin_location';
  static final columnOTIME = 'origin_time';
  static final columnDLOCATION = 'destination_location';
  static final columnDTIME = 'destination_time';
  static final columnDELAY = 'delay';
  static final columnHEADCODE = 'headcode';
  static final columnTRAIN_UID = 'train_uid';
  static final columnSCHEDULEID = 'schedule_id';
  static final columnLOCATIONID = 'location_id';
  static final columnCANCELLED = 'cancelled';
  static final columnORIGINTIPLOC = 'origin_tiploc';
  static final columnDESTINATIONTIPLOC = 'destination_tiploc';
  static final columnTOC= 'toc';
  static final columnPLATFORM= 'platform';
  static final columnARRIVALTIME= 'arrival_time';
  static final columnDEPARTURETIME= 'departure_time';
  static final columnDATEFROM= 'date_from';
  static final columnDATETO= 'date_to';
  static final columnTIPLOC= 'station';

  // make this a singleton class
  LocalDatabase._privateConstructor();
  static final LocalDatabase instance = LocalDatabase._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate,

    );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db!.execute('''
    CREATE TABLE saveddata(
      id INTEGER PRIMARY KEY,
      ota TEXT,
      otd TEXT,
      joining TEXT,
      alightning TEXT,
      comment TEXT,
      origin_location  TEXT,
      origin_time TEXT ,
      destination_location TEXT,
      destination_time TEXT,
      delay TEXT,
      headcode TEXT,
      train_uid TEXT,
      schedule_id TEXT,
      location_id  TEXT,
      cancelled  TEXT,
      destination_tiploc TEXT,
      origin_tiploc TEXT,
      toc TEXT,
      platform TEXT,
      arrival_time TEXT,
      departure_time TEXT,
      date_to TEXT,
      date_from TEXT,
      station TEXT
       )
      ''');

  }

  Future<List<Map<String, dynamic>>> getData() async {

    Database? db = await LocalDatabase.instance.database;

    List<Map<String, dynamic>> rows = await db!.query(LocalDatabase.table);

    // return the data
    return rows;
  }

  Future<void> updateData(int id, String ota, String otd, String join, String alight, String comment, String delay) async {
    Database? db = await LocalDatabase.instance.database;

    // row to update
    Map<String, dynamic> row = {
      LocalDatabase.columnID: id,
      LocalDatabase.columnOTA: ota,
      LocalDatabase.columnOTD: otd,
      LocalDatabase.columnJOIN: join,
      LocalDatabase.columnALIGHT: alight,
      LocalDatabase.columnCOMMENT: comment,
      LocalDatabase.columnDELAY: delay,
    };

    // update the row with the given id
    try {
      // update the row with the given id
      int rowsUpdated = await db!.update('saveddata', row, where: 'id = ?', whereArgs: [id]);
      if (rowsUpdated != 1) {
        throw Exception('Failed to update data with id: $id');
      }
    } catch (e) {
      print('Failed to update data: $e');
    }  }

  Future<Map<String, dynamic>> getDataForId(int id) async {
    Database? db = await LocalDatabase.instance.database;
    List<Map<String, dynamic>> rows = await db!.query(LocalDatabase.table,
        where: '${LocalDatabase.columnID} = ?', whereArgs: [id]);

    if (rows.isNotEmpty) {
      // return the data for the specified ID
      return rows.first;
    } else {
      // return an empty map if no data is found for the specified ID
      return {};
    }
  }



  Future<void> deleteData(int id) async {
    final db = await database;
    await db?.delete(
      'saveddata',
      where: '$columnID = ?',
      whereArgs: [id],
    );
  }



  Future<void> cleanSingleTable(String tableName) async {
    Database? db = await instance.database;
    await db?.rawDelete("Delete from $tableName  ");
  }
}
