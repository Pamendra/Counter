// ignore_for_file: file_names


import 'package:counter/Screens/Service_List.dart';
import 'package:counter/Screens/Station_Select.dart';
import 'package:counter/Sqflite/LocalDB/database_helper.dart';
import 'package:counter/Sqflite/Model/service_model.dart';
import 'package:counter/Utils/ApploadingBar.dart';
import 'package:counter/Utils/colors_constants.dart';
import 'package:counter/Utils/gradient_color.dart';
import 'package:counter/Widgets/TextWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';
import 'package:sqflite/sqflite.dart';



 class TrainStationList extends StatefulWidget {
   const TrainStationList({Key? key}) : super(key: key);

   @override
   State<TrainStationList> createState() => _TrainStationListState();
 }

 class _TrainStationListState extends State<TrainStationList> {
   final TextEditingController searchtrain = TextEditingController();
   final TiplocDatabaseHelper get = TiplocDatabaseHelper();
   DatabaseHelper fetch = DatabaseHelper();
   List<Train?> trainIDList = [];
   List<Train?> searchList = [];
   bool _isLoading = false;

   void _runFilter(String enteredKeyword) {
     List<Train?> results = [];

     if (enteredKeyword.isEmpty) {
       // if the search field is empty or only contains white-space, we'll display all users
       results = trainIDList;
     } else {
       results = trainIDList.where((data) {
         return data!.tiploc.toString().contains(enteredKeyword) ||
             data.description.toString().contains(enteredKeyword);
       }).toList();
       // we use the toLowerCase() method to make it case-insensitive
     }

     // Refresh the UI
     setState(() {
       searchList = results;
       searchList.sort((a, b) => (a?.description ?? '').compareTo(b?.description ?? ''));
     });
   }

   @override
   void initState() {
     // TODO: implement initState

     getTrainListFromLOCAL();

     super.initState();
   }

   getTrainListFromLOCAL() async {

     setState(() {
       _isLoading = true;
     });


     List<Train?> tempList = await get.getTrainsFromDatabase() ;

     setState(() {
       trainIDList = tempList;
       searchList = tempList;
       searchList.sort((a, b) => (a?.description ?? '').compareTo(b?.description ?? ''));
     });



     setState(() {
       _isLoading = false;
     });
   }


   showLoaderDialog(BuildContext context) {
     AlertDialog alert = AlertDialog(
       content: Row(
         // mainAxisAlignment: MainAxisAlignment.center,
         children: [
           const CircularProgressIndicator(
             color: Colors.black,
           ),
           Container(
               margin: const EdgeInsets.only(left: 7), child: const Text("Loading...")),
         ],
       ),
     );
     showDialog(
       barrierDismissible: false,
       context: context,
       builder: (BuildContext context) {
         return alert;
       },
     );
   }


   @override
   Widget build(BuildContext context) {
     return WillPopScope(
       onWillPop: () async{
         final Database database = await openDatabase('my_database.db');
         // Delete the database
         await database.close();
         await deleteDatabase('my_database.db');

         Navigator.of(context).pushAndRemoveUntil(
             MaterialPageRoute(
                 builder: (context) =>  const Station()),
                 (Route route) => false);

         return Future.value(false);
       },
       child: Scaffold(
         backgroundColor: ColorConstants.backgroundappColor,
         appBar: AppBar(
           automaticallyImplyLeading: false,
           backgroundColor: ColorConstants.appcolor,
           title: Center(child: headingTextwithmedwhite(title: 'Station List',)),
         ),
         bottomNavigationBar: InkWell(
             onTap: () async{
               final Database database = await openDatabase('my_database.db');
               // Delete the database
               await database.close();
               await deleteDatabase('my_database.db');

               Navigator.of(context).pushAndRemoveUntil(
                   MaterialPageRoute(
                       builder: (context) =>  const Station()),
                       (Route route) => false);
             },
             child: Container(
               //padding:  EdgeInsets.all(8.sp),
               width: 100.w,
               height: 6.5.h,
               color: ColorConstants.appcolor,
               child:  Center(child: headingTextwithsmallwhite(title: 'Go Back')),
             )),

         body: ModalProgressHUD(
           color: Colors.white,
           opacity: .1,
           progressIndicator: const LoadingBar(),
           inAsyncCall: _isLoading ? true: false,
           child: Stack(
             children:[
               Container(
               height: 1000.h,
               decoration: gradient_login,
               child: SafeArea(
                 child: Padding(
                   padding:  EdgeInsets.only(top: 20.sp,left: 10.sp,right: 10.sp),
                   child: Column(
                       children: [
                         TextFormField(
                           textCapitalization: TextCapitalization.characters,
                           controller: searchtrain,
                           onChanged: _runFilter,
                           style: TextStyle(fontSize: 11.sp,fontFamily: "railLight"),
                           decoration: InputDecoration(
                               focusedBorder: OutlineInputBorder(
                                   borderSide: const BorderSide(width: 3,color: Color(0xFF249238)),
                                   borderRadius: BorderRadius.circular(3.sp)
                               ),
                               filled: true,
                               fillColor: Colors.white,
                               suffixIcon:  Icon(Icons.search,color: ColorConstants.appcolor,),
                               hintText: 'Search',
                               border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(3.sp))),
                         ),

                         Expanded(
                           child: RawScrollbar(
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

                               scrollbarOrientation: ScrollbarOrientation.right,
                               child: ListView.separated(
                                 shrinkWrap: true,
                                 padding: EdgeInsets.zero,
                                 itemCount: searchList.length,
                                 itemBuilder: (BuildContext context, int index) {
                                   return InkWell(
                                     onTap: () async {

                                       showLoaderDialog(context);

                                      // setState(() {
                                      //   _isLoading = true;
                                      // });

                                     await fetch.fetchdata(searchList[index]?.tiploc.toString());

                                       Navigator.pop(context);

                                       Navigator.pop(context, searchList[index]);

                                        // setState(() {
                                        //   _isLoading = false;
                                        // });



                                       // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => TrainList(station: searchList[index]!.tiploc.toString(),)), (route) => false);
                                     },
                                     child: ListTile(
                                       contentPadding: EdgeInsets.zero,
                                       dense: true,
                                       minLeadingWidth: 30,
                                       leading: Icon(
                                         CupertinoIcons.train_style_one,
                                         color: ColorConstants.appcolor,
                                       ),
                                       title: Text(
                                         '${searchList[index]?.description.toString()} - ${searchList[index]?.tiploc.toString()}  ' ?? "",
                                         style: TextStyle(
                                           color: ColorConstants.appcolor,
                                           fontWeight: FontWeight.w500,
                                           fontSize: 10.sp,
                                           fontFamily: "Aleo",
                                         ),
                                         maxLines: 2,
                                         overflow: TextOverflow.ellipsis,
                                       ),

                                     ),
                                   );
                                 },
                                 separatorBuilder: (context, index) {
                                   return const Divider(
                                     color: Colors.black,
                                   );
                                 },
                               )),
                         ),
                       ]
                   ),
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
