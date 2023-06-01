// ignore_for_file: file_names


import 'package:counter/Screens/Station_Select.dart';
import 'package:counter/Sqflite/LocalDB/database_helper.dart';
import 'package:counter/Sqflite/Model/service_model.dart';
import 'package:counter/Utils/ApploadingBar.dart';
import 'package:counter/Utils/colors_constants.dart';
import 'package:counter/Utils/gradient_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path/path.dart';
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

    setState(() {
      pfList = tempList;
      Set<String> uniquePlatforms = Set();
      tempList.forEach((train) {
        if (train != null && train.platform.isNotEmpty) {
          uniquePlatforms.add(train.platform);
        }
      });
      List<String> sortedPlatforms = uniquePlatforms.toList()..sort();
      searchList = tempList.where((train) => sortedPlatforms.contains(train?.platform)).toList();
    });




    setState(() {
      _isLoading = false;
    });
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
        ),
        bottomNavigationBar: InkWell(
            onTap: () async{
              final Database database = await openDatabase('my_database.db');
              // Delete the database
              await database.close();
              await deleteDatabase('my_database.db');

              /// Clear Service List
              final db = await openDatabase(
                join(await getDatabasesPath(), 'service_database.db'),
              );
              await db.delete('servicelist');

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) =>  const Station()),
                      (Route route) => false);
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
                      padding: const EdgeInsets.only(top: 80,left: 10,right: 10),
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
                                  //corner radius of scrollbar

                                  scrollbarOrientation: ScrollbarOrientation.right,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: searchList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      bool _isChecked = false;
                                      return InkWell(
                                        onTap: () async {
                                          Navigator.pop(context, searchList[index]);
                                          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => TrainList(station: searchList[index]!.tiploc.toString(),)), (route) => false);
                                        },
                                        child: CheckboxListTile(
                                          contentPadding: EdgeInsets.zero,
                                          dense: true,
                                          value: _isChecked, // Replace _isChecked with your own boolean variable to manage the checkbox state
                                          onChanged: (bool? newValue) {
                                            setState(() {
                                              _isChecked = newValue!; // Update the checkbox state when it's clicked
                                            });
                                          },
                                          secondary: Icon(
                                            CupertinoIcons.train_style_one,
                                            color: ColorConstants.appcolor,
                                          ),
                                          title: Text(
                                            /*isNormalStation ? data.value :*/
                                            '${searchList[index]?.platform.toString()} ' ?? "",
                                            style: TextStyle(
                                              color: ColorConstants.appcolor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
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
