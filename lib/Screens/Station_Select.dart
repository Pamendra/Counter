import 'package:counter/Screens/Train_List_Screen.dart';
import 'package:counter/Screens/Service_List.dart';
import 'package:counter/Sqflite/LocalDB/database_helper.dart';
import 'package:counter/Sqflite/Model/service_model.dart';
import 'package:counter/Utils/colors_constants.dart';
import 'package:counter/Utils/drawer_logout.dart';
import 'package:counter/Utils/gradient_color.dart';
import 'package:counter/widgets/TextWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
  Train? trainData = Train(tiploc: '');

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
      drawer: const DrawerLogout(),
      appBar: AppBar(backgroundColor: ColorConstants.appcolor,
      ),
      body: Stack(
        children: [
          Container(
          height: 1000.h,
          decoration: gradient_login,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SafeArea(
              child:Padding(
                padding: const EdgeInsets.only(top: 50,left: 10,right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children:  [
                        headingTextTwo(title: 'Please enter the Station'),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    const SizedBox(height: 50,),


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
                          borderRadius: BorderRadius.circular(11),
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
                                    : trainID.toString(),
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
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(children: [
                        const SizedBox(
                          height: 50,
                        ),

                        SizedBox(
                          height: 50,
                          width: 200,
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
                                            shape: RoundedRectangleBorder(
                                                side: const BorderSide(color:Color(0xFF249238),width: 3),borderRadius: BorderRadius.circular(11)),
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
                                            content: const Text("please select station",style: TextStyle(color: Colors.white),),
                                          ),
                                        );});
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstants.appcolor,
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
          Visibility(
            visible: _isLoading,
            child: Padding(
              padding: const EdgeInsets.all(120),
              child: Dialog(
                backgroundColor:
                const Color(0xFF202447).withOpacity(0.5),
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
    );
  }
}
