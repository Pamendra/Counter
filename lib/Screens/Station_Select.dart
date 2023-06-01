import 'package:counter/Bloc/NetworkBloc/network_bloc.dart';
import 'package:counter/Bloc/NetworkBloc/network_state.dart';
import 'package:counter/Screens/PlatformLiat.dart';
import 'package:counter/Screens/Train_List_Screen.dart';
import 'package:counter/Screens/Service_List.dart';
import 'package:counter/Sqflite/LocalDB/database_helper.dart';
import 'package:counter/Sqflite/Model/service_model.dart';
import 'package:counter/Utils/ApploadingBar.dart';
import 'package:counter/Utils/DrawerNormal.dart';
import 'package:counter/Utils/colors_constants.dart';
import 'package:counter/Utils/drawer_logout.dart';
import 'package:counter/Utils/gradient_color.dart';
import 'package:counter/widgets/TextWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';

class Station extends StatefulWidget {
  const Station({Key? key}) : super(key: key);

  @override
  State<Station> createState() => _StationState();
}

class _StationState extends State<Station> {
  TextEditingController station = TextEditingController();
  final TiplocDatabaseHelper _helper = TiplocDatabaseHelper();
  bool _isLoading = false;
  final DatabaseHelper data = DatabaseHelper();
  String trainID = "";
  String platforrmno = "";
  Train? trainData = Train(tiploc: '', description: '');
  ServiceList? platformdata = ServiceList(origin_time: '', origin_location: '', destination_time: '', destination_location: '', headcode: '', platform: '', arrival_time: '', departure_time: '', crs: '', joining: '', alighting: '', otd: '', train_uid: '', toc: '', date_from: '', date_to: '', stp_indicator: '', cancelled: false);
  String? selectedNumber;


