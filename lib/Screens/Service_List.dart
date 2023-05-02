
import 'dart:async';

import 'package:counter/Screens/Boarding_Screen.dart';
import 'package:counter/Screens/ManualEntry.dart';
import 'package:counter/Screens/Station_Select.dart';
import 'package:counter/Utils/ApploadingBar.dart';
import 'package:counter/Utils/colors_constants.dart';
import 'package:counter/Utils/drawer_logout.dart';
import 'package:counter/Utils/gradient_color.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path/path.dart';
import 'package:sizer/sizer.dart';
import 'package:sqflite/sqflite.dart';
import '../Sqflite/LocalDB/database_helper.dart';
import '../Sqflite/Model/service_model.dart';

class TrainList extends StatefulWidget {
  String? station;

  TrainList({super.key, required this.station});

  @override
  State<TrainList> createState() => _TrainListState();
}

class _TrainListState extends State<TrainList> {
  final TextEditingController searchtrain = TextEditingController();
  List<ServiceList> _trains = [];
  List<ServiceList> _filteredTrains = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  bool _isLoading = false;
  final Set<int> _selectedIndexes = {};


  getTrainListFromLOCAL() async {
    setState(() {
      _isLoading = true;
    });
      await _databaseHelper.fetchdata(widget.station);
      List<ServiceList> trains = await _databaseHelper.getTrainsFromDatabase();
      setState(() {
        _trains = trains;
        _filteredTrains = trains;
      });
      setState(() {
        _isLoading = false;
      });
  }



  @override
  void initState() {
    // TODO: implement initState

    getTrainListFromLOCAL();
    searchtrain.addListener(() {
      setState(() {});
    });
    super.initState();

  }

  @override
  void dispose() {
    searchtrain.dispose();
    super.dispose();
  }




