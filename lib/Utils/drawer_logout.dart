// ignore_for_file: use_build_context_synchronously

import 'package:counter/Screens/Login%20Screen/login_screen.dart';
import 'package:counter/Screens/Save_Data.dart';
import 'package:counter/Screens/Splash_Screen/splash_screen.dart';
import 'package:counter/Sqflite/LocalDB/database_helper.dart';
import 'package:counter/Utils/drawertextbox.dart';
import 'package:counter/Utils/utils.dart';
import 'package:counter/Widgets/PrimaryButton.dart';
import 'package:counter/Widgets/TextWidgets.dart';
import 'package:counter/Widgets/images_constants.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:sqflite/sqflite.dart';



import 'colors_constants.dart';

class DrawerLogout extends StatelessWidget {
  const DrawerLogout({Key? key}) : super(key: key);
  openAppInfoDialog(BuildContext context) async {
    String user = await Utils().getUsererId();
    bool checkInternet = await Utils.checkInternet();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    print(version);

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(

                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                side: BorderSide(
                    color: ColorConstants.primaryColor, width: 2
                )),
            backgroundColor: ColorConstants.appcolor,
            insetPadding: EdgeInsets.all(20),

            actionsPadding: const EdgeInsets.symmetric(horizontal: 10),
            title: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Text(
                    "App Information",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15.sp,
                        color: Colors.white),
                  ),
                )),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DialogTextbox2(
                        title: "User:", subtitle:user
                    ),
                    DialogTextbox2(title: "App Version:", subtitle: version),
                    DialogTextbox2(
                        title: "Current Status:",
                        subtitle: checkInternet ? "Online" : "Offline"),
                    // DialogTextbox2(
                    //     title: "Last Checked for Updates:", subtitle: "N/A"),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                              title: "Close",
                              onAction: () {
                                Navigator.pop(context, true);
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    )
                  ],
                ),
              )
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Drawer(
          backgroundColor: ColorConstants.appcolor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                height: 50,
              ),
              ListTile(
                leading: const Icon(
                  Icons.close_sharp,
                  color: Colors.white,
                  size: 25,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                    shape: Border(
                        bottom: BorderSide(
                      color: ColorConstants.backgroundappColor,
                    )),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white),
                    ),
                    onTap: () async {
                      // /// Clear Service List
                      // final db = await openDatabase(
                      //   join(await getDatabasesPath(), 'my_databas.db'),
                      // );
                      // await db.delete('trainlis');
                      // /// Clear Train list
                      // final Database database = await openDatabase('my_database.db');
                      // // Delete the database
                      // await database.close();
                      // await deleteDatabase('my_database.db');
                      // var sharedpref = await SharedPreferences.getInstance();
                      // sharedpref.setBool(SplashScreenState.KEYLOGIN, false);

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                              (Route route) => false);
                      /// Clear Local Database
                      LocalDatabase.instance.cleanSingleTable('my_boarding');
                    }),

              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListTile(
                  shape: Border(
                      bottom: BorderSide(
                        color: ColorConstants.backgroundappColor,
                      )),
                  title:const Text('Saved Data', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.white),),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DataScreen()),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListTile(
                  shape: Border(
                      bottom: BorderSide(
                        color: ColorConstants.backgroundappColor,
                      )),
                  title:const Text('App Information', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.white),),
                  onTap: (){
                    openAppInfoDialog(context);
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 400),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(color:ColorConstants.backgroundappColor,thickness: 1),
                    ),

                    SizedBox(height: 2.h,),
                    boxtextSmall(title: "Powered By:"),
                    SizedBox(height: 1.h,),
                    Image.asset(
                      ImageConstants.logoURl,
                      color: Colors.white,
                      height:10.h,
                      width: 100.h,
                      fit: BoxFit.scaleDown,
                    ),
                    SizedBox(height: 1.h,),
                    // boxtextSmall(title: "® Tracsis plc"),
                    SizedBox(height: 2.h,),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
