// ignore_for_file: use_build_context_synchronously

import 'package:counter/Screens/Login%20Screen/login_screen.dart';
import 'package:counter/Sqflite/LocalDB/database_helper.dart';
import 'package:counter/Widgets/TextWidgets.dart';
import 'package:counter/Widgets/images_constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sqflite/sqflite.dart';



import 'colors_constants.dart';

class DrawerLogout extends StatelessWidget {
  const DrawerLogout({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                    /// Clear Train list
                    final Database database = await openDatabase('my_database.db');
                    // Delete the database
                    await database.close();
                    await deleteDatabase('my_database.db');

                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                            (Route route) => false);
                    /// Clear Local Database
                    LocalDatabase.instance.cleanSingleTable('my_boarding');
                  }),

            ),

            Padding(
              padding: const EdgeInsets.only(top: 520),
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
        ));
  }
}