  void _filterTrains(String query) {
    List<ServiceList> filteredTrains = _trains.where((train) {
      final originLocation = train.origin_location.toLowerCase();
      final destinationLocation = train.destination_location.toLowerCase();
      final headcode = train.headcode.toLowerCase();
      final trainUid = train.train_uid.toLowerCase();
      final platform = train.platform.toLowerCase();
      return originLocation.contains(query) ||
          destinationLocation.contains(query) ||
          headcode.contains(query) ||
          platform.contains(query) ||
          trainUid.contains(query);
    }).toList();
    setState(() {
      _filteredTrains = filteredTrains;
    });
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        // /// Clear Service List
        // final db = await openDatabase(
        //     join(await getDatabasesPath(), 'my_databas.db'),
        // );
        // await db.delete('trainlis');
        // Navigator.of(context).pop(
        // MaterialPageRoute(
        // builder: (context) => const Station()));
        return Future.value(false);
      },
      child: Scaffold(
        drawer: const DrawerLogout(),
        // bottomNavigationBar: InkWell(
        //     onTap: () async{
        //       /// Clear Service List
        //       final db = await openDatabase(
        //           join(await getDatabasesPath(), 'my_databas.db'),
        //       );
        //       await db.delete('trainlis');
        //       Navigator.of(context).pop(
        //           MaterialPageRoute(
        //               builder: (context) => const Station()));
        //
        //       /// Clear Train List
        //       // final Database database = await openDatabase('my_database.db');
        //       // // Delete the database
        //       // await database.close();
        //       // await deleteDatabase('my_database.db');
        //     },
        //     child: Container(
        //       padding: const EdgeInsets.all(15),
        //       width: 50,
        //       height: 55,
        //       color: ColorConstants.appcolor,
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: const [
        //           Icon(
        //             Icons.arrow_back,
        //             color: Colors.white,
        //             size: 18,
        //           ),
        //           SizedBox(
        //             width: 5,
        //           ),
        //           Text(
        //             'Go Back',
        //             style: TextStyle(color: Colors.white, fontSize: 19),
        //           )
        //         ],
        //       ),
        //     )),
        backgroundColor: const Color(0xFF024B40),
        appBar: AppBar(
          backgroundColor: ColorConstants.appcolor,
          title: Text('Station-${widget.station}',style: TextStyle(fontWeight:FontWeight.w500,color:Colors.white,fontFamily:"Aleo",
              fontSize:15.sp,letterSpacing:1),),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ManualEntry()),
                  );
                }, icon: const Icon(Icons.data_saver_on,color: Colors.white,size: 30,),)
            ),
          ],
        ),

        body: ModalProgressHUD(
          color: Colors.white,
          opacity: .1,
          progressIndicator: const LoadingBar(),
          inAsyncCall: _isLoading? true:false,
          child: Stack(
            children: [
              Container(
              decoration: gradient_login,
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      color: ColorConstants.appcolor,
                      height:55,
                      // decoration: BoxDecoration(
                      //
                      //   borderRadius: BorderRadius.zero,
                      //   border: Border.all(color: Colors.black)
                      // ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text('Origin Station',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:"railBold"),),
                                      SizedBox(height: 5,),
                                      Text('Destination Station',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:"railBold"),),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 85,),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: const [
                                    Text('  Arrival',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:"railBold"),),
                                    SizedBox(height: 5,),
                                    Text('Departure',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:"railBold"),),
                                  ],
                                ),
                                const SizedBox(width: 5,),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: const [
                                    Text('Headcode',style:TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:"railBold"),),
                                    SizedBox(height: 5,),
                                    Text('Train UID',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:"railBold"),),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      width: 250.w,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10,top: 5,right: 10),
                        child: TextFormField(
                          controller: searchtrain,
                          onChanged: (value) {
                            _filterTrains(value.toLowerCase());
                          },
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(width: 3,color: Color(0xFF249238)),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: const Icon(Icons.search),
                              hintText: 'Search',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      ),
                    ),
                    // _trains.isEmpty ?
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   // crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     const SizedBox(height: 300,),
                    //      Center(
                    //       child: Text('No Data Found',style: TextConstants.headingOne,),
                    //     ),
                    //   ],
                    // ): const Text(''),
                    Expanded(
                      child:  FutureBuilder(
                        future: _databaseHelper.getTrainsFromDatabase(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<ServiceList>? trains = snapshot.data;
                            return RawScrollbar(
                              trackVisibility: true,
                              thumbColor: ColorConstants.appcolor,
                              trackColor: Colors.white,
                              trackRadius: const Radius.circular(20),
                              thumbVisibility: true,
                              //always show scrollbar
                              thickness: 8,
                              //width of scrollbar
                              radius: const Radius.circular(20),
                              //corner radius of scrollbar
                              child: ListView.builder(
                                itemCount: trains!.length,
                                itemBuilder: (context, index) {
                                  final train = trains[index];
                                  // DateTime now = DateTime.now();
                                  // DateTime originTime = DateTime.parse('2000-01-01 ${trains[index].origin_time}:00');
                                  // int diffInMinutes = originTime.difference(now).inMinutes;
                                  // DateTime nextTime = now.add(Duration(minutes: diffInMinutes % 30 == 0 ? 30 : (30 - diffInMinutes % 30)));

                                  final isMatch = searchtrain.text.isEmpty ||
                                      train.origin_location.toLowerCase().contains(searchtrain.text.toLowerCase())
                                      || train.headcode.toLowerCase().contains((searchtrain.text.toLowerCase()))
                                      || train.train_uid.toLowerCase().contains((searchtrain.text.toLowerCase()))
                                      || train.arrival_time.replaceAll(':', '').contains(searchtrain.text);
                                  if (isMatch) {
                                    return InkWell(
                                      onTap: () async {

                                        final result = await   Navigator.push(context, MaterialPageRoute(builder: (context) => Boarding(
                                          origin_location: snapshot.data![index].origin_location,
                                          origin_time: snapshot.data![index].origin_time,
                                           destination_location: snapshot.data![index].destination_location,
                                          destination_time: snapshot.data![index].destination_time,
                                          headcode: snapshot.data![index].headcode,
                                          train_uid: snapshot.data![index].train_uid, station: widget.station,
                                        )));
                                        if (result ?? false) {
                                          setState(() {
                                            _selectedIndexes.add(index);
                                          });
                                        }
                                      },
                                      child: Container(
                                        width: 85.w,
                                        height: 12.h,
                                        padding: const EdgeInsets.symmetric(horizontal: 7),
                                        child: Card(
                                          color: _selectedIndexes.contains(index) ? Colors.green : null,
                                          child: ListTile(
                                            leading: Column(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 5,),
                                                Column(
                                                  children: [
                                                Text('${trains[index].origin_time}-${trains[index].origin_location}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),                                     ],
                                                ),
                                                const SizedBox(height: 15,),
                                                Text('${trains[index].destination_time}-${trains[index].destination_location}',style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                                              ],
                                            ),

                                            title:  Padding(
                                              padding: const EdgeInsets.only(top: 20),
                                              child: Column(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(trains[index].arrival_time.toString() == " " ? '--:--' : trains[index].arrival_time,style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                                                  const SizedBox(height: 5,),
                                                  Text(trains[index].departure_time.toString() == " " ? '--:--' : trains[index].departure_time,style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                                                  const SizedBox(height: 5,),
                                                  Text('PF- ${trains[index].platform.toString() == " " ? 'Na': trains[index].platform.toString()}',style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                            ),

                                            trailing: Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(trains[index].headcode,style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                                                  const SizedBox(height: 12,),
                                                  Text(trains[index].train_uid,style: const TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    // If there is no match, return empty container
                                    return Container();
                                  }
                                },
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else {
                            return  Container();
                          }
                        },
                      ),

                    ),
                  ],
                ),
              ),
            ),
            ]
          ),
        ),
      ),
    );
  }
}

