

import 'package:counter/Screens/Service_List.dart';
import 'package:counter/Sqflite/LocalDB/database_helper.dart';
import 'package:counter/Utils/colors_constants.dart';
import 'package:counter/Utils/drawer_logout.dart';
import 'package:counter/Utils/gradient_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:sizer/sizer.dart';
import 'package:sqflite/sqflite.dart';

class Boarding extends StatefulWidget {

  String? origin_location;
  String? origin_time;
  String? destination_location;
  String? destination_time;
  String? headcode;
  String train_uid;
  // String? schedule_id;
  // String? location_id;
  bool? cancelled;
  // String? origin_tiploc;
  // String? destination_tiploc;
  String? station;
  String? toc;
  String? platform;
  String? departure_time;
  String? arrival_time;
  String? date_from;
  String? date_to;


  Boarding({super.key,required this.date_to,required this.date_from,required this.arrival_time,required this.departure_time , required this.platform,required this.toc, required this.station,required this.origin_location,required this.origin_time,required this.destination_location, required this.destination_time, required this.train_uid, required this.headcode,required this.cancelled});

  @override
  State<Boarding> createState() => _BoardingState();
}

class _BoardingState extends State<Boarding> {
  late TextEditingController comment = TextEditingController();
  late TextEditingController _ota = TextEditingController();
  late TextEditingController _otd = TextEditingController();
  late TextEditingController _join = TextEditingController();
  late TextEditingController _alight = TextEditingController();
  late TextEditingController _delay = TextEditingController();

  bool _otaactive = false;
  bool _otDactive = false;
  bool _joinactive = false;
  bool _alightactive = false;
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNod = FocusNode();
  final FocusNode _focusNo = FocusNode();
  final FocusNode _focusN = FocusNode();
  bool _showNumberPicker = false;
  int _selectedNumber = 1;
  // Map<String, dynamic> _data = {};
  List<Map<String, dynamic>> _data = [];
  final LocalDatabase _localDatabase = LocalDatabase.instance;
  bool _allFieldsFilled = false;


  @override
  void dispose() {
    _ota.dispose();
    _otd.dispose();
    _join.dispose();
    _alight.dispose();
    _focusNode.dispose();
    _focusNod.dispose();
    _focusNo.dispose();
    _focusN.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    onListItemTap(widget.train_uid);
    _focusNode.addListener(() {
      setState(() {
        _showNumberPicker = _focusNode.hasFocus;
      });
    });
    _focusNod.addListener(() {
      setState(() {
        _showNumberPicker = _focusNod.hasFocus;
      });
    });
    _focusNo.addListener(() {
      setState(() {
        _showNumberPicker = _focusNo.hasFocus;
      });
    });
    _focusN.addListener(() {
      setState(() {
        _showNumberPicker = _focusN.hasFocus;
      });
    });

    _ota = TextEditingController();
    _otd = TextEditingController();
    _join = TextEditingController();
    _alight = TextEditingController();
    comment = TextEditingController();
    _delay = TextEditingController();
    checkIfAllFieldsFilled();

  }

  // Define an onTap handler for the green color list item
  void onListItemTap(String trainUid) async {
    // Retrieve the details of the clicked item
    Map<String, dynamic>? itemDetails = await getItemDetailsByTrainUid(trainUid);

    // If the item details were found, fill the form fields with the details
    if (itemDetails != null) {
      fillFormFields(itemDetails);
    }
  }


// Define a function to retrieve the details of an item with a specific train_uid
  Future<Map<String, dynamic>?> getItemDetailsByTrainUid(String trainUid) async {
    // Get a reference to the database
    Database? db = await LocalDatabase.instance.database;

    // Query the database for the item with the specified train_uid
    List<Map<String, dynamic>> results = await db!.query(
      LocalDatabase.table,
      where: '${LocalDatabase.columnTRAIN_UID} = ?',
      whereArgs: [trainUid],
    );

    // If there are no results, return null
    if (results.isEmpty) {
      return null;
    }

    // Otherwise, return the first result
    return results.first;
  }

  void fillFormFields(Map<String, dynamic> itemDetails) {
    // Set the text of each controller to the corresponding value from the itemDetails map
    _ota.text = itemDetails[LocalDatabase.columnOTA];
    _otd.text = itemDetails[LocalDatabase.columnOTD];
    _join.text = itemDetails[LocalDatabase.columnJOIN];
    _alight.text = itemDetails[LocalDatabase.columnALIGHT];
    comment.text = itemDetails[LocalDatabase.columnCOMMENT];
    _delay.text = itemDetails[LocalDatabase.columnDELAY];
  }

