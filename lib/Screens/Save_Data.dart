// ignore_for_file: use_build_context_synchronously

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


  Future<void> _editData(int id) async {
    // Open the database
    final Database? db = await _localDatabase.database;

    List<Map<String, dynamic>> data = await db!.query(
      'my_boarding',
      where: 'id = ?',
      whereArgs: <int>[id],
    );

    // Show a dialog to get the new values
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Define a form with text fields for each value
        final TextEditingController otaController = TextEditingController();
        final TextEditingController otdController = TextEditingController();
        final TextEditingController joiningController = TextEditingController();
        final TextEditingController alightningController = TextEditingController();
        final TextEditingController commentController = TextEditingController();
        final TextEditingController delayController = TextEditingController();

        otaController.text = data[0]['ota'];
        otdController.text = data[0]['otd'];
        joiningController.text = data[0]['joining'];
        alightningController.text = data[0]['alightning'];
        commentController.text = data[0]['comment'];
        delayController.text = data[0]['delay'];

        return AlertDialog(
          title: const Text('Edit Data'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: otaController,
                  decoration: const InputDecoration(labelText: 'OTA'),
                ),
                TextField(
                  controller: otdController,
                  decoration: const InputDecoration(labelText: 'OTD'),
                ),
                TextField(
                  controller: joiningController,
                  decoration: const InputDecoration(labelText: 'Joining'),
                ),
                TextField(
                  controller: alightningController,
                  decoration: const InputDecoration(labelText: 'Alightning'),
                ),
                TextField(
                  controller: commentController,
                  decoration: const InputDecoration(labelText: 'Comment'),
                ), TextField(
                  controller: delayController,
                  decoration: const InputDecoration(labelText: 'Delay'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // update the row with the new values
                await _localDatabase.updateData(
                  id,
                  otaController.text,
                  otdController.text,
                  joiningController.text,
                  alightningController.text,
                  commentController.text,
                  delayController.text,
                );

                // update the data on the screen
                await _getData();

                // dismiss the dialog
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  /// Delete the data

  Future<void> _deleteData(int id) async {
    // Open the database
    final Database? db = await _localDatabase.database;

    // Delete the data with the given ID
    await db?.delete(
      'my_boarding',
      where: 'id = ?',
      whereArgs: <int>[id],
    );

    // Refresh the data displayed in the UI
    await _getData();
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
        child: DataTableTheme(
          data: const DataTableThemeData(
            dataRowHeight: 48,

            headingRowHeight: 56,
          ),
          child: DataTable(
            columns: const [
              // DataColumn(label: Text('ID')),
              DataColumn(label: Text('HeadCode')),
              DataColumn(label: Text('Origin')),
              DataColumn(label: Text('Destination')),
              DataColumn(label: Text('OTA')),
              DataColumn(label: Text('OTD')),
              DataColumn(label: Text('Joining')),
              DataColumn(label: Text('Alightning')),
              DataColumn(label: Text('Delay')),
              DataColumn(label: Text('Comments')),
              DataColumn(label: Text('Edit')),
              DataColumn(label: Text('Delete')),
            ],
            rows: _data.map((row) {
              return DataRow(cells: [
                // DataCell(Text(row['id'].toString())),
                DataCell(Center(child: Text('${row['headcode']}'))),
                DataCell(Center(child: Text('${row['origin_location']}\n${row['origin_time']}'))),
                DataCell(Center(child: Text('${row['destination_location']}\n${row['destination_time']}'))),
                DataCell(Center(child: Text(row['ota']))),
                DataCell(Center(child: Text(row['otd']))),
                DataCell(Center(child: Text(row['joining']))),
                DataCell(Center(child: Text(row['alightning']))),
                DataCell(Center(child: Text(row['delay']))),
                DataCell(Center(child: Text(row['comment']))),
                DataCell(
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _editData(row['id']);
                    },
                  ),
                ),
                DataCell(
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _deleteData(row['id']);
                    },
                  ),
                ),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}