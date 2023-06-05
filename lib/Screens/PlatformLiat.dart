// ignore_for_file: file_names


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



class PlatformList extends StatefulWidget {
  const PlatformList({Key? key}) : super(key: key);

  @override
  State<PlatformList> createState() => _PlatformListState();
}

class _PlatformListState extends State<PlatformList> {
  final TextEditingController searchtrain = TextEditingController();
  final TiplocDatabaseHelper get = TiplocDatabaseHelper();
  DatabaseHelper getdata = DatabaseHelper();
  List<ServiceList?> pfList = [];
  List<ServiceList?> searchList = [];
  bool _isLoading = false;
  List<String> _selectedOptions = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _runFilter(String enteredKeyword) {
    List<ServiceList?> results = [];

    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = pfList;
    } else {
      results = pfList.where((data) {
        return data!.platform.toString().contains(enteredKeyword) ;
      }).toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      searchList = results;
      // searchList.sort((a, b) => (a?.platform ?? '').compareTo(b?.platform ?? ''));
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

    List<ServiceList?> tempList = await getdata.getTrainsFromDatabase();

    Map<String, ServiceList> platformMap = {};

    for (var service in tempList) {
      if (service != null) {
        String platform = service.platform;
        if (!platformMap.containsKey(platform)) {
          platformMap[platform] = service;
        }
      }
    }

    List<ServiceList?> uniqueList = platformMap.values.toList();
    uniqueList.sort((a, b) => a!.platform.compareTo(b!.platform));

    setState(() {
      pfList.clear();
      pfList.addAll(uniqueList);
      _isLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        // final Database database = await openDatabase('my_database.db');
        // // Delete the database
        // await database.close();
        // await deleteDatabase('my_database.db');

        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(
        //         builder: (context) =>  const Station()),
        //         (Route route) => false);
        Navigator.pop(context);

        return Future.value(false);
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorConstants.backgroundappColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorConstants.appcolor,
        ),
        bottomNavigationBar: InkWell(
            onTap: () async{
              // final Database database = await openDatabase('my_database.db');
              // // Delete the database
              // await database.close();
              // await deleteDatabase('my_database.db');
              //
              // /// Clear Service List
              // final db = await openDatabase(
              //   join(await getDatabasesPath(), 'service_database.db'),
              // );
              // await db.delete('servicelist');
             Navigator.pop(context, _selectedOptions);

            },
            child: Container(
             // padding:  EdgeInsets.all(8.sp),
              width: 100.w,
              height: 6.5.h,
              color: ColorConstants.appcolor,
              child:  Center(child: headingTextwithsmallDark(title: 'Continue')),
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
                      padding:  EdgeInsets.only(top: 80,left: 15.sp,right: 15.sp),
                      child: Column(
                          children: [
                            TextFormField(
                              textCapitalization: TextCapitalization.characters,
                              controller: searchtrain,
                              onChanged: _runFilter,

                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(width: 3,color: Color(0xFF249238)),
                                      borderRadius: BorderRadius.circular(11)
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  suffixIcon: const Icon(Icons.search),
                                  hintText: 'Select Platform',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(21))),
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


                                  scrollbarOrientation: ScrollbarOrientation.right,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: pfList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return CheckboxListTile(
                                        contentPadding: EdgeInsets.zero,
                                        dense: true,
                                        value:_selectedOptions.contains(pfList[index]?.platform.toString()),
                                        onChanged: (value) {
                                          setState(() {
                                            if (value!) {
                                              _selectedOptions.add(pfList[index]!.platform.toString());

                                            } else {
                                              _selectedOptions.remove(pfList[index]!.platform.toString());

                                            }
                                          });
                                        },
                                        secondary: Icon(
                                          CupertinoIcons.train_style_one,
                                          color: ColorConstants.appcolor,
                                        ),
                                        title: Text(
                                          '${pfList[index]?.platform.toString()} ' ?? "",
                                          style: TextStyle(
                                            color: ColorConstants.appcolor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            fontFamily: "Aleo",
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
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