  Future<void> getTrainID(BuildContext context) async {
    /// Check  Auto route data receving
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) =>const TrainStationList()),);
    setState(() {
      if (result.toString() != "null") {
        trainData = result;
        trainID = trainData!.tiploc.toString();
      } else {
        trainID = '';
      }
    });
  }

  Future<void> getPlatform(BuildContext context) async {
    /// Check  Auto route data receving
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) =>const PlatformList()),);
    setState(() {
      if (result.toString() != "null") {
        platformdata = result;
        platforrmno = platformdata!.platform.toString();
      } else {
        platforrmno = '';
      }
    });
  }



  
  Future<void> fetchdata() async{
    setState(() {
      _isLoading = true;
    });
    await _helper.fetchdatalm();
    await data.fetchdata(trainID);
    setState(() {
      _isLoading = false;
    });

}


  @override
  void initState()  {
    fetchdata();

    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerNormal(),
      bottomNavigationBar: Row(children: [
        InkWell(
            onTap: () {
                   if(trainID.isNotEmpty) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                TrainList(station: trainID.toString(), platformdata: platforrmno.toString(),)));
                      }
                      else{
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return  Center(
                                child: AlertDialog(
                                  backgroundColor: const Color(0xFF202447).withOpacity(0.7),
                                  shape: RoundedRectangleBorder(side: const BorderSide(color:Color(0xFF249238),width: 3),borderRadius: BorderRadius.circular(11)),
                                  title: Row(
                                    children: [
                                      const Text('Message',style: TextStyle(color: Colors.white),),
                                      const SizedBox(width: 170,),
                                      InkWell(
                                          onTap: (){
                                            Navigator.pop(context);
                                          },
                                          child: const Icon(Icons.close,color: Colors.white,)),
                                    ],
                                  ),
                                  content: const Text("Please select station",style: TextStyle(color: Colors.white),),
                                ),
                              );});
                      }
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              width: 100.w,
              height: 5.8.h,
              color: ColorConstants.appcolor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    " Continue",
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ],
              ),
            )),
      ]),
      appBar: AppBar(backgroundColor: ColorConstants.appcolor,
        actions: [
          BlocBuilder<NetworkBloc, NetworkState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Icon(
                  state is NetworkFailure ? Icons.cloud_off : Icons.cloud_done,
                  size: 35,
                ),
              );
            },
          ),
        ],
      ),
      body: ModalProgressHUD(
        color: Colors.white,
        opacity: .1,
        progressIndicator:const LoadingBar(),
        inAsyncCall: _isLoading ? true:false,
        child: Stack(
          children: [
            Container(
            height: 1000.h,
            decoration: gradient_login,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SafeArea(
                child:Padding(
                  padding: const EdgeInsets.only(top: 120,left: 10,right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        children:  [
                          Image.asset('assets/images/tracsis.png'),
                        ],
                      ),



                      const SizedBox(height: 20,),

                      GestureDetector(
                        onTap: () {
                          getTrainID(context);
                        },
                        child: Container(
                          width: 100,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  trainID == ""
                                      ? "Select Station"
                                      : '${trainData!.description} - $trainID',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Icon(
                                  CupertinoIcons.train_style_one,
                                  color: ColorConstants.appcolor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),


                // Container(
                //   height: 7.h,
                //   child: DropdownButtonFormField<String>(
                //     value: selectedNumber,
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         selectedNumber = newValue;
                //       });
                //     },
                //     decoration:  InputDecoration(
                //       hintText: 'Select Platform',
                //       filled: true,
                //       fillColor: Colors.white,
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: ColorConstants.appcolor)
                //       ),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10)
                //       ),
                //     ),
                //     items: List<DropdownMenuItem<String>>.generate(
                //       12,
                //           (int index) {
                //         return DropdownMenuItem<String>(
                //           value: (index + 1).toString(),
                //           child: Text('Platform: ${(index + 1).toString()}'),
                //         );
                //       },
                //     ),
                //   ),
                // ),

                      GestureDetector(
                        onTap: () {
                          getPlatform(context);
                        },
                        child: Container(
                          width: 100,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  platforrmno == ""
                                      ? "Select Platform"
                                      : platforrmno,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Icon(
                                  CupertinoIcons.placemark,
                                  color: ColorConstants.appcolor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),


                      // Padding(
                      //   padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                      //   child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.end,
                      //       children: [
                      //         SizedBox(height: 10,),
                      //     Container(
                      //       height: 50,
                      //       width: 200,
                      //       // decoration: BoxDecoration(
                      //       //   borderRadius: BorderRadius.circular(5)
                      //       // ),
                      //       child: ElevatedButton(
                      //           onPressed: () async{
                      //             if(trainID.isNotEmpty) {
                      //                   Navigator.push(context, MaterialPageRoute(builder: (context) => TrainList(station: trainID.toString(),)));
                      //             }
                      //
                      //             else{
                      //               showDialog(
                      //                   context: context,
                      //                   builder: (BuildContext context) {
                      //                     return  Center(
                      //                       child: AlertDialog(
                      //                         backgroundColor: const Color(0xFF202447).withOpacity(0.7),
                      //                         shape: RoundedRectangleBorder(side: const BorderSide(color:Color(0xFF249238),width: 3),borderRadius: BorderRadius.circular(11)),
                      //                         title: Row(
                      //                           children: [
                      //                             const Text('Message',style: TextStyle(color: Colors.white),),
                      //                             const SizedBox(width: 170,),
                      //                             InkWell(
                      //                                 onTap: (){
                      //                                   Navigator.pop(context);
                      //                                 },
                      //                                 child: const Icon(Icons.close,color: Colors.white,)),
                      //                           ],
                      //                         ),
                      //                         content: const Text("Please select station",style: TextStyle(color: Colors.white),),
                      //                       ),
                      //                     );});
                      //             }
                      //           },
                      //           style: ElevatedButton.styleFrom(
                      //             backgroundColor: ColorConstants.appcolor,
                      //             shape: const StadiumBorder(),
                      //           ),
                      //           child: const Text(
                      //             'Search',
                      //             style: TextStyle(fontSize: 21),
                      //           )),
                      //     ),
                      //
                      //   ]),
                      //
                      // ),
                    ],
                  ),
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