  void checkIfAllFieldsFilled() {
    // Check whether all required fields have been filled out
    bool allFilled = _ota.text.isNotEmpty &&
        _otd.text.isNotEmpty &&
        _join.text.isNotEmpty &&
        _alight.text.isNotEmpty;

    setState(() {
      _allFieldsFilled = allFilled;
    });
  }
  // Future<void> _getData() async {
  //   // retrieve data from the database
  //   List<Map<String, dynamic>> data = await _localDatabase.getData();
  //   Database db = await openDatabase('my_database.db');
  //   await db.close();
  //   // update the state with the retrieved data
  //   setState(() {
  //     _data = data;
  //   });
  // }
  //
  // Future<void> editData(int id) async {
  //   // Open the database
  //   final Database? db = await _localDatabase.database;
  //
  //   List<Map<String, dynamic>> data = await db!.query(
  //     'my_boarding',
  //     where: 'id = ?',
  //     whereArgs: <int>[id],
  //   );
  //   _ota.text = data[0]['ota'];
  //   _otd.text = data[0]['otd'];
  //   _join.text = data[0]['joining'];
  //   _alight.text = data[0]['alightning'];
  //   comment.text = data[0]['comment'];
  //   _delay.text = data[0]['delay'];
  //
  //   await _localDatabase.updateData(
  //     id,
  //     _ota.text,
  //     _otd.text,
  //     _join.text,
  //     _alight.text,
  //     comment.text,
  //     _delay.text,
  //   );
  //
  //   // update the data on the screen
  //   await _getData();
  //
  // }


