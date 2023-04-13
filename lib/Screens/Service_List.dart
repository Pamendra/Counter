
import 'package:counter/Screens/Boarding_Screen.dart';
import 'package:counter/Screens/Station_Select.dart';
import 'package:counter/Screens/Save_Data.dart';
import 'package:counter/Utils/colors_constants.dart';
import 'package:counter/Utils/drawer_logout.dart';
import 'package:counter/Utils/gradient_color.dart';
import 'package:counter/Widgets/TextWidgets.dart';
import 'package:counter/Widgets/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
    // DateTime now = DateTime.now();
    // TimeOfDay time = TimeOfDay.fromDateTime(now);
    // print(time);


    setState(() {
      _isLoading = true;
    });
    await _databaseHelper.fetchdata(widget.station);
    List<ServiceList> trains = await _databaseHelper.getTrainsFromDatabase();
    setState(() {
      _trains = trains;
      _filteredTrains = trains;
      setState(() {
        _isLoading = false;
      });
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
      return originLocation.contains(query) ||
          destinationLocation.contains(query) ||
          headcode.contains(query) ||
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
        /// Clear Service List
        final db = await openDatabase(
            join(await getDatabasesPath(), 'my_databas.db'),
        );
        await db.delete('trainlis');
        Navigator.of(context).pop(
        MaterialPageRoute(
        builder: (context) => const Station()));
        return Future.value(false);
      },
      child: Scaffold(
        drawer: const DrawerLogout(),
        bottomNavigationBar: InkWell(
            onTap: () async{
              /// Clear Service List
              final db = await openDatabase(
                  join(await getDatabasesPath(), 'my_databas.db'),
              );
              await db.delete('trainlis');
              Navigator.of(context).pop(
                  MaterialPageRoute(
                      builder: (context) => const Station()));

              /// Clear Train List
              // final Database database = await openDatabase('my_database.db');
              // // Delete the database
              // await database.close();
              // await deleteDatabase('my_database.db');
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              width: 50,
              height: 50,
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
        backgroundColor: const Color(0xFF024B40),
        // drawer: const DrawerLogout(),
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
                    MaterialPageRoute(builder: (context) => const DataScreen(

                    )),
                  );
                }, icon: const Icon(Icons.data_saver_on,color: Colors.white,size: 30,),)
            ),
          ],
        ),

        body: Stack(
          children: [
            Container(
            decoration: gradient_login,
            child: SafeArea(
              child: Column(
                children: [
                  Container(
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                children: const [
                                  Text('Origin Station',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:"railBold"),),
                                  SizedBox(height: 5,),
                                  Text('Destination Station',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:"railBold"),),
                                ],
                              ),
                            ),

                            const SizedBox(width: 90,),

                            Column(
                              children: const [
                                Text('Arrival',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:"railBold"),),
                                SizedBox(height: 5,),
                                Text('Departure',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.bold,fontFamily:"railBold"),),
                              ],
                            ),
                            const SizedBox(width: 5,),

                            Column(
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
                          return ListView.builder(
                            itemCount: trains!.length,
                            itemBuilder: (context, index) {
                              final train = trains[index];
                              DateTime now = DateTime.now();
                              DateTime originTime = DateTime.parse('2000-01-01 ${trains[index].origin_time}:00');
                              int diffInMinutes = originTime.difference(now).inMinutes;
                              DateTime nextTime = now.add(Duration(minutes: diffInMinutes % 30 == 0 ? 30 : (30 - diffInMinutes % 30)));

                              final isMatch = searchtrain.text.isEmpty ||
                                  train.origin_location.toLowerCase().contains(searchtrain.text.toLowerCase()) || train.headcode.toLowerCase().contains((searchtrain.text.toLowerCase()))
                                  || train.train_uid.toLowerCase().contains((searchtrain.text.toLowerCase())) || train.origin_time.contains((searchtrain.text)) ;

                              if (isMatch) {
                                return InkWell(
                                  onTap: (){
                                    setState(() {
                                        _selectedIndexes.add(index);
                                    });
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Boarding(
                                      origin_location: snapshot.data![index].origin_location,
                                      origin_time: snapshot.data![index].origin_time,
                                       destination_location: snapshot.data![index].destination_location,
                                      destination_time: snapshot.data![index].destination_time,
                                      headcode: snapshot.data![index].headcode,
                                      train_uid: snapshot.data![index].train_uid, station: widget.station,
                                    )));
                                  },
                                  child: Container(
                                    width: 10.w,
                                    height: 12.h,
                                    padding: EdgeInsets.symmetric(horizontal: 7),
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
                                              Text(trains[index].arrival_time.toString() == " " ? '--:--' : trains[index].arrival_time,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                              const SizedBox(height: 20,),
                                              Text(trains[index].departure_time.toString() == " " ? '--:--' : trains[index].departure_time,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
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
                                // If there is no match, return an empty container
                                return Container();
                              }
                            },
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

          Visibility(
            visible: _isLoading,
            child: Padding(
              padding: const EdgeInsets.all(120),
              child: Dialog(
                backgroundColor:
                const Color(0xFF202447).withOpacity(0.2),
                shape: RoundedRectangleBorder(
                    side:
                    const BorderSide(color: Color(0xFF249238), width: 3),
                    borderRadius: BorderRadius.circular(11)),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: ColorConstants.primaryColor, width: 2),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(8)),
                    color: Colors.black87,
                    shape: BoxShape.rectangle,
                  ),
                  child: Lottie.asset(
                      'assets/animations/loading1.json',
                      frameRate: FrameRate.max,
                      height: 50),
                ),
              ),
            ),
          ),
          ]
        ),
      ),
    );
  }
}
