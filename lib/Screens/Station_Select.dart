import 'package:counter/Bloc/NetworkBloc/network_bloc.dart';
import 'package:counter/Bloc/NetworkBloc/network_state.dart';
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

  String trainID = "";
  Train? trainData = Train(tiploc: '', description: '');

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

  Future<void> fetchdata() async{
    setState(() {
      _isLoading = true;
    });
    await _helper.fetchdatalm();
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
                      // const SizedBox(height: 50,),


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
                                      : '${trainData!.description.toString()+' - '+ trainID.toString()}',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Icon(
                                  CupertinoIcons.search,
                                  color: ColorConstants.appcolor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: 10,),
                          Container(
                            height: 50,
                            width: 200,
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(5)
                            // ),
                            child: ElevatedButton(
                                onPressed: () async{
                                  if(trainID.isNotEmpty) {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => TrainList(station: trainID.toString(),)));
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
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstants.appcolor,
                                  shape: const StadiumBorder(),
                                ),
                                child: const Text(
                                  'Search',
                                  style: TextStyle(fontSize: 21),
                                )),
                          ),

                        ]),

                      ),
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