  _showInputDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor:const Color(0xFF202447).withOpacity(1),
          shape: RoundedRectangleBorder(side:const BorderSide(color: Color(0xFF249238),width: 3),borderRadius: BorderRadius.circular(11)),
          title: Text('Enter a Value',style: TextStyle(color: Colors.white),),
          content: TextField(
            keyboardType: TextInputType.phone,
            controller: _delay,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(

              )
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL',style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK',style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.of(context).pop(_delay.text);
              },
            ),
          ],
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, MaterialPageRoute(builder: (context) => TrainList(station: widget.station)));
        return Future.value(false);
      },
      child: Scaffold(
        drawer: const DrawerLogout(),
        bottomNavigationBar: InkWell(
            onTap: () async{
              // /// Clear Train List
              // final Database database = await openDatabase('my_database.db');
              // // Delete the database
              // await database.close();
              // await deleteDatabase('my_database.db');

              // /// Clear Service List
              // final db = await openDatabase(
              //   join(await getDatabasesPath(), 'my_databas.db'),
              // );
              // await db.delete('trainlis');


              Navigator.pop(context, MaterialPageRoute(builder: (context) => TrainList(station: widget.station)));

            },
            child: Container(
              padding: const EdgeInsets.all(15),
              width: 50,
              height: 55,
              color: ColorConstants.appcolor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 18,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Go Back',
                    style: TextStyle(color: Colors.white, fontSize: 19),
                  )
                ],
              ),
            )),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorConstants.appcolor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${widget.headcode}',style: const TextStyle(fontWeight: FontWeight.bold),),
              // SizedBox(width: 10,),
              Text('${widget.station}',style: const TextStyle(fontWeight: FontWeight.bold),),
              // SizedBox(width: 10,),
              Text('${widget.train_uid}',style: const TextStyle(fontWeight: FontWeight.w700),),
            ],
          ),
        ),
        body: Container(
         height: 1000.h,
          decoration: gradient_login,

          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [


                Container(
                  height: 60,
                  color: ColorConstants.appcolor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text('${widget.origin_location}',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),),
                            Text('${widget.origin_time}',style: const TextStyle(fontWeight: FontWeight.w700,color: Colors.white),),
                           // Text('${widget.origin_time}'),
                          ],
                        ),

                        const Icon(Icons.arrow_forward,color: Colors.white),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text('${widget.destination_location}',style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white),),
                            Text('${widget.destination_time}',style: const TextStyle(fontWeight: FontWeight.w700,color: Colors.white),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                  const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(top: 8,bottom: 8,right: 15),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                const Text('OTA',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                                const SizedBox(width: 77,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 40.w,
                                    height: 6.h,
                                    child: TextFormField(
                                      maxLength: 4,
                                      focusNode: _focusNode,
                                      onTap: () {
                                        _focusNode.requestFocus();
                                        setState(() {
                                          _otaactive = true;
                                          _otDactive = false;
                                          _joinactive = false;
                                          _alightactive = false;
                                          _selectedNumber = int.tryParse(_ota.text) ?? 0;
                                          _ota.selection = TextSelection.fromPosition(
                                              TextPosition(offset: _ota.text.length));
                                        });
                                      },
                                      controller: _ota,
                                      keyboardType: TextInputType.phone,
                                      onChanged:  (value) {
                                        setState(() {
                                          _selectedNumber = int.tryParse(value) ?? 0;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        counterText: '',
                                        fillColor: Colors.white,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black)
                                        ),
                                        border: OutlineInputBorder(

                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                            child: Row(

                              children:  [
                                const Text('OTD',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                                const SizedBox(width: 77,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 40.w,
                                    height: 6.h,
                                    child: TextFormField(
                                      maxLength: 4,
                                      focusNode: _focusNod,
                                      onChanged:  (value) {
                                        setState(() {
                                          _selectedNumber = int.tryParse(value) ?? 0;
                                        });
                                      },
                                      controller: _otd,
                                      onTap: () {
                                        _focusNod.requestFocus();
                                        setState(() {
                                          _otaactive = false;
                                          _otDactive = true;
                                          _joinactive = false;
                                          _alightactive = false;
                                          _selectedNumber = int.tryParse(_otd.text) ?? 0;
                                          _otd.selection = TextSelection.fromPosition(
                                              TextPosition(offset: _otd.text.length));
                                        });
                                      },
                                      keyboardType: TextInputType.phone,
                                      decoration: const InputDecoration(
                                        counterText: '',
                                        fillColor: Colors.white,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black)
                                        ),
                                        border: OutlineInputBorder(

                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                            child: Row(

                              children: [
                                const Text('JOINING',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                                const SizedBox(width: 42,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: 40.w,
                                    height: 6.h,
                                    child: TextFormField(
                                      maxLength: 4,
                                      focusNode: _focusNo,
                                      onChanged:  (value) {
                                        setState(() {
                                          _selectedNumber = int.tryParse(value) ?? 0;
                                        });
                                      },
                                      controller: _join,
                                      onTap: () {
                                        _focusNo.requestFocus();
                                        setState(() {
                                          _otaactive = false;
                                          _otDactive = false;
                                          _joinactive = true;
                                          _alightactive = false;
                                          _selectedNumber = int.tryParse(_join.text) ?? 0;
                                          _join.selection = TextSelection.fromPosition(
                                              TextPosition(offset: _join.text.length));
                                        });
                                      },
                                      keyboardType: TextInputType.phone,
                                      decoration: const InputDecoration(
                                        counterText: '',
                                        fillColor: Colors.white,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black)
                                        ),
                                        border: OutlineInputBorder(

                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                            child: Row(

                              children: [
                                const Text('ALIGHTINING',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                                const SizedBox(width: 13,),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8,top: 8,bottom: 8),
                                  child: SizedBox(
                                    width: 40.w,
                                    height: 6.h,
                                    child: TextFormField(
                                      maxLength: 4,
                                      focusNode: _focusN,
                                      onChanged:  (value) {
                                        setState(() {
                                          _selectedNumber = int.tryParse(value) ?? 0;
                                        });
                                      },
                                      controller: _alight,
                                      onTap: () {
                                        _focusN.requestFocus();
                                        setState(() {
                                          _otaactive = false;
                                          _otDactive = false;
                                          _joinactive = false;
                                          _alightactive = true;
                                          _selectedNumber = int.tryParse(_alight.text) ?? 0;
                                          _alight.selection = TextSelection.fromPosition(
                                              TextPosition(offset: _alight.text.length));
                                        });
                                      },
                                      keyboardType: TextInputType.phone,
                                      decoration: const InputDecoration(
                                        counterText: '',
                                        fillColor: Colors.white,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black)
                                        ),
                                        border: OutlineInputBorder(

                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),



                      if (_showNumberPicker)
                      RawScrollbar(
                        //trackVisibility: true,
                        thumbColor: ColorConstants.appcolor,
                        trackColor: Colors.white,
                        //thumbVisibility: true,
                        thickness: 5,
                        radius: const Radius.circular(2),

                        child: Container(
                          width: 10.w,
                          child: NumberPicker(
                            selectedTextStyle: const TextStyle(fontSize: 22),
                            value: _selectedNumber,
                            itemHeight: 3.h,
                            itemCount: 10,
                            minValue: 0,
                            maxValue: 1001,
                            onChanged: (value) {
                              setState(() {
                                _selectedNumber = value;

                                if (_otaactive) {
                                  _ota.text = value.toString();
                                 // _ota.text = '$_selectedNumber';
                                  _ota.selection = TextSelection.fromPosition(
                                      TextPosition(offset: _ota.text.length));
                                } else if (_otDactive) {
                                  _otd.text = value.toString();
                                 // _otd.text = '$_selectedNumber';
                                  _otd.selection = TextSelection.fromPosition(
                                      TextPosition(offset: _otd.text.length));
                                }else if (_joinactive) {
                                  _join.text = value.toString();
                                //  _join.text = '$_selectedNumber';
                                  _join.selection = TextSelection.fromPosition(
                                      TextPosition(offset: _join.text.length));
                                }else if (_alightactive) {
                                  _alight.text = value.toString();
                                 // _alight.text = '$_selectedNumber';
                                  _alight.selection = TextSelection.fromPosition(
                                      TextPosition(offset: _alight.text.length));
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: comment ,
                    decoration: InputDecoration(
                        suffixIcon: PopupMenuButton(
                          icon: const Icon(Icons.add),
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuEntry>[
                               const PopupMenuItem(
                                value:'Great',
                                child: Text('Great'),
                              ),
                              const PopupMenuItem(
                                value:  'Good',
                                child: Text('Good'),
                              ),
                              const PopupMenuItem(
                                value:  'Excellent',
                                child: Text('Excellent'),
                              ),
                            ];
                          },
                          onSelected: (value) {
                            setState(() {
                              comment.text = value;
                            });
                          },
                        ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Comments',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11)
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Padding(padding: const EdgeInsets.only(left: 20),
                  child: SizedBox(
                    width: 50.w,
                    height: 5.h,
                    child: ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                    },style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.appcolor
                    ),
                        child: const Text('Cancellation')),
                  ),
                ),
                  const SizedBox(width: 7,),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: SizedBox(height: 5.h,
                        child: ElevatedButton(onPressed: () async {
                          String value = await _showInputDialog();
                          print('The user entered: $value');
                        },style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.appcolor
                        ),
                            child: const Text('Delay'))),
                  )),
                  ]
                ),
                Padding(padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 5.h,
                          child: ElevatedButton(onPressed: (){
                          if(_ota.text.isNotEmpty || _otd.text.isNotEmpty || _join.text.isNotEmpty || _alight.text.isNotEmpty)
                            {
                              // Navigator.pop(context, MaterialPageRoute(builder: (context) => TrainList(station: widget.station,) ));
                              Navigator.pop(context, true);
                              _insert();

                            }else{
                            Fluttertoast.showToast(msg: 'please enter values');
                          }
                          },style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.appcolor

                          ),
                              child: const Text('Save'))),

                      if (_allFieldsFilled)
                        ElevatedButton(onPressed: (){

                        }, child: Text('Update')),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  _insert() async {


    Database? db = await LocalDatabase.instance.database;

    // row to insert
    Map<String, dynamic> row = {
      LocalDatabase.columnHEADCODE  : widget.headcode,
      LocalDatabase.columnOTA : _ota.text,
      LocalDatabase.columnOTD  : _otd.text,
      LocalDatabase.columnJOIN  : _join.text,
      LocalDatabase.columnALIGHT  : _alight.text,
      LocalDatabase.columnCOMMENT  : comment.text,
      LocalDatabase.columnOLOCATION  : widget.origin_location,
      LocalDatabase.columnOTIME  : widget.origin_time,
      LocalDatabase.columnDLOCATION  : widget.destination_location,
      LocalDatabase.columnDTIME  : widget.destination_time,
      LocalDatabase.columnDELAY  : _delay.text,
      LocalDatabase.columnTRAIN_UID  : widget.train_uid,
      // LocalDatabase.columnSCHEDULEID  : widget.schedule_id,
      // LocalDatabase.columnLOCATIONID  : widget.location_id,
      LocalDatabase.columnCANCELLED  : widget.cancelled.toString(),
      // LocalDatabase.columnORIGINTIPLOC  : widget.origin_tiploc,
      // LocalDatabase.columnDESTINATIONTIPLOC  : widget.destination_tiploc,
      LocalDatabase.columnTOC  : widget.toc,
      LocalDatabase.columnPLATFORM  : widget.platform,
      LocalDatabase.columnARRIVALTIME  : widget.arrival_time,
      LocalDatabase.columnDEPARTURETIME  : widget.departure_time,
      LocalDatabase.columnDATEFROM  : widget.date_from,
      LocalDatabase.columnDATETO  : widget.date_to,
      LocalDatabase.columnTIPLOC  : widget.station,
    };
    print(row);
    // do the insert and get the id of the inserted row
    int id = await db!.insert(LocalDatabase.table, row);

    print(await db.query(LocalDatabase.table));
  }

  void updateItemDetails(int id) async {
    // Get a reference to the database
    Database? db = await LocalDatabase.instance.database;

    // Update the item details in the database
    await db!.update(
      LocalDatabase.table,
      {
        LocalDatabase.columnOTA: _ota.text,
        LocalDatabase.columnOTD: _otd.text,
        LocalDatabase.columnJOIN: _join.text,
        LocalDatabase.columnALIGHT: _alight.text,
        LocalDatabase.columnCOMMENT: comment.text,
        LocalDatabase.columnDELAY: _delay.text,
      },
      where: '${LocalDatabase.columnID} = ?',
      whereArgs: [id],
    );
  }


}



