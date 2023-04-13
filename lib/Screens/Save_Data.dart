import 'package:counter/Sqflite/LocalDB/database_helper.dart';
import 'package:counter/Utils/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});





  @override
  DataScreenState createState() => DataScreenState();
}

class DataScreenState extends State<DataScreen> {
  List<Map<String, dynamic>> _data = [];
  final LocalDatabase _localDatabase = LocalDatabase.instance;


  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    // retrieve data from the database
    List<Map<String, dynamic>> data = await _localDatabase.getData();
    Database db = await openDatabase('my_database.db');
    await db.close();
    // update the state with the retrieved data
    setState(() {
      _data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.appcolor,
        title: const Text('Saved Data'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Origin')),
            DataColumn(label: Text('Destination')),
            DataColumn(label: Text('OTA')),
            DataColumn(label: Text('OTD')),
            DataColumn(label: Text('Joining')),
            DataColumn(label: Text('Alightning')),
            DataColumn(label: Text('Comments')),
            DataColumn(label: Text('Edit')),
            DataColumn(label: Text('Delete')),

          ],
          rows: _data.map((row) {
            return DataRow(cells: [
              DataCell(Text(row['id'].toString())),
              DataCell(Text('${row['origin_location']}\n${row['origin_time']}')),
              DataCell(Text('${row['destination_location']}\n${row['destination_time']}')),
              DataCell(Text(row['ota'])),
              DataCell(Text(row['otd'])),
              DataCell(Text(row['joining'])),
              DataCell(Text(row['alightning'])),
              DataCell(Text(row['comment'])),
              DataCell(
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {

                  },
                ),
              ),
              DataCell(
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {

                  },
                ),
              ),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
